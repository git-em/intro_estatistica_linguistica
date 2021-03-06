#DESCRI��O: Um linguista testou o efeito de frequ�ncia em um experimento de decis�o lexical de palavras em L2. Os participantes, falantes de portugu�s, viam uma sequ�ncia de letras, como "jsnfrt" ou "shrimp", e tinham que apertar um bot�o para dizer se a sequ�ncia era ou n�o uma palavra em ingl�s. O computador gravou o tempo em milissegundos que o participante levou para apertar o bot�o. Sabemos que palavras mais frequentes s�o reconhecidas mais facilmente que palavras menos frequentes. O pesquisador gostaria de ver se esse efeito tamb�m se mantem em L2, e por isso coletou os dados que voc� tem no conjunto "lexdec.xlsx"

#Comece a se��o carregando todos os pacotes que voc� precisa instalar. S� para come�ar, j� vou deixar marcado a� o pacote "readxl", pois sem ele voc� n�o tem como importar um arquivo xlsl. Se no meio da se��o voc� lembrar de algum pacote que esqueceu de carregar, anote a linha em que vc est� trabalhando para n�o esquecer, suba at� o cabe�alho e coloque aqui o pacote a ser carregado. Mantenha seu c�digo organizado!!!

### Carregar pacotes necess�rios
library(readxl)


#Importe o conjunto de dados e d� uma olhada nele

#LEGENDA DO CONJUNTO DE DADOS:
#### mais: tempo de resposta em milissegundos das palavras mais frequentes
#### menos: tempo de resposta em milissegundos das palavras menos frequentes
#### nw: tempo de resposta em milissegundos das n�o-palavras


#######Transforme o conjunto de dados em um formato longo (� sempre melhor trabalhar com esse formato no R) e renomeie as colunas para elas se chamarem tempo (que trar� o tempo de resposta em ms) e frequencia (que dir� se a observa��o � de palavra mais frequente, menos frequente ou de n�o palavra). Aten��o: N�O use acentua��o no nome das suas colunas



########Exclua as medidas das n�o palavras do seu conjunto de dados j� que vc n�o vai us�-las



######Fa�a um histograma s� das palavras mais frequentes e um s� das palavras mais frequentes

#Dica 1: como voc� tem um arquivo de formato longo, o mais f�cil � criar um conjunto de dados s� com os dados de palavras mais frequente e depois um s� com os dados de palavras menosfrequente. O dplyr � seu amigo! 


#Dica 2: o melhor � fazer um histograma b�sico primeiro, s� para dar uma olhada


####### Voc� deve ter visto que h� alguns valores extremos. Sabemos que podemos ignorar todo tempo de resposta menor que 200ms e maior que 3000ms. Fa�a isso no conjunto de dados e construa os histogramas de novo, dessa vez ajeitando o intervalo mostrado para fazer um histograma mais bonito. Mais uma vez o dplyr � seu amigo.


###### Descubra qual a m�dia, a mediana, o desvio-padr�o, o interquartil range, o primeiro e terceiro quartil das palavras mais e menos frequentes e descreva o que essas medidas te dizem sobre essas amostras comparativamente. Lembre-se: se os dados est�o em formato longo, o dplyr faz isso de forma bem autom�tica.


###### Fa�a um boxplot mostrando a dispers�o dos dois conjuntos de dados. Dica: aqui � mais neg�cio usar o conjunto completo para plotar eixo x e y. Lembre-se do exemplo da aula.



###### Pela sua an�lise, houve efeito de frequ�ncia? Que medidas evidenciam a falta ou presen�a desse efeito e como isso se reflete no boxplot?
