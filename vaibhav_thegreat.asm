.encode mov r0, 1234
.encode mov r1, 4
.encode add r6, r0, r1
.encode mov r2, 1000
.encode mov r3, 50
.encode mov r4, 257
.encode mov r5, 20500
.encode st r0, 0x4d4[r1]
.encode CMP r1, 4
.encode sub r9, r3, r4
.encode BEQ .loop
.encode mul r7, r1, r2
.encode div r8, r2, r3
.encode ld r12, 0x4d4[r1]
.encode .loop 
.encode mov r10, 89