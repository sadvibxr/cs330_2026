.data               # start of data section
# put any global or static variables here
myArr: .quad 1, 2, 3, 4, 5
myArrSize: .quad 5

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
sumOfArrayElements: .string "The Sum of the Array of Elements is %d\n"
factorialResult: .string "The Factorial Result is %d\n"

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===

//--Sum of Array Elements Function--
// description: takes an array of integers and calculates
// sum of elements in the array
// takes: an array of integers and length/size of array
// returns: final sum of array elements
sumOfArrayElementsFunction:
movq $myArr, %rbx # Array pointer in %rbx
movq myArrSize, %rcx # Array size in %rcx (i = 5)
pushq $0 # push 0 onto stack, stores in %rsp (sum = 0)
sumLoop:
// for(i = 5; i == 0; i--)
cmpq $0, %rcx # if(%rcx == 0)
je sumReturn # if %rcx is equl to 0, then return result
movq (%rbx), %r10  # take value of pointer and move to %r10
addq %r10, (%rsp) # take value of %r10 and add to %rsp
addq $8, %rbx # moves to next element in array
subq $1, %rcx # i--
jmp sumLoop # jumps back to start of sum loop unconditionally
sumReturn:
popq %rax # pop %rax off stack
ret # should return value in %rax (should print 15 if array is [1, 2, 3, 4, 5])

// --Factorial Function--
// description: takes a given integer and returns its factorial value
// takes: single integer argument
// returns: returns final factorial value
factorialFunction:
movq $1, %rax # move 1 into %rax (will always return 0 if set to 0)
movq %rdi, %rcx # %rdi (given number is 6) moves to %rcx
factorialLoop:
// for(i = 6; i <= 1; i--)
cmpq $1, %rcx # if (%rcx <= 1)
jle factorialReturn # if %rcx is less than or equal to 1, then return result
imulq %rcx, %rax # %rax *= %rcx
decq %rcx # %rcx--
jmp factorialLoop # jumps back to start of factorial loop unconditionally
factorialReturn:
ret # should return value in %rax (should print 720 if input value is 6)

main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===

// Call Sum of Array Elements Function
call sumOfArrayElementsFunction
movq $sumOfArrayElements, %rdi # puts sum of array of elements in %rdi
movq %rax, %rsi # move %rax to %rsi
xorq %rax, %rax # 0 in %rax
call printf # call print function

// Call Factorial Function
movq $6, %rdi # Puts 6 into %rdi
call factorialFunction # call function
movq $factorialResult, %rdi # puts factorial result string in %rdi
movq %rax, %rsi # move %rax to %rsi
xorq %rax, %rax # 0 out %rax
call printf # call print function


# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return
