.name "FixMissleLock_BLJM55005"
.hook 0x7b423c ENT7b406c #entry point
.payload 0x11fffbc #codecave

ENT7b406c:
    cmpwi cr7, r3, 0x0 #phase1 origin return check
    bne cr7, RETURN
    lwz r4, -0x4(r31) #get weapon structure
    lbz r4, -0x2c(r4) #get missile flag
    cmpwi cr7, r4, 0x1 #phase2 missile flag check
    crnot 30, 30
RETURN:
    b ENT7b406c_ret