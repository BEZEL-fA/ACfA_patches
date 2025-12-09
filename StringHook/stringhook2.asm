.name "stringhook"
.hook 0x5e150 ENT5e150
.payload 0x11f8e50 #codecave

ENT5e150:
    stdu r1, -0x400(r1) #get stack
    std r0, 0x8(r1) #save r0
    mflr r0
    std r0, 0x10(r1) #save lr
    bl STR_BACKUP #jump to main function
    ld r0, 0x10(r1) #recover lr
    mtlr r0
    ld r0, 0x8(r1) #recover r0
    addi r1, r1, 0x400 #recover stack
    std r29, 0x128(r1) #origin
    b ENT5e150_ret
STR_BACKUP:
    std r6, 0x18(r1) #save r6
    mfcr r6
    std r6, 0x20(r1) #save cr
    std r7, 0x28(r1) #save r7
STR_CHECK:
    lwz r6, 0x0(5)
    lis r7, 0x0045
    ori r7, r7, 0x0043 #0x00450043("EC")
    cmpw cr7, r6, r7
    bne cr7, STR_RESTORE
    lwz r6, 0x4(r5)
    lis r7, 0x004D
    ori r7, r7, 0x0000 #0x00450043("M\0")
    cmpw cr7, r6, r7
    bne cr7, STR_RESTORE
STR_BACKUP2:
    mflr r0
    std r0, 0x30(r1) #save lr2
    mfctr r0
    std r0, 0x38(r1) #save ctr
    std r3, 0x40(r1)
    std r4, 0x48(r1)
    std r5, 0x50(r1)
    std r6, 0x58(r1)
    std r7, 0x60(r1)
    std r8, 0x68(r1)
    std r9, 0x70(r1)
    std r10, 0x78(r1)
    std r11, 0x80(r1)
    std r12, 0x88(r1)
    stfd f0, 0x90(r1)
    stfd f1, 0x98(r1)
STR_MAIN:
    lis r5, 0x11f
    ori r5, r5, 0xff00
    lfd  f0, 0x0(r4)
    lfd  f1, 0x8(r4)
    lis r4, 0x11f
    ori r4, r4, 0xff20
    stfd f0, 0x0(r4)
    stfd f1, 0x8(r4)
    bl 0x5e148
STR_RESTORE2:
    lfd f1, 0x98(r1)
    lfd f0, 0x90(r1)
    ld r12, 0x88(r1)
    ld r11, 0x80(r1)
    ld r10, 0x78(r1)
    ld r9, 0x70(r1)
    ld r8, 0x68(r1)
    ld r7, 0x60(r1)
    ld r6, 0x58(r1)
    ld r5, 0x50(r1)
    ld r4, 0x48(r1)
    ld r3, 0x40(r1)
    li r0, 0x0
    stw r0, 0x8(r3)
    ld r0, 0x38(r1)
    mtctr r0 #restore ctr
    ld r0, 0x30(r1) 
    mtlr r0 #restore lr2
STR_RESTORE:
    ld r7, 0x28(r1) #restore r7
    ld r6, 0x20(r1) 
    mtcr r6 #restore cr
    ld r6, 0x18(r1) #restore r6
    blr