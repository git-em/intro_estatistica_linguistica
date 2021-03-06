#A atividade dessa semana consiste em analisar um conjunto de dados sobre nomes de Pok�mon.

#Estudos do japon�s (Kawahara, 2017) identificaram que, ao nomear novos pok�mons, os falantes nativos da l�ngua preferiam usar nomes mais longos para animais em est�gio p�s-evolu��o comparativamente a um est�gio pr�-evolu��o.

#A explica��o para isso seria de que pok�mons p�s-evolu��o tendem a ser percebidos como maiores, mais r�pidos e fortes que as criaturas antes da evolu��o, e estaria em jogo algo pr�ximo de um princ�pio da quantidade (quanto mais informa��o, maior a forma). 

# Foi feito um experimento similar em portugu�s brasileiro (Godoy et al., em andamento) e o mesmo efeito foi encontrado: nomes maiores (maior n�mero de s�labas) para pok�mons p�s-evolu��o. Nesse caso, os autores se perguntaram se a familiaridade que os participantes do experimento t�m de pok�mons afetaria a diferen�a de tamanho das palavras entre pok�mons pr� e p�s-evolu��o dada pelos participantes. A hip�tese � de que aqueles falantes que conhecem melhor o universo de pok�mon estariam mais sens�veis a demonstrar a diferen�a em evolu��o no nome, e portanto a diferen�a da m�dia de s�labas no pok�mon p�s-evolu��o seria maior. 

#O conjunto de dados pokemon.csv tem as seguintes colunas.

#participant: (categ�rico, 142 n�veis) cada um dos participantes do experimento
#familiarity: (num�rica) familiaridade do participante com jogos e desenhos de Pok�mon; escala de 1 a 7.
#pre.syl: (num�rico) n�mero m�dio de s�labas dada pelo participante em pok�mon pr�-evolu��o 
#pos.syl: (num�rico) n�mero m�dio de s�labas dada pelo participante em pok�mon p�s-evolu��o 
#syl: (num�rico) a diferen�a entre pos.syl e pre.syl (pos.syl-pre.syl)

#Inspecione graficamente os dados e fa�a um teste para testar a seguinte hip�tese:

#H� correla��o entre a diferen�a da m�dia do n�mero de s�labas para pok�mons pr� e p�s evolu��o e a familiaridade dos participantes com Pok�mon.
