################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 6                  ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################

## O presente tutorial foi desenvolvido para acompanhar a Aula 6 do curso introdut�rio de An�lise e Visualiza��o de dados. Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.

## Pacotes usados na aula

library(ggplot2)
library(tidyverse)
library(dplyr)
library(readxl)


## Gerando conjunto de dados para duas amostras 

A = rnorm(30, 200, 8) # gera o conjunto A, com 30 observa��es, m�dia = 200, dp = 8
B = A # gera o conjunto B com os mesmos valores do conjunto A

mean(A)-mean(B) 

B = rnorm(30, 202, 8) # gera conjunto B, com 30 observa��es, m�dia = 202, dp = 8

mean(A)-mean(B)

B = rnorm(30, 150, 8) # gera o conjunto B, com 30 observa��es, m�dia = 150, dp = 8

mean(A)-mean(B)


## Para fins de ilustra��o, vamos simular duas amostras de Grupo A e Grupo B para nosso experimento sobre colesterol

sedentarios = rnorm(30, 200, sd = 15)
ativos = rnorm(30, 170, sd = 15)

## Com o comando abaixo, voc� faz um boxplot r�pido dos grupos s� para conferir se a distribui��o dos dados � mesmo uma normal e para j� dar uma olhada na diferen�a das m�dias.

boxplot(sedentarios, ativos)


## Com o comando abaixo, voc� faz um histograma r�pido dos grupos s� para conferir se a distribui��o dos dados � mesmo uma normal e para j� dar uma olhada na diferen�a das m�dias.

hist(sedentarios)

hist(ativos)


## Teste-t para comprar duas amostras n�o-pareadas; n�o h� medidas repetidas

t.test(sedentarios, ativos, paired = FALSE, alternative = "greater")


## Teste-t para comprar duas amostras pareadas; n�o h� medidas repetidas

t.test(sedentarios, ativos, paired = TRUE, alternative = "greater")

## Baumann e Jones coletaram dados para investigar a efic�cia de dois novos m�todos de ensino. Os alunos que participaram foram divididos aleatoriamente em tr�s grupos de estudo: o primeiro grupo, receberia instru��o normal (grupo `Basal`). O segundo, receberia instru��o com o m�todo codificado como `DRTA` e o terceiro com o m�todo `STRAT`.

## Eles fizeram dois pr�-testes (provas) com os participantes dos tr�s grupos, para garantir que a diferen�a entre os grupos nesse primeiro est�gio seria nula. Depois de os alunos terem aulas seguindo um dos tr�s m�todos, os autores fizeram tr�s testes provas* para comparar se os grupos agora diferiam com rela��o � performance.

# Aqui, vamos apenas avaliar se as notas dos alunos na *Prova 1* s�o maiores entre os alunos que receberam ensino com o m�todo `DRTA` em compara��o aos alunos que receberam instru��o com o m�todo de ensino tradicional (`Basal`).

## Defina a �rea de trabalho para carregar o arquivo Baumann.xlsx

Baumann = read_excel("Baumann.xlsx")

## Inspecione o conjunto de dados

View(Baumann)
str(Baumann)

## Primeiro precisamos ver se nossa vari�vel dependente preenche todos os requisitos para o teste-t, incluindo o crit�rio de normalidade de distribui��o dos dados

boxplot(Baumann$Basal, Baumann$DRTA)

## Os dados parecem normais. Portanto, realizo um teste-t *n�o-pareado* considerando o previsto em minhas hip�teses pr�vias.

t.test(Baumann$DRTA, Baumann$Basal, alternative = "greater", paired = FALSE)

## A tabela `Covariaveis.csv` (Oushiro, 2017) cont�m o dados de 128 falantes paulistanos. Importe a tabela e d� uma olhada nas vari�veis com as fun��es `str()` ou `View()`.

# Use a fun��o read.csv() para importar a tabela pois se trata de tabela em formato .csv

covariaveis = read.csv("Covariaveis.csv")

## Inspecione a tabela 

str(covariaveis)
View(covariaveis)


## Para fazer o teste a fim de determinar se escolaridade influencia nas taxas de CN, precisamos criar datasets separados para informantes com ensino superior e informantes para ensino m�dio. Hora de relembrar como se usa o dplyr!

ens.sup = covariaveis%>%
  filter(ESCOLARIDADE == "EnsSuperior")

ens.med = covariaveis%>%
  filter(ESCOLARIDADE == "EnsMedio")


## Vamos fazer um box plot para ver se os dados s�o normais.

boxplot(ens.sup$CN, ens.med$CN)


## S� para conferir com os histogramas

hist(ens.sup$CN)
hist(ens.med$CN)


## Fazendo um teste de Wilcoxon porque a distribui�c�o dos dados n�o � normal

wilcox.test(ens.med$CN, ens.sup$CN, alternative = "greater", paired = FALSE)

## Vamos apenas calcular a mediana (n�o a m�dia!) para cada fator de escolaridade

covariaveis%>%
  group_by(ESCOLARIDADE)%>%
  summarise(mediana = median(CN))


################################
### REVIS�O DOS COMANDO NO R ###
################################

## Para fazer boxplots e histogramas rapidamente, use:

## hist(x) #histograma de x
## boxplot(x,y,z) #boxplot comparativo de x, y e z

## Para comparar dados independentes e num�ricos, usem um teste-t para dados em uma distribui��o normal e o teste de wilcoxon para dados que n�o tenham distribui��o normal. 

## N�o se esque�a de informar sua Ha em `alternative` e se os dados s�o pareados 

## t.test(x, y, paired = T/F, alternative = )
## wilcox.test(x, y, paired = T/F, alternative = )

