# throughout the assignment used code through canvas by professor posnett and x86-64 Assembly Language Programming with Ubuntu by Ed jorgenson
# declare variables for For system call used from professor posnett and Ed Jorgensons code
.data
    .equ LF,            10
    .equ NULL,          0
    .equ TRUE,          1
    .equ FALSE,         0
    .equ EXIT_SUCCESS,  0
    .equ STDIN,         0
    .equ STDOUT,        1
    .equ STDERR,        2
    .equ SYS_exit,      1
    .equ SYS_fork,      2
    .equ SYS_read,      3
    .equ SYS_write,     4
    .equ SYS_open,      5
    .equ SYS_close,     6
    .equ SYS_creat,     8
    .equ SYS_time,      10


.text

.globl main
.globl print_digit
.globl usage_out

# set up and start the program
main:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx

    movl $0, %ebx
    movl $0, %edx
# read in arguments taken from the command line
read_loop:
    incl %ebx
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movb (%esi), %cl
# read in the first argument and check if it is a ? or an s if so jump to output_help or zero_edx_negative
deal_with_first:
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movl (%esi), %edx
    #pushl %edx
    andl $65280, %edx
    shrl $8, %edx
    cmpl $63, %edx
    je output_help
    cmpl $104, %edx
    je read_loop
    cmpl $100, %edx
    je read_loop
    cmpl $115, %edx
    je zero_edx_negative
    jmp zero_edx
# zero the edx register and set the ebx register to 3 less than argc value this is the function for when we use signed arithmetic
zero_edx_negative:
    movl $0, %edx
    movl 8(%ebp), %ebx
    subl $3, %ebx
    jmp check_values_negative
# zero the edx and set the ebx register to three less than argc this is for the case with unsigned arithmetic
zero_edx:
    movl $0, %edx
    movl 8(%ebp), %ebx
    subl $3, %ebx
# increase the value of ebx to get the binary number arguments and if less than argc get the values
# if not jump to check operation for unsigned arithmetic
check_values:
    incl %ebx
    cmpl 8(%ebp), %ebx
    jl get_value
    movl 8(%ebp), %ebx
    subl $3, %ebx
    jmp check_operation
# increase the value of ebx to get the binary number arguments and if less than argc get the values
# if not jump to check operation for signed arithmetic
check_values_negative:
    incl %ebx
    cmpl 8(%ebp), %ebx
    jl get_value_negative
    movl 8(%ebp), %ebx
    subl $3, %ebx
# get the operation and for whichever capital letter the operation is jump to the given operations function
check_operation:
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movb (%esi), %cl
    cmpl $91, %edx
    jns deal_with_first
    cmpl $63, %edx
    je deal_with_first
    cmpb $65, %cl
    je  And
    cmpb $66, %cl
    je B_label
    cmpb $67, %cl
    je C_label
    cmpb $68, %cl
    je Diff
    cmpb $69, %cl
    je E_label
    cmpb $70, %cl
    je F_label
    cmpb $71, %cl
    je G_label
    cmpb $72, %cl
    je H_label
    cmpb $73, %cl
    je Inclusive
    cmpb $74, %cl
    je J_label
    cmpb $75, %cl
    je K_label
    cmpb $76, %cl
    je Shift_Left
    cmpb $77, %cl
    je Multiply
    cmpb $78, %cl
    je Negate
    cmpb $79, %cl
    je Ones
    cmpb $80, %cl
    je P_label
    cmpb $81, %cl
    je Q_label
    cmpb $82, %cl
    je Shift_Right
    cmpb $83, %cl
    je Sum
    cmpb $84, %cl
    je Twos
    cmpb $85, %cl
    je U_label
    cmpb $86, %cl
    je V_label
    cmpb $87, %cl
    je W_label
    cmpb $88, %cl
    je Exclusive
    cmpb $89, %cl
    je Y_label
    cmpb $90, %cl
    je Z_label
    movl 8(%ebp), %ebx
    subl $2, %ebx
    jmp format
# find the value of anding the two registers with the binary values stored in them
And:
    andl %edx, %eax
    jmp check_format
# output the usage and exit the program
B_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
C_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# calculate the difference of the two binary values stored in the registers
Diff:
    subl %edx, %eax
    jmp check_format
# output the usage and exit the program
E_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
F_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
G_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
H_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# calculate inclusive or of the two inputted binary values
Inclusive:
    orl %edx, %eax
    jmp check_format
# output the usage and exit the program
J_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
K_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# Shift the binary value stored in eax by distance of edx
Shift_Left:
    cmpl $0, %edx
    jne leftShift
    jmp check_format
# multiply the values in eax and edx registers
Multiply:
    imull %edx, %eax
    jmp check_format
# negate the first register from the second
Negate:
    negl %eax
    jmp check_format
# do the ones compliment on the register with the last entry stored in it
Ones:
    notl %eax
    andl $15, %eax
    jmp check_format
# output the usage and exit the program
P_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
Q_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# shift right second register a distance of the first register
Shift_Right:
    cmpl $0, %edx
    jne rightShift
    jmp check_format
# add the two registers together
Sum:
    addl %edx, %eax
    jmp check_format
# perform twos compliment on the second value
Twos:
    notl %eax
    andl $15, %eax
    addl $1, %eax
    jmp check_format
# output the usage and exit the program
U_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
V_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
W_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# perform the exclusive or operation on the two values given
Exclusive:
    xorl %edx, %eax
    jmp check_format
# output the usage and exit the program
Y_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
# output the usage and exit the program
Z_label:
    movl $output_usage, %esi
    call usage_out
    jmp done
#get the values that are provided off of the command line
get_value:
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movl (%esi), %ecx
    cmpl $91, %ecx
    jl check_values
# check if the characters stored in the registers are binary values for a 1 character
convert_value:
    movl $0, %eax
    andl $16843009, %ecx
    testl $1, %ecx
    jne add_8
    testl $256, %ecx
    jne add_4 
    testl $65536, %ecx
    jne add_2
    testl $16777216, %ecx
    jne add_1
    jmp check_operation
# if there is a 1 in the 8 bit add 8 to the eax register and check other bits
add_8:
    addl $8, %eax
    testl $256, %ecx
    jne add_4
    testl $65536, %ecx
    jne add_2
    testl $16777216, %ecx
    jne add_1
    cmpl $0, %edx
    je store_1
    jmp store_2
# if there is a 1 in the 4 bit add 4 to the eax register and check other bits
add_4:
    addl $4, %eax
    testl $65536, %ecx
    jne add_2
    testl $16777216, %ecx
    jne add_1
    cmpl $0, %edx
    je store_1
    jmp store_2
# if there is a 1 in the 2 bit add 2 to the eax register and check other bits
add_2:
    addl $2, %eax
    testl $16777216, %ecx
    jne add_1
    cmpl $0, %edx
    je store_1
    jmp store_2
# if there is a 1 in the 1 bit add 1 to the eax register and check other bits
add_1:
    addl $1, %eax
    cmpl $0, %edx
    je store_1
    jmp store_2
# store the first of the values into the edx register and check if it is the last value in argv
store_1:
    pushl %eax
    popl %edx
    cmpl 8(%ebp), %ebx
    je check_format
    jmp check_values
# store the second binary string in #eax and continue
store_2:
    jmp check_values
# get the values that are provided off of the command line
get_value_negative:
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movl (%esi), %ecx
    cmpl $91, %ecx
    jl check_values_negative
# check if the characters stored in the registers are binary values for a 1 character
convert_value_negative:
    #pushl %eax
    movl $0, %eax
    andl $16843009, %ecx
    testl $1, %ecx
    jne add_negative_8
    testl $256, %ecx
    jne add_negative_4 
    testl $65536, %ecx
    jne add_negative_2
    testl $16777216, %ecx
    jne add_negative_1
    jmp check_operation
# if there is a 1 in the -8 bit add -8 to the eax register and check other bits
add_negative_8:
    addl $-8, %eax
    testl $256, %ecx
    jne add_negative_4
    testl $65536, %ecx
    jne add_negative_2
    testl $16777216, %ecx
    jne add_negative_1
    cmpl $0, %edx
    je store_negative_1
    jmp store_2
# if there is a 1 in the 4 bit add 4 to the eax register and check other bits
add_negative_4:
    addl $4, %eax
    testl $65536, %ecx
    jne add_negative_2
    testl $16777216, %ecx
    jne add_negative_1
    cmpl $0, %edx
    je store_negative_1
    jmp store_negative_2
# if there is a 1 in the 2 bit add 2 to the eax register and check other bits
add_negative_2:
    addl $2, %eax
    testl $16777216, %ecx
    jne add_negative_1
    cmpl $0, %edx
    je store_negative_1
    jmp store_negative_2
# if there is a 1 in the 1 bit add 1 to the eax register and check other bits
add_negative_1:
    addl $1, %eax
    cmpl $0, %edx
    je store_negative_1
    jmp store_negative_2
# store the first value in argv into the edx register
store_negative_1:
    pushl %eax
    popl %edx
    jmp check_values_negative
#store the second value in argv into the eax register
store_negative_2:
    jmp check_values_negative
#shift left by a certain number of bits in the edx register
leftShift:
    decl %edx
    shll $1, %eax
    jmp Shift_Left
# shift right by a certain number of bits in the edx register
rightShift:
    decl %edx
    shrl $1, %eax
    jmp Shift_Right
# when a ? is put into the command line output the usage of the program
output_help:
    movl $output_usage, %esi
    call usage_out
    jmp done
# move 1 into ebx to get the first argument from argv
check_format:
    movl $1, %ebx
# get the first argument from argv and check if it matches either of the output options
format: 
    movl 12(%ebp), %esi
    movl (%esi,%ebx,4), %esi
    movl (%esi), %edx
    #pushl %edx
    andl $65280, %edx
    shrl $8, %edx
    cmpl $104, %edx
    je hex_output
    cmpl $100, %edx
    je dec_output
    movl $output_usage, %esi
    call usage_out
    jmp done
# if hex  allocate space for storage and store eax in a temp location
hex_output:
    subl $8, %esp
    movl %eax, -4(%ebp)
    movl $0, %edx
# set the shift distance by storing 32 into eax and shifting the number of bits in order to get 4 bits into the lower four bits
set_shift:
    cmpl $32, %edx
    je done
    movl -4(%ebp), %eax
    movl $32, %ecx
    addl $4, %edx
    cmpl $32, %edx
    je hex_output_jumps
    subl %edx, %ecx
# shift the bits the desired number of times
shift_loop:
    shrl $1, %eax
    decl %ecx
    cmpl $0, %ecx
    jne shift_loop
# jump to out put the hex value that is stored in the bottom 4 bits
hex_output_jumps:
    movl %edx, -8(%ebp)
    andl $15, %eax
    cmpl $0, %eax
    je hex_output_0
    cmpl $1, %eax
    je hex_output_1
    cmpl $2, %eax
    je hex_output_2
    cmpl $3, %eax
    je hex_output_3
    cmpl $4, %eax
    je hex_output_4
    cmpl $5, %eax
    je hex_output_5
    cmpl $6, %eax
    je hex_output_5
    cmpl $7, %eax
    je hex_output_7
    cmpl $8, %eax
    je hex_output_8
    cmpl $9, %eax
    je hex_output_0
    cmpl $10, %eax
    je hex_output_A
    cmpl $11, %eax
    je hex_output_B
    cmpl $12, %eax
    je hex_output_C
    cmpl $13, %eax
    je hex_output_D
    cmpl $14, %eax
    je hex_output_E
    cmpl $15, %eax
    je hex_output_F
# output the values in hex by calling print_ascii and get from temporary storage locations
hex_output_0:
    movl $zero_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_1:
    movl $one_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_2:
    movl $two_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_3:
    movl $three_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_4:
    movl $four_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_5:
    movl $five_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_6:
    movl $six_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_7:
    movl $seven_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_8:
    movl $eight_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_9:
    movl $nine_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_A:
    movl $A_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_B:
    movl $B_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_C:
    movl $C_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_D:
    movl $D_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_E:
    movl $E_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
hex_output_F:
    movl $F_string, %esi
    call print_ascii
    movl -4(%ebp), %eax
    movl -8(%ebp), %edx
    jmp set_shift
#output the decimal values using printf from the standard c library
dec_output:
    pushl %eax
    pushl $decimal_output
    call printf
    subl $8, %esp
    jmp done
# code used from the canvas page written by professor possnet
# also from x86-64 Assembly Language Programming with Ubuntu by Ed Jorgenson
# get the desired characters into the ecx register and print using stdout and sys write
print_ascii:
    # Function prologue
    pushl %ebp          # Save the old value of the base pointer
    movl %esp, %ebp
    pushl %ebx     # Set the new base pointer

    movl %esi, %ecx  # Address of the ASCII value to print

    # Call write() to print the ASCII value to standard output
    movl $4, %eax       # System call for writing to standard output
    movl $1, %ebx       # File descriptor for standard output
    movl $1, %edx       # Length of the string to print
    int $0x80           # Call kernel to perform system call

    popl %ebx
    popl %ebp              # Restore the old value of the base pointer and deallocate local variables
    ret                # Return from the function
# code used from the canvas page written by professor possnet
# also from x86-64 Assembly Language Programming with Ubuntu by Ed Jorgenson
usage_out:
    pushl   %ebp
    movl    %esp, %ebp
    push    %ebx

    movl    %esi, %ebx
    movl    $0, %edx

strCountLoop:    
    cmpb    $NULL, (%ebx)       # compare byte against NULL
    je      strCountDone        # byte == NULL, so we're done
    incl    %edx
    incl    %ebx
    jmp     strCountLoop

strCountDone:
    cmpl    $0, %edx
    je      prtDone

# edx, the third argument, now contains the message length

# print the message
#
    movl    %esi,%ecx           # second argument: pointer to message to write
    movl    $STDERR,%ebx        # first argument: file handle (stdout)
    movl    $SYS_write,%eax     # system call number (sys_write)
    int     $0x80               # call kernel using the int instruction (32 bit)

prtDone:
    popl    %ebx
    popl    %ebp
    ret
done:
    popl %ebx
    leave
    ret
ascii_fmt:
    .ascii "%c"
addition_carry:
    .ascii " C"
addotion_overflow:
    .ascii " O"
my_string:
    .ascii ""
my_value:
    .byte 'A'
zero_string:
    .ascii "0"
one_string:
    .ascii "1"
two_string:
    .ascii "2"
three_string:
    .ascii "3"
four_string:
    .ascii "4"
five_string:
    .ascii "5"
six_string:
    .ascii "6"
seven_string:
    .ascii "7"
eight_string:
    .ascii "8"
nine_string:
    .ascii "9"
A_string:
    .ascii "A"
B_string:
    .ascii "B"
C_string:
    .ascii "C"
D_string:
    .ascii "D"
E_string:
    .ascii "E"
F_string:
    .ascii "F"
decimal_output:
    .ascii "%d"
hexadecimal:
    .ascii "%c"
output_usage:
    .ascii "Usage: binco [<option>] [<operator>] <arg1> [<arg2>]"