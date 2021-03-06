################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 7                  ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################

## O presente tutorial foi desenvolvido para acompanhar a Aula 7 do curso introdut�rio de An�lise e Visualiza��o de dados (PPgEL/UFRN - 2018). Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.

library(ggplot2)
library(tidyverse)
library(readxl)


##Importe o conjunto de dados que usaremos hoje
camara.sample = read.csv("camara_sample.csv")


##Explore os n�veis de cada vari�vel categ�rica com a fun��o unique() 
unique(camara.sample$subquota_description)
unique(camara.sample$state)

##Crie o dataframe para a regi�o Nordeste

camara.NE = camara.sample%>%
  filter(state == "RN" |state ==  "PE" |state ==  "BA" | state == "SE" |state ==  "AL" |state ==  "CE" | state == "PB" | state == "PI" |state ==  "MA")

##Fa�a o mesmo para as outras regi�es. Use os nomes camara.SE, camara.N, camara.CO, camara.S.


##Crie o conjunto de dados para NE e SE dos dados de passagens a�reas ("Flight ticket issue"). Chame os conjuntos de NE.flight e SE.flight



##Fa�a um boxplot dos valores gastos nos subgrupos criados acima



##O histograma confirma a distribui��o dos dados

hist(SE.flight$total_net_value)

hist(NE.flight$total_net_value)


##Fa�a um teste estat�stico para avaliar se os deputados de ambas as regi�es gastam o mesmo com passagens a�reas

## PERGUNTA 2:

# Ser� que deputados do NE gastam mais com passagens a�reas que deputados no NO?

# Crie os conjuntos de dados que forem necess�rios

# Fa�a os gr�ficos para ver a distribui��o

# Realiza o teste estat�stico necess�rio para responder � pergunta.


## PERGUNTA 3:

## Ser� que deputados do RN e da PB gastam o mesmo com refei��es?

## Criando o conjunto de dados

RN.meal = camara.sample%>% 
  filter(subquota_description == "Congressperson meal", state == "RN")  

PB.meal = camara.sample%>% 
  filter(subquota_description == "Congressperson meal", state == "PB")

## Fa�a o boxplot, decida que teste usar para responder sua pergunta, fa�a o teste

boxplot(RN.meal$log.value, PB.meal$log.value)


##Transformando dados: A fun��o mutate() do dplyr cria uma nova coluna com o nome e os valores especificados. Aqui, criamos a coluna log.value que receber� os valores da transforma��o logar�tmica da coluna total_net_value

RN.meal = RN.meal%>%
  mutate(log.value = log(total_net_value))

PB.meal = PB.meal%>%
  mutate(log.value = log(total_net_value))

##Quando voc� rodar o c�digo, ver� que aparecer� uma nova coluna nos dataframse RN.meal e PB.meal descritos na �rea �Global Environment�.

## Podemos ver que os valores dessa nova coluna tem uma distribui��o mais pr�xima a normal.

boxplot(RN.meal$log.value, PB.meal$log.value)

## Como os dados s�o normais, � poss�vel rodar um teste-t

t.test(RN.meal$log.value, PB.meal$log.value, paired = F, alternative = "two.sided")


##M�ltiplas compara��es: como fazer todas as entre os valores gastos pelos deputados de cada estado com bilhetes a�reas.

## Criando o conjunto de dados
camara.meal = camara.sample%>%
  filter(subquota_description=="Flight ticket issue")

## Fazendo a an�lise par-a-par
pairwise.t.test(camara.flight$total_net_value, camara.flight$state, paired = F)


## PERGUNTA 4: Ser� que deputados do NE e da SE gastam o mesmo com refei��es?

## Crie os conjuntos de dados (chame de NE.meal e SE.meal)

## Fa�a um boxplot


## Precisamos tirar alguns valores extremos

NE.meal = camara.NE%>%
  filter(subquota_description=="Congressperson meal", supplier != "VERDE VALE HOTEL S/A")


## Que distribui��o � essa?

boxplot(NE.meal$total_net_value, SE.meal$total_net_value)


## Fa�a um teste estat�stico adequado para esses dados e reporte seus resultados como se fosse um artigo

############
## GGPLOT ##
############

#Imagine que voc� queira fazer os boxplot de gastos de refei��o por estado. Primeiro voc� cria o conjunto de dados:

camara.meal = camara.sample%>% 
  filter(subquota_description == "Congressperson meal")

## Agora voc� especifica que quer "state" no eixo x:

ggplot(camara.meal, aes(y=total_net_value, x = state))+
  geom_boxplot(outlier.size = 2, outlier.alpha = 0.3)



## N�o temos como fazer o mesmo no histograma. Para isso, precisamos usar a fun��o facet_wrap()

ggplot(camara.meal, aes(x=total_net_value))+
  geom_histogram()

ggplot(camara.meal, aes(x=total_net_value))+
  geom_histogram()+
  facet_wrap(~state)


############
## GGPLOT ##
############

## group_by(x) = agrupa os dados pelos n�veis de x; summarize() = d� com output as medidas que vc pede como argumento da fun��o
camara.sample%>%
  group_by(subquota_description)%>%
  summarize(media = mean(total_net_value))

## arrange() = especifica como est� "arranjado" o output; aqui, queremos que o valor de media (especificado em summarize) seja apresentado em ordem decrescente

camara.sample%>%
  group_by(subquota_description)%>%
  summarize(media = mean(total_net_value))%>%
  arrange(desc(media))


## Qual � o deputado mais gast�o?

camara.sample%>%
  group_by(congressperson_name)%>%
  summarize(media = mean(total_net_value))%>%
  arrange(desc(media))

####################
## TAREFA PR�TICA ##
####################

##GRUPO 1: analise se h� diferen�a entre os gastos dos deputados do NE e SE para participa��o em congresso (�Participation in course, talk or similar event�). Apresente um boxplot comparativo, decida que teste usar e reporte o resultado. Fa�a tamb�m um gr�fico comparativo do gasto por estado para cada uma das regi�es, para ver se os estados diferem muito entre si.

##GRUPO 2: analise se h� diferen�a entre os gastos dos deputados do SE e S para aluguel de carros (�Automotive vehicle renting or charter�). Apresente um boxplot comparativo, decida que teste usar e reporte o resultado. Fa�a tamb�m um gr�fico comparativo do gasto por estado para cada uma das regi�es, para ver se os estados diferem muito entre si.