# Homework 4 for Assembly Language
#
#	$t0, a0 <-- a
#	$t1, a1 <-- b
#	$t3 <-- result
#
#####################################################################	
#	C++ Pseudocode for Exponential:
#   int main() {
# 	int a, b, result;
# 	cout << "Enter value for the base, 'A' (Between 1 & 21): ";
# 	cin >> a;
#	cout << "Enter value for the exponent, 'B' (Between 1 & 7): ";
#	cin >> b;
# 	result = rexp(a,b);
# 	cout << "The result is: " << result;
# 	return 0; }
#
# 	int rexp(int a, int b) {
# 		if (b > 1)
#			return a * rexp(a,b-1);
# 		else
#			return a;
#	}
#####################################################################

	.data
msgA:    .asciiz "Enter value for the base, 'A' (Between 1 & 21): "
	.space 64
msgB:    .asciiz "Enter value for the exponent, 'B' (Between 1 & 7): "
	.space 64	
resMsg:	.asciiz "The result is: "
	.space 64

	.text
	.globl main

# Main Function - Asks user for input, then calls the recursive exponent function, after function runs, it outputs the result
main:	
	# Ask user for input
	li $v0, 4			# 4 means cout
	la $a0, msgA		# msgA stored into $a0 
	li $a1, 64			# allocate memory for msg
	syscall				# print msg

	# Store user input as a ($t0)
	li $v0, 5			# 5 means cin
	syscall				# cin the input

	move $t0, $v0		# store a into $t0

	li $v0, 4			# 4 means cout
	la $a0, msgB		# msgB stored into $a0 
	li $a1, 64			# allocate memory for msg
	syscall				# print msg

	# Store user input as b ($t1)
	li $v0, 5			# 5 means cin
	syscall				# cin the input

	move $t1, $v0		# $t1 <= b

	li $v0, 4			# 4 means cout
	la $a0, resMsg		# print resMsg
	li $a1, 64			# allocate memory for message
	syscall				# return msg

	addi $t3, $0, 1		# $t3 <= result = 1

   	move $a0, $t0		# move value of $t1 into $a0 = a
   	move $a1, $t1		# move value of $t2 into $a1 = b

	jal rexp			# go to recursive exponent function
	
	li $v0, 1			# 1 means print int
	move $a0, $t3		# move result into $a0
	syscall				# return a^b

	li $v0, 10			# 10 means terminate program
	syscall				# end program

# Exponent Function - Input: $t0 (a) and $t1 (b), Output: $v0 (a^b)
rexp:
	mul $t3, $a0, $t3	# result = a * result
	addi $sp, $sp, -4	# push stack
	sw $ra, 0($sp)		# store $ra in stack
	addi $a1, $a1, -1	# decrement b
	beq $a1, $0, done	# if b=0, done
	jal rexp			# recursive call

	done:
		lw $ra, 0($sp)	# load ra to stack
		addi $sp, $sp, 4# pop the stack
		jr $ra			# go to return address