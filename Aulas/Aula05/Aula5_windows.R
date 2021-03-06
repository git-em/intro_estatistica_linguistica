################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 5                  ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################

## O presente tutorial foi desenvolvido para acompanhar a Aula 5 do curso introdut�rio de An�lise e Visualiza��o de dados (PPgEL/UFRN - 2018). Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.

## � poss�vel calcular o exemplo de Hinton (2004, Cap 7) usando o R como calculadora para chegar no z-score e depois usar a fun��o pnorm() para calcular a probabilidade de um valor z.

media.populacao = 3.2
media.amostra = 3
sd.populacao = 0.9
n.amostra = 100

z = (media.amostra-media.populacao)/(sd.populacao/sqrt(n.amostra))

pnorm(z, lower.tail = T)
pnorm(-2.22, lower.tail = T)


### ESTUDO DE CASO 2

## Uma empresa ensaca caf�s afirmando que cada saco tem ***500g***. A empresa tamb�m informa que o maquin�rio que produz o conte�do deve retornar esse valor com *** ?? = 25g***.

## Uma ***amostra 30 pacotes*** � analisada pelo controle de qualidade, e a m�dia de peso dessa amostra � de ***513g***. O gerente de produ��o quer testar se a m�quina tem produzido pacotes com um peso maior que o esperado.

#Assumindo um ?? = 0.05, � poss�vel afirmar que a amostra recolhida indica que o maquin�rio est� produzindo pacotes com m�dia superior ao valor pretendido?

media.populacao = 0?
media.amostra = 0?
sd.populacao = 0?
n.amostra = 0?

z = 0?

pnorm(z, lower.tail = )

#### ESTUDO DE CASO 3 (esse problema � uma vers�o mais correta de investigar o problema 2 do HW 4)

## Uma escola investiu numa nova t�cnica de ensino de reda��o de forma experimental. Durante um ano, uma turma de 30 alunos selecionados aleatoriamente dentre os alunos do terceiro ano tiveram aulas com essa nova t�cnica.

#Ao fim do ano, a m�dia dessa turma na prova de reda��o do ENEM foi de 698. A m�dia do restante dos alunos foi 650, com desvio-padr�o de 25.

#Considerando um alfa de 0.05, pode-se rejeitar a H0?

## H0:
## Ha:


###############
### TESTE T ###
###############

## Para realizar o teste-t, � importante informarmos o grau de liberdade. O grau de liberdade � igual a n-1. Geralmente usamos o n-1 para calcular estat�sticas de uma AMOSTRA. Vimos que o desvio-padr�o de uma popula��o � resultante de um valor dividido por n. O desvio-padr�o amostral � resultante de um valor dividido por n-1. A fun��o sd() sempre nos retorna um valor considerando n-1 no denominador. Consulte a ajuda sobre a fun��o para confirmar:

?sd

#Tente calcular a probabilidade do valor -2 em uma distribui��o z (a distribui��o normal padr�o, que vimos na �ltima aula) e em uma distribui��o t.

pnorm(-2)
pt(-2)

#Agora tente fazer o c�lculo informando os graus de liberdade.

pt(-2, df = 2)
pt(-2, df = 6)
pt(-2, df = 30)
pt(-2, df = 100)

### ESTUDO DE CASO: teste-t


#Um gerente de produ��o quer ter certeza de que sua f�brica tem produzido pacotes com 500g de caf�. Para isso, ele anota o peso de uma amostra de 15 pacotes.

cafe = c(501, 506, 499, 490, 491, 493, 490, 497, 498, 488, 515, 494, 497, 504, 504)
mean(cafe)

media.amostra = mean(cafe) #m�dia da amostra
media.padrao = 500 #m�dia pretendida
s = sd(cafe) #desvio-padr�o amostral (s)
n = length(cafe) #n�mero de observa��es da amostra


t = (media.amostra-media.padrao)/(s/sqrt(n)) ## � a mesma f�rmula que j� usamos, mas dessa vez usando *s* em vez do desvio-padr�o da popula��o.
t

pt(t, df = n-1, lower.tail = F) #Probabilidade acumulada na upper-tail
pt(t, df = n-1, lower.tail = T) #Probabilidade acumulada na lower-tail 

## H� um jeito mais f�cil de fazer um teste-t com uma amostra no R

t.test(cafe, mu=500, alternative = "greater") #Ha: m�dia da amostra � *maior* que 500

t.test(cafe, mu=500, alternative = "less") #Ha: m�dia da amostra � *menor* que 500

t.test(cafe, mu=500, alternative = "two.sided") #Ha: m�dia da amostra � *diferente* que 500

#A fun��o t.test() realiza um teste-t considerando ?? = 0.05.

# O c�lculo do p-valor considerando esse ?? depender� da Ha especificada.

# O teste retorna tamb�m os intervalos de confian�a para a HA especificada.

# Voc� ver� que se o seu teste der um p<0.05, o valor especificado em mu estar� fora do intervalo de confian�a.

# Lembre-se: voc� N�O DEVE fazer testes considerando todas as Ha, mas sim definir qual � sua Ha ANTES do teste

### ESTUDO DE CASO: teste-t 

# Uma escola est� pensando se deve investir em uma nova t�cnica de ensino de reda��o. Durante um ano, uma turma de 30 alunos selecionados aleatoriamente dentre os alunos do terceiro ano tiveram aulas com essa nova t�cnica. Abaixo voc� tem o vetor com as notas desses alunos. A distribui��o das notas � normal.

notas = c(739, 720, 701, 702, 701, 724, 674, 658, 713, 659, 715, 675, 701, 707, 700, 661, 728, 700, 742, 699, 660, 659, 690, 685, 719, 713, 701, 660, 676, 753)

# Ao fim do ano, a m�dia dos alunos da escola que n�o fizeram parte da turma especial foi 650. Considerando um alfa de 0.05, calcule se � poss�vel rejeitar a H0 considerando que:

#H0: Xbarra = ??
#Ha: Xbarra > ??


### ESTUDO DE CASO: teste-t (esse exemplo foi retirado do livro)

#Um supermercado faz uma promo��o para aumentar a m�dia de compra de itens, que era de 25. Coleta-se uma amostra do n�mero de itens comprados por 50 clientes que foram selecionados aleatoriamente. O vetor com esses valores encontra-se abaixo:

shoppingdata = c(30, 44, 19, 32, 25, 30, 16, 41, 28, 45, 28, 20, 18, 31, 15, 32, 40, 42, 29, 35, 34, 22, 30, 27, 36, 26, 38, 30, 33, 24, 15, 48, 31, 27, 37, 45, 12, 29, 33, 23, 20, 32, 28, 26, 38, 40, 28, 32, 34, 22)

#Considerando ?? = 0.05, avalie se a propaganda surtiu o efeito desejado pelo supermercado.



################################
### REVIS�O DOS COMANDO NO R ###
################################

#Digitar ? na frente do nome de uma fun��o ou pacote abre o help do R, com informa��es sobre essa fun��o ou pacote

## ?sd
## ?mean
## ?dplyr

#Para calcular a probabilidade de um t, usamos pt. A fun��o t.test() realiza um teste-t.

## pt(t, df, lower.tail =) #retorna a probabilidade acumulada para um valor de t, considerando os graus de liberdade (df) e se � a partir da lower.tail ou n�o

## t.test(dados, mu=X, alternative =) #retorna se a m�dia de dados � diferente de X de acordo com a diferen�a definida em alternative ("two.sided", "less" ou "greater")

