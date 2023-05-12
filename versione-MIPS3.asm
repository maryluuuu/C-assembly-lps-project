.data
terminaprog: .word  0
selezionate: .space 40 
comandoUtente: .word 2
offerte: .space 40
selezionaofferte: .word 3

.text
lw $t0,terminaprog
lw $t1,selezionaofferte
la $s0,offerte
la $s1,selezionaofferte
subi $sp,$sp,84

do:
   beqz $t0,end_prog
   jal read
   beqz $t1,comando0
   beq $t1,1,comando1
   beq $t1,2,comando2
   
comando0:
   li $t0,1
   j do
comando1:
   jal write
   j do
comando2:
   jal read   #leggo il n valori da inserire in t6
   li $t4,4
   li $t5,44
inserimento:
   beqz $t6,end_inserimento
   jal read   #leggo prezzi in $s2
   add $s5,$sp,$t4    #puntatore allo stack pointer
   sw $s2,($s5)
   jal read  #leggo prezzi in $s3
   add $s5,$sp,$t5
   sw $s3,($s5)
   addi $t4,$t4,4
   addi $t5,$t5,4
   subi $t6,$t6,1
   j inserimento
end_inserimento:
   jal write  
   jal OrdinaOfferte
   jal write 
selfunction:
   beqz $t6,end_selezione   #t6=seleziona numero
   jal read   #leggo il numero dell'offerta da selezionare in $t6
   mul $t6,$t6,4
   add $s5,$s1,$t6
   j selfunction
end_selezione:
   j do
OrdinaOfferte:
      jr $ra
    
read: 
     jr $ra
write:
     jr $ra   
   
   
   
   
   
end_prog:
