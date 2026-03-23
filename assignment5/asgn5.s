	.file	"asgn5.c"
	.text
	.section	.rodata
.LC0:
	.string	"Given Array: " //String to print out
.LC1:
	.string	"%d " 
.LC2:
	.string	"Squared Array: " //String to print out
	.text
	.globl	main
	.type	main, @function
main:
.LFB0: // Sets Up Given Array
	.cfi_startproc
	endbr64
	pushq	%rbp //Push %rbp source onto stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp // Moves %rsp(stack pointer) to %rbp(base pointer)
	.cfi_def_cfa_register 6
	subq	$64, %rsp // Subtract 64 from %rsp
	movq	%fs:40, %rax //Move %fs:40 to %rax
	movq	%rax, -8(%rbp) // Moves %rax to %rbp - 8
	xorl	%eax, %eax // Clears register by xoring %eax by itself (?)
	movl	$0, -32(%rbp) // Sets 0 into position 0 of the array (0 -> %rbp - 32)
	movl	$1, -28(%rbp) // Sets 1 into position 1 of the array (1 -> %rbp - 28)
	movl	$2, -24(%rbp) // Sets 2 into position 2 of the array (2 -> %rbp - 24)
	movl	$3, -20(%rbp) // Sets 3 into position 3 of the array (3 -> %rbp - 20)
	movl	$4, -16(%rbp) // Sets 4 into position 4 of the array (4 -> %rbp - 16)
	movl	$5, -12(%rbp) // Sets 5 into position 5 of the array (5 -> %rbp - 12)
	leaq	-32(%rbp), %rax // Set %rbp - 32 to %rax (arrPtr = arr)
	movq	%rax, -40(%rbp) // Moves %rax to %rbp - 40 (sizeof(arr))
	movl	$6, -44(%rbp) //Moves 6 to %rbp - 44 (sizeof(arr[0]))
	leaq	.LC0(%rip), %rax // Takes address of .LC0 (%rip) and sets in %rax (.string "Given Array: ")
	movq	%rax, %rdi // Moves %rax to %rdi
	movl	$0, %eax // Moves 0 into %eax 
	call	printf@PLT //Call print function ("Given Array: ")
	movl	$0, -56(%rbp) //Moves 0 to %rbp - 56
	jmp	.L2 // Jumps to .L2 code
.L3: // Loops through given array to print given array values
	movl	-56(%rbp), %eax // Moves (%rbp) - 56 to %eax
	cltq // (?)
	movl	-32(%rbp,%rax,4), %eax // %eax = (%rbp + %rax * 4) - 32 
	movl	%eax, %esi // Moves %eax to %esi
	leaq	.LC1(%rip), %rax //Takes address of .LC1(%rip) and sets in %rax (.string "%d ")
	movq	%rax, %rdi // Moves %rax to %rdi
	movl	$0, %eax // Moves 0 to %eax (i = 0)
	call	printf@PLT //Call print function (Prints values of given array)
	addl	$1, -56(%rbp) // Adds 1 to %rbp - 56 (increments)
.L2: //1st For Loop Conditional Statement 
	movl	-56(%rbp), %eax // Moves (%rbp) - 56 to %eax
	cmpl	-44(%rbp), %eax //Compares (%rbp) - 44 to %eax (i < size)
	jl	.L3 // Jumps to .L3 code if %rbp - 44 is less than %eax (First loop statement)
	movl	$0, -52(%rbp) // Moves 0 to (%rbp) - 52
	jmp	.L4 //Jumps to .L4 code
.L5: //Squares values in array
	movl	-52(%rbp), %eax // Moves (%rbp) - 52 to %eax (i = 0)
	cltq // (?)
	leaq	0(,%rax,4), %rdx // %rax * 4, value stores in %rdx
	movq	-40(%rbp), %rax // Moves %rbp - 40 to %rax
	addq	%rdx, %rax // Adds %rax to %rdx, value stores in %rax
	movl	(%rax), %edx // Moves value of %rax to %edx
	movl	-52(%rbp), %eax // Moves (%rbp) - 52 to %eax
	cltq
	leaq	0(,%rax,4), %rcx // %rcx = %rax * 4
	movq	-40(%rbp), %rax // Moves value of (%rbp) - 40 to %rax
	addq	%rcx, %rax // Adds %rax to %rcx, value stores in %rax
	movl	(%rax), %eax // Moves value of %rax to %eax
	movl	-52(%rbp), %ecx // Moves value of (%rbp) - 52 to %ecx
	movslq	%ecx, %rcx //Moves %ecx to %rcx
	leaq	0(,%rcx,4), %rsi // %rcx multiplies by 4, value stores in %rsi
	movq	-40(%rbp), %rcx //Moves value of -40(%rbp) to %rcx
	addq	%rsi, %rcx // Adds %rcx to %rsi, value stores in %rcx
	imull	%edx, %eax // Multiplies %edx and %eax, value stores in %eax
	movl	%eax, (%rcx) //Moves %eax to %rcx
	addl	$1, -52(%rbp) //Adds 1 to (%rbp) - 52 (increments, i++)
.L4://2nd For Loop Conditional Statement 
	movl	-52(%rbp), %eax //Moves (%rbp) - 52 to %eax (i = 0)
	cmpl	-44(%rbp), %eax //Comparing (%rbp) - 44 to %eax (i < size)
	jl	.L5 // Jumps to .L5 code if %rbp - 44 is less than %eax
	leaq	.LC2(%rip), %rax // Takes address of .LC2(%rip) and stores in %rax (.string "Squared Array: ")
	movq	%rax, %rdi // Moves %rax to %rdi
	movl	$0, %eax //Moves 0 to %eax
	call	printf@PLT //Call print function ("Squared Array: ")
	movl	$0, -48(%rbp) //Moves 0 to -48(%rbp)
	jmp	.L6 //Jumps to .L6 code
.L7: //Loops through squared array to print out squared values
	movl	-48(%rbp), %eax // Moves (%rbp) - 48 to %eax
	cltq
	movl	-32(%rbp,%rax,4), %eax // %eax = (%rbp + %rax * 4) - 32
	movl	%eax, %esi // Moves %eax to %esi
	leaq	.LC1(%rip), %rax // Takes address of .LC1(%rip), value stores in %rax (.string "%d ")
	movq	%rax, %rdi // Moves %rax to %rdi
	movl	$0, %eax // Moves value 0 to %eax
	call	printf@PLT //Call print function (Prints out squared values)
	addl	$1, -48(%rbp) // Adds 1 to %rbp (increment, i++)
.L6: //3rd For Loop Conditional Statement
	movl	-48(%rbp), %eax // Moves -48(%rbp) to %eax
	cmpl	-44(%rbp), %eax //Comparing -44(%rbp) to %eax (i < size)
	jl	.L7 //Jumps to .L7 code if %rbp is less than %eax
	movl	$0, %eax // Moves value 0 to %eax
	movq	-8(%rbp), %rdx // Moves value of -8(%rbp) to %rdx
	subq	%fs:40, %rdx // Subtract %fs:40 from %rdx
	je	.L9 // Jumpts to .L9 code if %rdx equals 0 (?)
	call	__stack_chk_fail@PLT //Checks if stack fails (?)
.L9:
	leave // Cleans up stack
	.cfi_def_cfa 7, 8
	ret // Return
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
