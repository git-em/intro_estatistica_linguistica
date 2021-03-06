################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 11                 ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################


## O presente tutorial foi desenvolvido para acompanhar a Aula 11 do curso introdut�rio de An�lise e Visualiza��o de dados. Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.

## Carregando pacotes
library(dplyr)
library(ggplot2)

## Qual a probabilidade de eu tirar 3 coroas em 3 lan�amentos de moeda?
dbinom(3, 3, 0.5)


## Qual a probabilidade de eu tirar 1 coroas em 3 lan�amentos de moeda?
dbinom(1, 3, 0.5)

## Qual a probabilidade de eu tirar ao menos 1 coroa em 3 lan�amentos de moeda?
dbinom(1:3, 3, 0.5)

## Somando as probabilidades para 1, 2 ou 3 caras
sum(dbinom(1:3, 3, 0.5))



##Qual a probabilidade de eu tirar ao menos 90 coroas em 100 lan�amentos de moeda?
sum(dbinom(90:100, 100, 0.5))



##Teste de Hip�teses: 

## H0: p(coroa) = 0.5
## HA: p(coroa) > 0.5 (HA � "greater") 
prop.test(90, 100, 0.5, alternative = "greater")

## PR�TICA

## Dois sociolinguistas divergem sobre uma hip�tese envolvendo os usos de �tu� e �voc� para uma determinada popula��o. O sociolinguista A acaba de publicar um paper afirmando que essas variantes ocorrem com igual frequ�ncia na l�ngua dessa popula��o. No entanto, o sociolinguista B diz que o contexto informal prev� o uso de �tu� em uma taxa maior do que �voc�.

##O sociolinguista B, para provar seu ponto, coleta dados de situa��es informais de fala. Ao todo, ele contabiliza 132 ocorr�ncias de �tu� e �voc� somadas. H� 80 ocorr�ncias de �tu� e 52 de �voc�.

##Como testar se h� evid�ncias a favor da hip�tese do sociolinguista B?

## Antes de fazer o teste, escreva a H0 e HA do Linguista B


########################
## TESTE QUI-QUADRADO ##
########################

## carregue o conjunto de dados
labov = read.csv("labov.csv")


## Primeira pergunta: No geral, as atendentes preferiram usar a forma de maior prest�gio (r1) ou de menor prest�gio; ou seja, ser� que p(r1) ??? p(r0)?

## tabela de conting�ncia (ou tabela de frequ�ncia absoluta)
tabela = table(labov$r)
tabela

## tabela de frequ�ncia relativa
prop.table(tabela)


## Gr�fico de barras: contagem

ggplot(labov, aes(x=r))+ #n�o especificamos o eixo y, pois o default do r � entend�-lo como contagem
  geom_bar() ## especifica que o gr�fico � um gr�fico de barras! 


## Gr�fico de barras: probabilidade
ggplot(labov, aes(x=r))+
  geom_bar(aes( y = (..count..)/sum(..count..))) ## Linha A

## Gr�fico de barras: porcentagem
ggplot(labov, aes(x=r))+
  geom_bar(aes( y = (..count..)/sum(..count..)), fill = "lightblue", color = "black")+ #indico a cor do preenchimento da barra
  scale_y_continuous(labels=scales::percent)+ #Linha B
  labs(x = "Tipo de r�tico realizado", y = "Contagem das realiza��es")+
  theme_bw()


## Teste de propor��o dada H0 de que p(sucesso) = 0.5 e HA de que p(sucesso) ??? 0.5
prop.test(499, 730, 0.5, alternative = "two.sided")

## Teste qui-quadrado
labov.r = chisq.test(tabela)
labov.r

## Tabela de frequ�ncia absoluta de tipo de r�tico por �nfase

tabela.r.emphasis = table(labov$r, labov$emphasis)
tabela.r.emphasis

## Tabela de frequ�ncia relativa de tipo de r�tico por �nfase: total das c�lulas soma 1

prop.r.emphasis = prop.table(tabela.r.emphasis)
prop.r.emphasis

## Tabela de frequ�ncia relativa de tipo de r�tico por �nfase: colunas somam 1

prop.r.emphasis = prop.table(tabela.r.emphasis, 2)
prop.r.emphasis

## Teste qui-quadrado para testar de p(r1) � a mesma independente de emphasis

chisq.test(tabela.r.emphasis)

### PR�TICA

## Agora que voc� j� sabe como teste qui-quadrado funciona, teste a hip�tese de Labov, descrita abaixo:

## O r realizado � de maior prest�gio; portanto, a frequ�ncia de sua realiza��o mudar� em fun��o da loja, visto que essas lojas atendem p�blicos de classes sociais distintas.







## REVIS�O

## Para testes com vari�vel dependente que pode ser modelada por uma distribui��o binomial

## prop.test(x, n, p) #testa a probabilidade de x ocorr�ncias de sucesso em n lan�amentos dada uma probabilidade p associada
## 
## table(dados$x) #tabela com os valores absolutos de cada n�vel da vari�vel x
## 
## table(dados$x, dados$y) #tabela com os valores absolutos de cada n�vel da vari�vel x para cada n�vel da vari�vel y
## 
## prop.table(x) #tabela com as frequencias relativas dos valores de uma tabela x
## 
## chisq.test(x) #teste qui-quadrado para distribui��o dos n�veis da tabela x
## 



## FAZENDO GR�FICOS DE BARRA

## ggplot(dados, aes(x=x))+ ## indica o eixo x
##   geom_bar(aes( y = (..count..)/sum(..count..)), fill = "cor")+ #indica em aes() o que a barra mostrar� (aqui, identificando que � a probabilidade), e a cor do preenchimento da barra com a fun��o fill =
##   scale_y_continuous(labels=scales::percent)+ #indica que o eixo y deve mostrar porcentagem
##   labs(x = "legenda", y = "legenda")+ #indica legenda dos eixos x e y
##   theme_bw() #indica o tema (aqui, o escolhido � bw - black/white)

