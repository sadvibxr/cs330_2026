.data               # start of data section
# put any global or static variables here
userInput: .quad 0 #User Inputs for Prime Factor Function and Fibbonaci Function
array: .quad 2, 4, 6, 8, 10 #Givwn Array
arrayLength: .quad 5 #Given Array Size

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
primeFactorPrompt: .string "Enter a number for the Prime Factorization Function: "
fibPrompt: .string "Enter a number for the Fibbonaci Function: "
linearPrompt: .string "Enter a number for the Linear Search Function: "
binaryPrompt: .string "Enter a number for the Binary Search Function: "
input: .string "%d" #Format for input
output: .string "%d " #Format for output
newLine: .string "\n" # Newline string
numFoundStr: .string "Found at index %ld\n"
numNotFoundStr: .string "Value not found!"

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===

//Prime Factorization Function
#description: takes an integer and finds its prime factors
#takes: an integer 
#returns: prints all prime factors of a number
primeFactorFunction:
pushq %rbx #Push rbx onto stack
movq %rdi, %rax # rdi(user input) into rax
movq $2, %rbx #Put divisor (2) into rbx

primeLoop:
cmpq $1, %rax #If rax is less than or equal to one, then finish loop
jle primeLoopFinish #Jump to end loop
xorq %rdx, %rdx # 0 in rdx
pushq %rax #Push rax onto stack
divq %rbx, %rax #Divide rax by rbx, store in rax, remainder in rdx
cmpq $0, %rdx #If rdx is not zero, then get a new divider
jnz newDivider # Jump to newDivider
addq $8, %rsp # Add 8 to rsp (clear stack pointer)
pushq %rax # Push rax onto stack
movq $output, %rdi # Move output string into rdi
movq %rbx, %rsi # Move rbx into rsi
xorq %rax, %rax # 0 in rax
call printf #Print output
popq %rax #Pop rax off stack
jmp primeLoop # Jump back to start of prime loop

newDivider:
popq %rax #pop rax off stack
incq %rbx #Increment the divider (ex: 2 -> 3)
jmp primeLoop # Jump back to start of prime loop

primeLoopFinish:
popq %rbx # Pop rbx off stack
ret # Finish loop and return

//Fibbonacci Function
#description: a recursive function to compute the n-th Fibbonaci number
#takes: an integer
#returns: prints the n-th fibbonaci number
fibbonaciFunction:
xorq %rax, %rax # 0 in rax (fib(0))
cmpq $0, %rdi # If rdi is equal to 0, then finish loop
je fibLoopFinish # Jump ti finish Loop
movq $1, %rbx # Move 1 into rbx (fib(1))
cmpq $1, %rdi #If rdi is equal to 1, then return 1
je fibOne # Jump to return 1
movq %rdi, %rcx # Set counter to input number
decq %rcx # Decrement rcx

fibLoop:
movq %rbx, %rdx #Move rbx into rdx
addq %rax, %rbx # rax + rbx, stores in rbx
movq %rdx, %rax #Move rdx into rax
decq %rcx #Decrement rcx
jnz fibLoop #If rcx is not zero, then jump back to start of loop
movq %rbx, %rax #Move rbx into rax
jmp fibLoopFinish # Jump to finish loop

fibOne:
movq $1, %rax # Move 1 into rax

fibLoopFinish:
ret # Finish loop and return result

//Linear Search Function
#description: linear searches on a hardcoded array of integers
#takes: an integer key
#returns: the position/index the integer key is at
linearSearchFunction:
xorq %rax, %rax # 0 in rax

linearLoop:
cmpq %rax, %rsi #If rax(index) is not equal to rsi(length), then jump to linearNumNotFound
je linearNumNotFound # Jump to linearNumNotFound
cmpq %rdx, (%rdi, %rax, 8) #If rdx(input number) is equal to (%rdi, %rax, 8) (or array[i]),
# then jump to linearLoopFinish
je linearLoopFinish #Jump to linearLoopFinish
incq %rax #Increment rax (index)
jmp linearLoop #Jump back to start of loop

linearNumNotFound:
movq $-1, %rax # Move -1 into rax if value is not found in array
ret  # return

linearLoopFinish:
ret # Finish loop and return

//Binary Search Function
#description:binary searched on a hardcoded array of integers
#takes: an integer key
#returns: the position/index the integer key is at
binarySearchFunction:
xorq %r8, %r8 #0 in r8 (low)
movq %rsi, %r9 #Move rsi into r9 (array length/high)
decq %r9 #Decrement r9

binaryLoop:
cmpq %r9, %r8 #If r8 is greater than r9, then jump to binaryNumNotFound (low>length)
jg binaryNumNotFound # Jump to binaryNumNotFound
movq %r8, %rax #Move r8 into rax (low)
addq %r9, %rax # Add r9 into rax, store in rax
shrq $1, %rax #Find middle of array ((r8 + r9)/2) (right shift)
movq %rax, %rcx #Move rax into rcx
movq (%rdi, %rcx, 8), %r10 #Move (%rdi, %rcx, 8) into r10
cmpq %rdx, %r10 #If rdx is equal to r10, then jump to binaryNumFound (userinput == array[middle])
je binaryNumFound #Jump to binaryNumFound
jl arrayRight #If r10 is less than r10, then jump to right (check right half of array)
movq %rcx, %r9 #Move rcx into r9 ("high of the left side")
decq %r9 #Decrement r9
jmp binaryLoop #Jump back to start of loop

arrayRight:
movq %rcx, %r8 #Move rcx into r8
incq %r8 #Increment r8
jmp binaryLoop #Jump back to start of binaryLoop

binaryNumNotFound:
movq $-1, %rax #Move -1 into rax
ret #return

binaryNumFound:
ret #return

main:               # start of main() function
# preamble
pushq %rbp #Push rbp on stack
movq %rsp, %rbp #Move rsp to rbp

# === main() code here ===

//Prime Factor Call
movq $primeFactorPrompt, %rdi # Move prime factor prompt string into rdi
xorq %rax, %rax # 0 in rax
call printf # Print out prompt
movq $input, %rdi #Move input format string into rdi
movq $userInput, %rsi #Move user input into rsi
xorq %rax, %rax # 0 in rax
call scanf #Scan user input
movq userInput(%rip), %rdi #Get user input and put into rdi
call primeFactorFunction # Call prime factor function
movq $newLine, %rdi # Move new line string into rdi
call printf # Print new line

//Fibbonaci Call
movq $fibPrompt, %rdi # Move fibbonaci prompt string into rdi
xorq %rax, %rax # 0 in rax
call printf # Print out prompt
movq $input, %rdi # Move input format string into rdi
movq $userInput, %rsi #Move userinput into rsi
xorq %rax, %rax # 0 in rax
call scanf #Scan user input
movq userInput(%rip), %rdi #Get user input and move into rdi
call fibbonaciFunction # Call fibbonaci function
movq $output, %rdi #Move output format string into rdi
movq %rax, %rsi #Move rax into rsi
xorq %rax, %rax # 0 in rax
call printf #Print fibbonaci output
movq $newLine, %rdi # Move new line string into rdi
call printf # Print new line

//Linear Search Call
movq $linearPrompt, %rdi # Move liner search prompt into %rdi
xorq %rax, %rax # 0 in rax
call printf # Print out prompt
movq $input, %rdi #Move input format string into rdi
movq $userInput, %rsi #Move user input into rsi
call scanf #Scan userinput
movq $array, %rdi #Move Array into rdi
movq arrayLength(%rip), %rsi # Move array length into rsi
movq userInput(%rip), %rdx #Move user input into rdx
call linearSearchFunction # Call linear search function
cmpq $-1, %rax #If rax is not equal to -1, then jump to linearNumNotFoundPrint
jne linearNumFoundPrint #Jump to linearNumNotFoundPrint

linearNumNotFoundPrint:
movq $numNotFoundStr, %rdi #Move numNotFoundString into rdi
xorq %rax, %rax # 0 in rax
call printf #Print value not found string
movq $newLine, %rdi # Move new line strin into rdi
call printf # Print new line
jmp binaryPrint # Jumps to next function (binary function)

linearNumFoundPrint:
movq %rax, %rsi #Move rax into rsi
movq $numFoundStr, %rdi #"Found at index -" string into rdi
xorq %rax, %rax # 0 in rax
call printf #Print found index string

binaryPrint:
//Binary Search Call
movq $binaryPrompt, %rdi # Move binary search prompt into rdi
xorq %rax, %rax # 0 in rax
call printf # Print binary prompt
movq $input, %rdi #Move input format string into rdi
movq $userInput, %rsi #Move user input into rsi
call scanf # Scan user input
movq $array, %rdi #Move array into rdi
movq arrayLength(%rip), %rsi # Move array length into rsi
movq userInput(%rip), %rdx # Move user input int rdx
call binarySearchFunction # Call binary search function
cmpq $-1, %rax # If inputted number is not found, then jump to print number not found
je binaryNumNotFoundPrint # Jump to binryNumNotFoundPrint
movq $numFoundStr, %rdi # "Found at index -" string into rdi
movq %rax, %rsi # Move rax into rsi
xorq %rax, %rax # 0 in rax
call printf #Print found index string
jmp binaryPrintFinish # Jump to finish print if num is found

binaryNumNotFoundPrint:
movq $numNotFoundStr, %rdi # "Value not found" stirng into rdi
xorq %rax, %rax # 0 in rax
call printf #Print Value not found
movq $newLine, %rdi # Move new line string into rdi
call printf # Print new line 

binaryPrintFinish:
movq $0, %rax # Move 0 into rax
movq %rbp, %rsp #Move rbp into rsp
popq %rbp # Pop rbp off stack
ret # return

# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return
