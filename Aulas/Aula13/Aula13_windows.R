################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 13                 ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################


## O presente tutorial foi desenvolvido para acompanhar a Aula 13 do curso introdut�rio de An�lise e Visualiza��o de dados. Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente.

## Carregando pacotes
library(dplyr)
library(ggplot2)

## Importar o conjunto de dados

labov = read.csv("labov.csv")


##Lembrando os n�meros das distribui��es por loja
tabela.lojas = table(labov$r, labov$store)
tabela.lojas

## Ajustando um modelo linear generalizado do tipo regress�o log�stica

labov.loja = glm(r ~ store, labov, family = binomial)


##Analisando os dados

summary(labov.loja)

## Vendo os coeficientes
summary(labov.loja)$coef


##Consultando os n�veis da vari�vel dependente

levels(labov$r)


##Calculando os logodds da odds ratio
log(21/195)

##Vendo a odds ratio a partir das logodds

exp(-2.228477)

exp(1.704933)

exp(2.1385293)


## Pacote para an�lises post-hoc de modelos lineares (incluindo modelos de regress�o log�stica)

install.packages("emmeans")
library(emmeans)


## an�lise post-hoc do modelo ajustado
glm.labov.loja = emmeans(labov.loja, ~ store)

pairs(glm.labov.loja, adjust="tukey")

###############
### PR�TICA ###
###############

## Godoy, Weissheimer & Mafra (submetido) testaram se a representa��o de um evento de transfer�ncia de posse influenciava o modo como as pessoas interpretavam um pronome amb�guo.

#Para isso, eles pediram para as pessoas completarem senten�as como as que voc� abaixo, que continham tr�s tipos de verbos de transfer�ncia de posse:


#Jo�o entregou a ma�� para M�rio . Ele� (verbo de Classe 1)
#
#Pedro jogou a chave para Roberto. Ele� (verbo de Classe 2)
#
#Sulei transferiu dinheiro para Maria. Ela� (verbo de Classe 3)

#As respostas foram analisadas para ver se os participantes interpretaram o pronome como co-referente � fonte ou ao alvo do evento.

#### VARI�VEL PREDIOTRA ####

#Os verbos de Classe 1, 2 e 3 tinham as seguintes caracter�sticas:

##Verbos de classe 1: participantes necessariamente na mesma cena do evento; garantia de transfer�ncia

##Verbos de classe 2: participantes necessariamente na mesma cena do evento; sem garantia de transfer�ncia

##Verbos de classe 3: participantes n�o est�o necessariamente na mesma cena do evento; sem garantia de transfer�ncia

#### HIP�TESES ####

#Os autores imaginavam que pronomes em contextos de verbo do Tipo 3 teriam menor prefer�ncia por serem interpretados como co-referentes ao referente ocupando papel tem�tico de alvo, pois ele estaria em menor evid�ncia em compara��o aos tipos 1 e 2, visto que n�o h� necessidade de ele estar na cena do evento descrito pelo verbo.

#Em contexto de verbos do tipo 1, haveria maior prefer�ncia por interpretar o pronome como co-referente ao alvo, pois a transfer�ncia � bem sucedida.

#### TAREFAS ####

##Filtre os dados da tabela �godoy_et_al.xlsx� para considerar apenas os dados com �source� (fonte) ou �goal� (alvo); n�o nos interessam os dados em que a interpreta��o foi amb�gua.

##Fa�a um gr�fico para averiguar a distribui��o de fonte/alvo por tipo de verbo.

##Fa�a um qui-quadrado para ver se houve efeito de tipo de verbo.

##Fa�a uma regress�o log�stica para ver se houve efeito do tipo de verbo e como foi esse efeito.

#Tente entender o que os valores dos coeficientes querem dizer.






#############
## REVIS�O ##
#############


## modelo = glm(var_dependente ~ var_independente, dados, family = binomial)
## 
## glm.model = emmeans(modelo, ~ var_independente)
## pairs(glm.model, adjust="tukey")

