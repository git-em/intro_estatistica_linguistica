## AVISO: os dados dessa aula s�o fict�cios e o problema foi pensado por uma psicolinguista, ent�o os sociolinguistas de plant�o que perdoem, por favor, qualquer falha associada � cria��o desse problema.

## Sabemos (gra�as � sociolingu�stica) que o grau de escolaridade muitas vezes influencia nas taxas de realiza��o de uma variante n�o-padr�o: quanto menor a escolaridade, maior a taxa de realiza��o dessa variante.
#Um sociolinguista quer testar a hip�tese de que a atitude lingu�stica com rela��o � variante (se a pessoa percebe aquela variante como estigmatizada ou n�o) tamb�m influencia nas taxas de produ��o de uma variante n�o-padr�o. Segundo esse linguista, se a pessoa percebe aquela variante como estigmatizada, ela vai produzir menos aquela variante **independente** de sua escolaridade. Ou seja, pessoas com menos escolaridade produzir�o mais aquela variante do que pessoas com mais escolaridade, mas, mesmo no grupo de menos escolaridade, haver� diferen�a entre aqueles falantes que veem essa variante com maior ou menor estigma. Como o efeito independeria de escolaridade, o mesmo ocorreria para falantes do ensino superior.

## Para testar sua hip�tese, o linguista coleta dados de uma conversa informal com quase 100 participantes (ele tinha muitos doutorandos para coletar os dados...). Depois da conversa, ele aplica um question�rio metalingu�stico que indaga o falante sobre sua percep��o em rela��o � variante estudada. Esse question�rio permitiu classificar esse falantes em dois grupos: falantes com tinham uma percep��o altamente estigmatizada da variante e falantes que tinham uma percep��o de estigma mais baixa. 

## O conjunto de dados "atitude.xls" traz os dados dessa pesquisa, sumarizados em tr�s colunas:

## taxa: (num) - taxa de realiza��o (em %) da variante n�o padr�o
## escolaridade: (chr) - identifica o falante como tendo ensino superior ("superior") ou m�dio ("medio").
## estigma: (chr) - identifica se o falante v� a variante como muito estigmatizada ("alto") ou se percebe a variante como n�o t�o estigmatizada assim ("baixo").

##################################################################################
## TAREFA: importe o conjunto de dados e realize um teste estat�stico para ver se a hip�tese do nosso linguista fict�cio se sustenta. Escreva os resultados como se fosse um artigo.
##################################################################################

## Primeiro voc� tem que conferir distribui��o dos dados para ver sua normalidade. Vou fazer isso com voc�, passo a passo, para mostrar algumas funcionalidades do ggplot.

## Se vc quiser ver a distribui��o por escolaridade em um boxplot, a essa altura vc j� deveria saber que o c�digo � o que temos abaixo:
ggplot(data, aes(x = escolaridade, y = taxa.naopadrao))+
  geom_boxplot()


## No entanto, n�o � isso que vc quer. Vc quer ver a distribui��o para os quatro grupos que temos cruzando as nossas duas vari�veis: ensino.medio:alto, ensino.medio:baixo, ensino.superior:alto, ensino.superior:baixo.

## Dica para fazer isso: quando coloco fill=estigma dentro da fun��o aes(), estou dizendo o seguinte: considere o que h� na coluna "estigma" e use isso para pintar (fill) o boxplot. Como seu boxplot j� est� dividido pelos n�veis de escolaridade (superior/m�dio) no eixo x, a fun��o criar� mais uma divis�o, por estigma, para poder aplicar o que est� na fun��o 'ggplot(data, aes(x = escolaridade, y = taxa.naopadrao, fill=estigma))'. Rode o comando abaixo para ver.
ggplot(data, aes(x = escolaridade, y = taxa.naopadrao, fill=estigma))+
  geom_boxplot()

## Voc� colocou a informa��o de "fill" no aes de geom_boxplot. Por qu�? Bem, aqui � importante lembrar que aes (que vem se "aesthetics") decide qual ser a cara do gr�fico com base em alguma vari�vel do seu dataframe. Fora do aes vc pode especificar "perfumarias" como cor do gr�fico, legenda, tema etc. No "aes", especificamos os valores do dataframe que ir�o determinar o que � mais fundamental em um gr�fico: a visualiza��o da distribiu��o dos dados.


## Vale a pena tamb�m fazer um histograma desses quatro grupos. Voc� j� aprendeu a usar "facet_wrap" na aula sobre gastos de deputados (Aula 7). Aqui voc� pode precisa dar um facet_wrap por escolaridade e estigma para ver os quatro grupos. A ideia � a mesma que j� vimos anteriormente, mas dessa vez voc� especifica que quer que o conjunto de dados se divida por essas duas vari�veis informando as duas em "facet_wrap(~ x + y)". Tente ver abaixo:
ggplot(data, aes(x = taxa.naopadrao))+
  geom_histogram()+
  facet_wrap(~escolaridade + estigma)

### Agora que voc� j� viu a distribui��o dos dados, decida como conduzir sua an�lise.
