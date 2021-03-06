################################################################################
########### Programa de P�s-gradua��o em Estudos da Linguagem (UFRN) ###########
########### An�lise e Visualiza��o de dados: Aula 9                  ###########
########### Profa:    Mahayana Godoy                                 ###########
################################################################################

######################
#### INFORMA��ES #####
######################


## O presente tutorial foi desenvolvido para acompanhar a Aula 9 do curso introdut�rio de An�lise e Visualiza��o de dados (PPgEL/UFRN - 2018). Por esse motivo, alguns dos comandos podem n�o ser t�o transparentes se forem realizados de forma independente. 

## Carregando pacotes
library(ggplot2)
library(readxl)

## Importe o conjunto de dados 
dados.study <- read_excel("studyhours_exammarks.xlsx")

## Abaixo, temos a sintaxe de um teste de correla��o
## #cor.test(VARI�VEL_1, VARI�VEL_2)
## 

##No caso do conjunto de dados dados.study, preenchemos a sintaxe da seguinte maneira:
cor.test(dados.study$mark, dados.study$study.time)


## Importe o conjunto de dados de Oushiro 2017



## Veja se h� correla��o entre CN e CV3PP


##########################
## GR�FICO DE DISPERS�O ##
##########################

## Sintaxe b�sica
## ggplot(DATA, aes (x = PREDITORA, Y = RESPOSTA))

## Vamos tentar com nossos dados
ggplot(cov, aes (x = CN, y = CV3PP))+
  geom_point() ## geom_point indica o tipo de gr�fico que queremos

## Vamos s� deixar o gr�fico mais bonito e ajustar uma linha de regress�o.
ggplot(cov, aes (x = CN, y = CV3PP))+
  geom_point(size = 3, alpha = 0.5)+
  geom_smooth(method = "lm", se = FALSE)+
  theme_bw()

## Conferindo distribui��o dos dados
boxplot(cov$CN, cov$CV3PP)


## Vamos fazer um teste de correla��o de spearman
cor.test(cov$CN, cov$CV3PP, method = "spearman")


##### VARI�VEIS DE CONFUNDIMENTO

## O gr�fico abaixo mostra o efeito de ESCOLARIDADE na correla��o; parece que essa vari�vel n�o muda muito a correla��o dos dados
ggplot(cov, aes (x = CN, y = CV3PP, colour = ESCOLARIDADE))+
  geom_point(size = 3, alpha = 0.5)+
  geom_smooth(method = "lm", se = FALSE)+
  theme_bw()


###### M�LTIPLAS COMPARA��ES E ESTUDOS EXPLORAT�RIOS

## N�O vamos usar os comandos em aula, mas voc�s podem tentar faz�-lo em casa
## #install.packages("languageR")
## #library(languageR)


## pairscor.fnc( ~ cov$EN + cov$RT + cov$R0 + cov$CN + cov$CV3PP + cov$CV1PP, hist = T, smooth = T)


#######################
## ATIVIDADE PR�TICA ##
#######################


## O conjunto de dados diamonds.csv tem uma coluna valuecom o valor de venda de 150 diamantes. Voc� acha que peso, claridade ou cor contribuem para o valor de venda de um diamante?

## Escolha um dos crit�rios, inspecione a distribui��o e fa�a um teste de correla��o com o valor de venda.

## Importe o conjunto de dados

## Veja se � poss�vel explicar os dados por meio de uma correla��o LINEAR

## Fa�a um teste que se ajuste aos dados

#############
## REVIS�O ##
#############


## Para fazer um teste de correla��o (method = "spearman" se a distribui��o n�o for normal)

## #cor.test(VARI�VEL_1, VARI�VEL_2)
## 

## Alguns comandos para ajustar gr�ficos de dispers�o

## ggplot(DADOS, aes(x=Vari�vel preditora, y=Vari�vel resposta))+ # define os eixos x e y
##   geom_point(size = 3, color = "black")+ #define caracter�sticas das bolinhas
##   geom_smooth(method='lm', color = "lightgrey", se = FALSE)+ #define caracter�sticas da
##                                                             #linha de regress�o; o m�todo
##                                                             #'lm' indica uma linha reta;
##                                                             # se = FALSE diz que voc� n�o
##                                                             # quer a �rea do standard error
##                                                             # associada a essa linha
##   labs(x= "Medida eixo x", y = "Medida eixo y")+ #Legenda do eixo x e y
##   theme_bw() #indica o tema; bw � um tema blck and white, o fundo do gr�fico fica branco

