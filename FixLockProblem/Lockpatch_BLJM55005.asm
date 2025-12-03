.name "lockpatch_bljm55005"
.hook 0x933230 ENT933060 #detect single lock problem A
.hook 0x93324c ENT93307c #detect single lock problem B
.hook 0x9335e0 ENT933410 #save enemy pointer A
.hook 0x933678 ENT9334a8 #save enemy pointer B
.hook 0x979cd0 ENT979b00 #reset value
.hook 0x9796bc ENT9794ec #detect memory address and make ring buffer
.hook 0x975254 ENT975084 #load enemy pointer A
.hook 0x97531c ENT97514c #load enemy pointer B
.payload 0x11f8e50 #codecave

ENT933060: #cr7 ok
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl FF_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    cmpw cr7, r19, r0 #origin
    b ENT933060_ret
ENT93307c: #cr7 ok
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl FF_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    cmpw cr7, r19, r0 #origin
    b ENT93307c_ret
FF_MAIN:
    ld r0, 0x8(r1)
    cmpwi cr7, r0, 0xff
    bne cr7, FF_END
    std r4, 0x18(r1)
    lis r4, 0x11f
    ori r4, r4, 0xffb4 #0x11fffb4
    stw r0, 0x0(r4)
    ld r4, 0x18(r1)
FF_END:
    blr
ENT933410:
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl SAV_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    stw r29, 0x0(r28) #origin
    b ENT933410_ret
ENT9334a8:
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl SAV_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    stw r29, 0x0(r28) #origin
    b ENT9334a8_ret
SAV_MAIN:
    std r4, 0x18(r1)
    lis r4, 0x11f
    ori r4, r4, 0xffb8 #0x11fffb8
    stw r29, 0x0(r4)
    ld r4, 0x18(r1)
    blr
ENT979b00:
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl RES_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    ld r2, 0x28(r1) #origin
    b ENT979b00_ret
RES_MAIN:
    li r0, 0x0
    lis r2, 0x11f
    ori r2, r2, 0xffb4 #0x11fffb4
    stw r0, 0x0(r2)
    stw r0, 0x4(r2)
    blr
ENT9794ec: #cr7 r24 r23 ok
    stdu r1, -0x400(r1)
    std r0, 0x8(r1) #r0
    mflr r0
    std r0, 0x10(r1) #lr
    bl BUF_MAIN
    ld r0, 0x10(r1)
    mtlr r0
    ld r0, 0x8(r1)
    addi r1, r1, 0x400
    lbz r24, 0x18(r29) #origin
    b ENT9794ec_ret
BUF_MAIN:
    std r4, 0x18(r1)
    lis r24, 0x11f
    ori r24, r24, 0xffc0 #0x11fffc0 base address
    li r23, 0x0 #counter
BUF_FIND:
    add r4, r24, r23 #calculate address to find
    lwz r0, 0x0(r4)
    cmpw cr7, r0, r27
    beq cr7, BUF_SAVE
    addi r23, r23, 0x4
    cmpwi cr7, r23, 0x20
    blt cr7, BUF_FIND
    lwz r23, -0x4(r24) #index first, the value is zero
    add r4, r24, r23 #new address
    addi r23, r23, 0x4
    rlwinm r23, r23, 0, 27, 31 #bitmask
    stw r23, -0x4(r24) #save new value of index
BUF_SAVE:
    stw r27, 0x0(r4) #save memory address
    lwz r23, -0xc(r24) #load flag of single lock problem
    cmpwi cr7, r23, 0xff
    beq cr7, BUF_END
    lwz r23, -0x8(r24) #load enemy pointer
    stw r23, 0x20(r4) #save enemy pointer
BUF_END:
    ld r4, 0x18(r1)
    blr
ENT975084: #cr7 ok
    stdu r1, -0x400(r1)
    mflr r0
    std r0, 0x8(r1) #lr
    std r4, 0x10(r1) #r4
    li r4, 0x1 #flag
    bl LD_MAIN
    ld r4, 0x10(r1)
    ld r0, 0x8(r1)
    mtlr r0
    lwz r0, 0x30(r1) #alternative of origin
    addi r1, r1, 0x400
    b ENT975084_ret
ENT97514c: #cr7 ok
    stdu r1, -0x400(r1)
    mflr r0
    std r0, 0x8(r1) #lr
    std r4, 0x10(r1) #r4
    li r4, 0x2 #flag
    bl LD_MAIN
    ld r4, 0x10(r1)
    ld r0, 0x8(r1)
    mtlr r0
    lwz r0, 0x30(r1) #alternative of origin
    addi r1, r1, 0x400
    b ENT97514c_ret
LD_MAIN:
    std r5, 0x18(r1)
    std r6, 0x20(r1)
    std r7, 0x28(r1)
    lis r5, 0x11f
    ori r5, r5, 0xffc0 #0x11fffc0 base address
    li r6, 0 #counter
LD_FIND:
    add r7, r5, r6 #calculate address
    lwz r7, 0x0(r7) #load memory address
    cmpwi cr7, r4, 0x1
    beq cr7, LD_SUB1
    b LD_SUB2
LD_SUB1:
    addi r7, r7, -0x10 #fix address
    b LD_MAIN2
LD_SUB2:
    addi r7, r7, 0x10 #fix address
LD_MAIN2:
    cmpw cr7, r7, r31
    beq cr7, LD_EQAL
    addi r6, r6, 0x4
    cmpwi cr7, r6, 0x20
    blt cr7, LD_FIND
    lwz r0, 0x10(r31) #origin (backup)
    b LD_END
LD_EQAL:
    add r7, r5, r6 #calculate address
    lwz r0, 0x20(r7) #load enemy pointer
LD_END:
    stw r0, 0x30(r1) #save pointer
    ld r7, 0x28(r1)
    ld r6, 0x20(r1)
    ld r5, 0x18(r1)
    blr