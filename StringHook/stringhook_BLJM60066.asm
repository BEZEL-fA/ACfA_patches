.name "stringhook"
.hook 0x5e150 ENT5e150
.payload 0x11f8e50 #codecave

ENT5e150: #r0
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
    mfcr r0
    std r0, 0x18(r1)
    mfctr r0
    std r0, 0x20(r1)
    std r6, 0x28(r1)
    std r7, 0x30(r1)
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
    ld r6, 0x0(r3) #r3 content, 0x0~0x20
    std r6, 0x38(r1)
    ld r6, 0x8(r3)
    std r6, 0x40(r1)
    ld r6, 0x10(r3)
    std r6, 0x48(r1)
    ld r6, 0x18(r3)
    std r6, 0x50(r1)
    ld r6, 0x0(r4) #r4 content, 0x0~0x10
    std r6, 0x58(r1)
    ld r6, 0x8(r4)
    std r6, 0x60(r1)
    std r3, 0x68(r1)
    std r4, 0x70(r1)
    std r5, 0x78(r1)
    mflr r0
    std r0, 0x80(r1)
STR_DEFINE:
    lis r6, 0x11f
    ori r6, r6, 0xffa0 #defineaddress
    ld r7, 0x0(r6)
    std r7, 0x0(r4)
    ld r7, 0x8(r6)
    std r7, 0x8(r4)
    lis r5, 0x11f
    ori r5, r5, 0xff00
    bl 0x5e148
STR_RESTORE2:
    ld r0, 0x80(r1)
    mtlr r0
    ld r5, 0x78(r1)
    ld r4, 0x70(r1)
    ld r3, 0x68(r1)
    ld r6, 0x60(r1)
    std r6, 0x8(r4)
    ld r6, 0x58(r1)
    std r6, 0x0(r4)
    ld r6, 0x50(r1)
    std r6, 0x18(r3)
    ld r6, 0x48(r1)
    std r6, 0x10(r3)
    ld r6, 0x40(r1)
    std r6, 0x8(r3)
    ld r6, 0x38(r1)
    std r6, 0x0(r3)
STR_RESTORE:
    std r7, 0x30(r1)
    ld r6, 0x28(r1)
    ld r0, 0x20(r1)
    mtctr r0
    ld r0, 0x18(r1)
    mtcr r0
    blr
