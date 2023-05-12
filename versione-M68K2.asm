
          ORG $1000
terminaprog: dc.l       0
comandoutente: dc.l  2
selezionate: ds.l    10
offerte: ds.l 15
selezionaofferte: dc.l 3


START:
      move.l terminaprog,d0
      move.l comandoUtente,d1
      move.l selezionaofferte,d6
      lea offerte,a1
      lea selezionaofferte,a0
      subi #84,(sp)
      
do:   
      tst d0
      bgt end_prog
      tst d1
      beq comando0
      cmp #1,d1
      beq comando1
      cmp #2,d1
      beq comando2
      
comando0:
      move.l #1,d0
      bra do
comando1:
comando2:
      bsr read     ;leggo n in d5
      move.l #4,d4  ;contatore stack pointer prezzi
      move.l #44,d3 ;contatore stack pointer pezzi   
inserimento:      
      tst d5
      beq end_inserimento 
      bsr read    ;leggo prezzi in d2
      move.l d2,(0,sp,d4)
      bsr read    ;leggo pezzi in d2
      move.l d2,(sp,d3)
      addi #4,d4
      addi #4,d3
      move.l d5,(a1,d5)  ;aggiorno array offerte con il numero dell'offerta
      subi #1,d5
      bra inserimento      
end_inserimento:
      bsr write   ;stampa numero offerte inserite in Offerte
      bsr OrdinaOfferte
      bsr write  ;stampa offerte inserite in a1
soffertefunc:
      tst d5
      beq end_selezione
      
      bsr read ;leggo il numero dell'offerta da selezionare in d5
      move.l (a1,d5),(a0)+
      bra soffertefunc            

end_selezione
      bra do


write:
      rts
read:
      rts  
OrdinaOfferte:
      rts           
end_prog:
         addi #84,(sp)
         END START








