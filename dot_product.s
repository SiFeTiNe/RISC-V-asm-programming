.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
outstr: .string "The dot product is: "
newline: .string "\n"

.text
main:
    # Registers NOT to be used x0 to x4 and x10 to x17; reason to be explain later
    # Registers that we can use x5 to x9 and x18 to x31; reason to be explained later

    # int i, sop = 0;
    addi x5, x0, 5 # let x5 be size and set it to 5
    addi x6, x0, 0 # let x6 be sop and set it to 0

    add x8, x0, x0 # let x8 be i and set it to 0
    la x9, a # loading the address of a to x9
    la x21, b # loading the address of b to x21
for1:
    bge x8, x5, exit # to check if i >= 5 to be continued looping
    slli x18, x8, 2 # set x18 to i*4
    add x24, x9, x18 # add i*4 to the base address of a and put to x24
    lw x27, 0(x24) # store a[i] value into x27

    add x25, x21, x18 # add i*4 to the base address of b and put to x25
    lw x29, 0(x25) # store b[i] value into x29
    
    mul x31, x27, x29 # set a[i] * b[i] into x31
    add x6, x6, x31 # sop += a[i] * b[i];
    
    addi x8, x8, 1 # i++;
    j for1 # next iteration loop
exit:
    addi a0, x0, 4 # ecall mode 4 is to print for the defined string
    la a1, outstr # print "The dot product is: "
    ecall # environment call

    addi a0, x0, 1 # ecall mode 1 is to print for the output
    add a1, x0, x6 # the print data is x6
    ecall # environment call
    
    addi a0, x0, 4 # ecall mode 4 is to print for the defined string
    la a1, newline # print "\n"
    ecall # environment call
    
    addi a0, x0, 10 # ecall mode 10 is to cleanly exit
    ecall # environment call (return 0)