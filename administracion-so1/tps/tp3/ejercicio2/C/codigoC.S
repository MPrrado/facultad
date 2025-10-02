	.file	"codigoC.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"INGRESE UN NUMERO ENTRE 1 Y 20: "
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"ERROR EL NUMERO INGRESADO DEBE ESTAR ENTRE 1 Y 20: "
.LC3:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	jmp	.L2
.L3:
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
.L2:
	movl	-32(%rbp), %eax
	testl	%eax, %eax
	jle	.L3
	movl	-32(%rbp), %eax
	cmpl	$20, %eax
	jg	.L3
	movl	$0, -28(%rbp)
	movl	$1, -24(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L4
.L8:
	cmpl	$0, -20(%rbp)
	jne	.L5
	movl	-28(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L6
.L5:
	cmpl	$1, -20(%rbp)
	jne	.L7
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L6
.L7:
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -12(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -28(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L6:
	addl	$1, -20(%rbp)
.L4:
	movl	-20(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jl	.L8
	call	getchar@PLT
	call	getchar@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
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
