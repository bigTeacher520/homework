.data
    sortarray:
        .space 40
    separate:
        .asciiz " "
    line:
        .asciiz "\n"
		
.text
.globl main
main:
	la $t0,sortarray #数组起始地址
	add $t1,$t0,$0
	addi $t2,$0,0     #i=0
	input:
		li $v0, 5        #输入整型数据
        syscall
        sw $v0, 0($t1)
		addi $t1,$t1,4 #t1为t1的下一个地址
		addi $t2,$t2,1 #i++
		slt $t3,$t2,10   #i<10
		beq $t3,0,endinput
		j input
		
	endinput:
		addi $t2,$0,0			#size=0
		addi $t3,$0,0			#i=0
		add $t4,$t0,$0			#t4首地址
		inner:					#进入循环
			slt $s0,$t3,9		#i<9
			beq $s0,0,judge	
			lw $t6, 0($t4)            #$t6 = a[j]
			lw $t7, 4($t4)            #$t7 = a[j + 1]
			slt $s0, $t6, $t7
			beq $s0,1,swap
			addi $t4,$t4,4
			addi $t3,$t3,1
			j inner
			judge:
				beq $t2,0,outloop
				j endinput
		swap:
			sw $t6, 4($t4)            
			sw $t7, 0($t4)
			addi $t4,$t4,4
			addi $t3,$t3,1
			addi $t2,$t2,1
			j inner
		
outloop:
	addi $t2,$0,0
	output:
		lw $a0,0($t0)
		li $v0, 1              #系统调用/print_int
        syscall
		la $a0, separate       #打印空格
        li $v0, 4              #系统调用/print_string
        syscall

		addi $t0,$t0,4
		addi $t2,$t2,1
		slt $t3,$t2,10
		beq $t3,0,exit
		j output
	exit:
		li $v0, 10             #系统调用/退出程序
        syscall

	
