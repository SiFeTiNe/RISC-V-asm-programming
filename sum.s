.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

.text
main:
    # Registers NOT to be used x0 to x4 and x10 to x17; reason to be explain later
    # Registers that we can use x5 to x9 and x18 to x31; reason to be explained later

    # int size=10, i, sum1 = 0, sum2 = 0;
    addi x5, x0, 10 # let x5 be size and set it to 10
    addi x6, x0, 0 # let x6 be sum1 and set it to 0
    addi x7, x0, 0 # let x7 be sum2 and set it to 0
    
    # for(i = 0; i < size; i++)
    #     arr1[i] = i + 1;
    addi x8, x0, 0 # let x8 be i and set it to 0
    la x9, arr1 # loading the address of arr1 to x9
    
loop1:
    bge x8, x5, exit1 # check if i is >= size, if so goto exit1
    # we need to calculate &arr1[i]
    # we need the base address of arr1
    # then, we add an offset of i*4 to the base address
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address of arr1 and put to x19
    addi x20, x8, 1 # set x20 to i + 1
    sw x20, 0(x19) # arr1[i] = i + 1
    addi x8, x8, 1 # i++
    j loop1
    
exit1:

    addi x8, x0, 0 # set i to zero
    la x21, arr2 # loading the address of arr2 to x21
    
loop2:
    bge x8, x5, exit2 # check if i is >= size, if so goto exit2
    # we need to calculate &arr2[i]
    # we need the base address of arr2
    # then, we add an offset of i*4 to the base address
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x21 # add i*4 to the base address of arr2 and put to x19
    add x20, x8, x8 # set x20 to i + i
    sw x20, 0(x19) # arr2[i] = i + i
    addi x8, x8, 1 # i++
    j loop2
    
exit2:

    addi x8, x0, 0 # set i to zero
loop3:
    bge x8, x5, exit3 # check if i >= size, if so exit3
    # sum1 + arr[1]
    # need &arr1[i]
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address of arr1 and put to x19
    lw x20, 0(x19) # x20 has arr1[i]
    add x6, x6, x20 # sum1 = sum1 + arr1[i]
    
    # sum2 + arr2[i]
    add x19, x18, x21 # add i*4 to the base address of arr2 and put to x21
    lw x20, 0(x19) # x20 has arr2[i]
    add x7, x7, x20 # sum2 = sum2 + arr2[i]
    
    addi x8, x8, 1
    j loop3

exit3:
    # print_int
    addi a0, x0, 1
    add a1, x0, x6
    ecall
    
    # print a newline character; use
    addi a0, x0, 4
    la a1, newline
    ecall
    
    # print_int
    addi a0, x0, 1
    add a1, x0, x7
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall
