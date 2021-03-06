################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 8                  ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################

## O presente tutorial foi desenvolvido para acompanhar a Aula 8 do curso introdut�rio de An�lise e Visualiza��o de dados. Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.
## Carregando pacotes
library(ggplot2)
library(yarrr)
library(tidyverse)
library(readxl)
library(car)


##Instale e carregue um novo pacote

install.packages("yarrr")
library(yarrr)

## Se n�o der, importe o conjunto de dados com read.csv

poopdeck = read.csv("poopdeck.csv")

str(poopdeck)

## Inspecione o conjunto de dados 
head(poopdeck)


##Boxplot dos dados (as cores por cleaner s�o dadas pelo comando aes(fill=cleaner))

ggplot(poopdeck,aes(x=type, y = time))+
  geom_boxplot(alpha = 0.8, aes(fill=cleaner), outlier.size = 2)+
  theme_bw()



##Mais boxplots

ggplot(poopdeck, aes(x=cleaner, y=time))+
  geom_boxplot(alpha = 0.8, aes(fill=cleaner), outlier.size = 2)+
  theme_bw()

#####################
### ONE-WAY ANOVA ###
#####################
## Fazemos uma anova com a fun��o aov()

modelo.cleaner <- aov(time ~ cleaner, data = poopdeck)


## Recuperamos a tabela ANOVA com summary()
summary(modelo.cleaner)

## Fazemos an�lises post-hoc com TukeyHSD()
TukeyHSD(modelo.cleaner)

#####################
### TWO-WAY ANOVA ###
#####################

## Boxplot por type

ggplot(poopdeck, aes(x=type, y=time))+
  geom_boxplot(alpha = 0.8, aes(fill=type), outlier.size = 2)+
  theme_bw()


## Two-way ANOVA

modelo.cleaner.type <- aov(time ~ cleaner + type, data = poopdeck)

summary(modelo.cleaner.type)



## An�lise post-hoc

TukeyHSD(modelo.cleaner.type)

########################
### ESTUDO DE CASO 1 ###
########################


## Conduza uma ANOVA no conjunto Baumann e Jones

##Carregue o pacote que tem o conjunto de dados 
library(car)

##Inspecione o conjunto
Baumann

## Vamos ver o boxplot

ggplot(Baumann, aes(x=group, y=post.test.1))+
  geom_boxplot(alpha = 0.8, aes(fill=group), outlier.size = 2)+
  theme_bw()

##Fa�a uma an�lise em post-test 1 para ver se h� efeito principal de t�cnica e reporte sua resposta como se voc� estivesse escrevendo um artigo.

###################################
### TWO-WAY ANOVA COM INTERA��O ###
###################################


## O efeito do produto de limpeza depende do tipo de dejeto? Qual a f�rmula?

ggplot(poopdeck,aes(x=type, y = time))+
  geom_boxplot(alpha = 0.8, aes(fill=cleaner), outlier.size = 2)+
  theme_bw()


## Primeiro n�s fazemos um modelo, com a fun��o aov para responder a pergunta que nos interessa.

modelo.cleaner.int.type <- aov(time ~ cleaner * type, data = poopdeck)


## Agora tiramos a nossa tabela desse modelo atrav�s da fun��o summary

summary(modelo.cleaner.int.type)



## Mais uma vez, o teste de Tukey pode te dar as compara��es em um teste post-hoc.

TukeyHSD(modelo.cleaner.int.type)

########################
### ESTUDO DE CASO 2 ###
########################

## Carregue o pacote Covariaveis.csv (Oushiro, 2015)
## 
covariaveis = read.csv("Covariaveis.csv")

## H� efeito de g�nero na taxa de produ��o de concord�ncia nominal n�o-padr�o e ser� que esse efeito depende do n�vel de escolaridade?

## Vamos fazer uma filtragem para eliminar os falantes estrangeiros

covariaveis.br = covariaveis%>%
  filter(ORIGEM.PAIS != "estrangeiros")


## Vamos ver os dados

ggplot(covariaveis.br, aes(x=ESCOLARIDADE, y=CN))+
  geom_boxplot(alpha = 0.8, aes(fill=SEXO.GENERO), outlier.size = 2)+
  theme_bw()


## Para podermos fazer nossas an�lises, precisamos transformar os dados, visto que n�o s�o normais (cf. Aula 7).

## Alguns informantes tem valor igual a 0 na coluna CN, o que significa que ele n�o realizaou nenhuma CN n�o-padr�o. Como � imposs�vel fazer uma transforma��o logar�tmica em 0, somamos 1 a todos os valores da coluna e, depois disso, realizamos a transforma��o.

covariaveis.br = covariaveis.br%>%
  mutate(CN.1 = CN+1)%>% 
  mutate(CN.log = log(CN.1))


## Vamos construir um modelo para uma an�lise Two-way ANOVA com intera��o e ver o resultado da Tabela ANOVA.

modelo.CN <- aov(CN.log ~ SEXO.GENERO * ESCOLARIDADE, data = covariaveis.br)

summary(modelo.CN)


## Como n�o houve efeito de intera��o, o Teste Tukey deve fazer as an�lises apenas para os termos que foram significantes para o modelo: SEXO.GENERO e ESCOLARIDADE.

TukeyHSD(modelo.CN, "SEXO.GENERO")

TukeyHSD(modelo.CN, "ESCOLARIDADE")

## Como nosso experimento � 2x2 e n�o houve efeito de intera��o, nem precisar�amos ter feito essa an�lise post-hoc!


###############
### REVIS�O ###
###############

## Fun��es para teste ANOVA

## modelo.aov <- aov(x ~ y, data)
## TukeyHSD(modelo.aov, "y")

