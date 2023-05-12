          ORG $1000
terminaprog: dc.w       0
comandoutente: dc.w  2
prezzi:      dc.w    1,2,3,0,0,0,0,0,0,0
pezzi:       dc.w    3,2,1,0,0,0,0,0,0,0
selezionate: ds.w    10
selezionaofferte dc.w 3

START:
      lea prezzi,a0      
      lea pezzi,a1
      lea selezionate,a2
      move selezionaofferte,d6
      move.w terminaprog,d0
      move.l a0,a3
      move.l a0,a4    ;indirizzo prezzi
      move.l a1,a5    ;indirizzo pezzi
      addi #20,(a3)     ;indirizzo di fine memoria      
do:      
      tst.w d0
      bgt end_prog
      bsr read                ;leggiamo comando utente in d1
      tst.w d1
      beq comando0
      cmp.w #1,d1
      beq comando1
      cmp.w #2,d1
      beq comando2      
      
comando0:
         move.w #1,d0
         bra do
comando1:
         bsr write  
         bra do
comando2:        
         bsr read                 ;leggiamo n valori da inserire in d5
inserimento:         
         tst d5
         beq end_inserimento             ;salto se ho finito di inserire i valori
         cmp a0,a3
         beq end_prog             ;salto se ho finito la memoria
         bsr read                 ;leggo prezzi in d2
         move d2,(a0)+            ;salvo il risultato nell'array prezzi
         bsr read                 ;leggo pezzi in d3
         move d3,(a1)+            ;salvo risaultato nell'array pezzi
         subi #1,d5                   ;aggiorno contatore
         bra inserimento
end_inserimento:
         bsr write                 ;stampa offerte inserite
         bsr OrdinaOfferte                           
         move.w d2,(0,a2,d2)       ;numero offerta selezionata la scrivo all'indirizzo di selezionata                        
         bra do                

SOfferte:
      bsr read                  ;l'offerta che voglio selezionare è in d2 se è 0 esco
      tst d2
      beq end_seleziona
      bra SOfferte   
end_seleziona:
      bra do
OrdinaOfferte:
      cmp a3,a4
      beq end_ordina
      move (a4)+,d4
      cmp (a4),d4
      blt if1
      bra OrdinaOfferte
if1:
    move.w (a4),d5
    move.w d5,(-4,a4)
    move.w d4,(a4)
    rts 
end_ordina:
    rts    

stampaofferte:
            rts   
write:
      rts   
read:    
      rts
      
      
end_prog:

        END START