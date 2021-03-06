## A li��o de casa hoje � mais um tutorial do que uma atividade pr�tica. As respostas j� est�o dadas, mas s�o discutidas algumas quest�es que n�o chegamos a aboardar em aula; por isso, � importante que voc� estude esse documento.

### O arquivo est0113.csv traz os dados de altura, n�mero de cal�ado, nota do ENEM e v�rias outras vari�veis dos alunos que cursaram est0113 na UFRN entre os anos de 2015 e 2018.

## Vamos ajustar um modelo linear para verificar a hip�tese de que altura e g�nero conseguem prever o n�mero de cal�ado de uma pessoa.

## Pacotes que vamos usar

library(ggplot2)
library(dplyr)


#importe o conjunto de dados (abaixo eu estou com o caminho para o arquivo no meu computador; voc�s tem que indicar o do seu computador)
data = read.csv("~/Documents/Mahayana/academics/cursos/introstatistics/Aulas/Aula10/est0113.csv")

## Vamos conferir o nome das vari�veis
str(data)

## Vamos uma ideia de qual a m�dia e a cara das vari�veis num�ricas que vamos avaliar; j� vismo que g�nero tem duas vari�veis: masculino e feminino

mean(data$altura)

hist(data$altura) ## dados normais

mean(data$calcado)

hist(data$calcado) ## dados n�o s�o normais, mas o que importa para o modelo linear � a normalidade dos res�duos; vamos ver isso depois

boxplot(data$altura) ## nenhum outlier
boxplot(data$calcado) ## nenhum outlier

## Vamos ver valor m�nimo e m�ximo de altura e cal�ado
min(data$altura)
max(data$altura)

min(data$calcado)
max(data$calcado)


### Vamos fazer um gr�fico de dispers�o para ver se n�o tem nada fora do previsto pelo que sabemos das alturas e cal�ados de homens e mulheres

ggplot(data, aes(altura, calcado))+
  geom_point(size = 3, alpha = 0.4, aes(colour = genero))+
  geom_smooth(method = "lm")+
  theme_bw()

## Tem uma mulher que cal�a 48?! E ela tem 1,60 de altura?! Imposs�vel! Ou houve uma falha no preenchimento, ou ela � um caso **MUITO** particular, que n�o � representativo dos nossos dados. Veja que podemos dizer isso porque conhecemos como n�mero de cal�ado e altura est�o distribu�das na popula��o, e portanto temos motivos que sustentam a nossa decis�o de excluir esse sujeito da nossa amostra. Por isso, tenha sempre em mente que voc� tem que conhecer o fen�meno que est� estudando para identificar poss�veis casos que est�o muito fora do previsto e decidir se os dados devem ser eliminados na an�lise quantitativa ou n�o. Como voc� pode conhecer o fen�meno? Lendo sobre ele, prestando muita aten��o � sess�o de m�todos dos artigos que voc� l�!

## Vamos excluir a pessoa qu tem 1,60 e cal�ado 48. N�o podemos simplesmente filtrar quem cal�a 48, pois isso nos tiraria um rapaz de 193 que cal�a 48 (o que � um tamanho de p� muito grande, mas n�o t�o imposs�vel assim pelos dados que temos; vamos dar o benef�cio da d�vida). Para excluir o dado que queremos, vamos especificar que � quem usa 48 *e* tem 160cm de altura, o que � feito com (calcado == 48 & genero == "Feminino"). Depois, vamos dizer que � para filtrar os dados de quem *N�O* se encaixa nesse perfil. Para fazer isso, � s� colocar ! (que indica "diferente") na frente de toda a express�o. Voil�:

data = data %>% 
  filter(!(calcado == 48 & genero == "Feminino"))

## Voc� deve ter visto agora que seu conjunto de dados que tinah n = 121 agora tem n = 120.

## Fazemos o gr�fico novamente

ggplot(data, aes(altura, calcado))+
  geom_point(size = 3, alpha = 0.4, aes(colour = genero))+
  geom_smooth(method = "lm")+
  theme_bw()

## Pela inspe��o do gr�fico, d� para ver que tanto sexo quanto altura explicam o tamanho do cal�ado de uma pessoa. S� agora, depois de termos explorado bem os nossos dados, vamos construir um modelo para testar nossa hip�tese:

model = lm(calcado ~ genero + altura, data)

summary(model)

#Vamos ver se os res�duos s�o normais

hist(model$residuals) #s�o normais

## Ok, o modelo encontrou efeitos significativos de g�nero e altura no tamanho da pessoa. Poder�amos reportar o resultado da seguinte maneira:

## Exclu�mos os dados de um participante do sexo feminino de 160cm que reportou cal�ar 48, pois entendemos que essa medida de cal�ado n�o � representativa da popula��o feminina.  Considerando o conjunto de dados restante (n=120), ajustamos um modelo linear com o n�mero de cal�ado como vari�vel resposta e a altura e genero como vari�veis independentes. O modelo foi significativo em explicar 79% da varia��o dos dados (F(2, 117) = 231.8, p < 0.0001). Os coeficientes indicam que indiv�duos do sexo masculino t�m cal�ados em m�dia maiores que indiv�duos do sexo feminino (beta = 3.02, t = 10.03, p < 0.0001), e o aumento de altura aumenta tamb�m o tamanho do cal�ado (beta = 0.15, t = 8.9, p < 0.0001).

#### COMENT�RIOS ADICIONAIS

## Embora essa an�lise n�o esteja errada, veja que o intercept do seu modelo n�o faz o menor sentido: ele indica o tamanho do p� de uma pessoa do genero feminino com idade igual a 0 (isso �, uma pessoa n�o nascida...). Isso ocorre porque o intercept � o valor do eixo y quando o eixo x � igual a 0. O ideal seria que o intercept fosse informativo quanto ao valor do eixo y (o n�mero do cal�ado) para a amostra que coletamos. Ou seja, o intercept deveria ser o valor de cal�ado previsto para os sujeitos que tem entre 150 e 193 de altura. N�s fazemos isso "centrando" o valor de altura em torno de zero. Em outras palavras, "enganamos" o modelo de modo a especificar que o valor "zero" do eixo x �, na verdade, a m�dia da altura da nossa amostra. 

## Como fazemos isso? Simples: criamos uma nova coluna subtraindo a m�dia da altura do vetor "altura". Assim, criaremos um novo vetor que preserva as diferen�as de alturas dos participantes, mas cuja m�dia, agora, � 0!

## Vamos criar esse novo vetor
data = data%>%
  mutate(altura.c = altura-(mean(altura)))

## Vamos tirar a sua m�dia
mean(data$altura.c)

##Ok, a m�dia n�o foi zero, foi -9.474178e-15, mas isso � praticamente zero. Esse valor corresponde a 0.000000000000009.


## Agora que nossa vari�vel dependende est� centrada, podemos rodar nosso modelo novamente, usando o novo vetor para altura. Voc� vai ver que os coeficientes continuar�o os mesmos, exceto pelo intercept, e que a signific�ncia n�o sofrer� muita altera��o

model.c = lm(calcado ~ genero + altura.c, data)

summary(model.c)

## Qual a vantagem de centrar a vari�vel? Bom, agora o seu intercept diz qual deve ser o n�mero de cal�ado para o valor m�dia de altura do n�vel de refer�ncia (g�nero feminino). N�o mudou o fato de que o tamanho m�dio do p� do g�nero masculino ser� 3.02 n�meros maior que a m�dia do p� feminino. Duvida? Vamos fazer um teste. Vamos calcular a m�dia de altura de homens e mulheres.

data%>%
  group_by(genero)%>%
  summarise(media.altura = mean(altura))

## A m�dia de altura � 163.17 para mulheres, e nosso modelo prev� que uma mulher com essa altura teria um p� de tamanho 37.3958 (o intercept - isso �, o valor do eixo y). Rode o c�digo abaixo, que faz um gr�fico de dispers�o e indica, com linha tracejada vermelha na vertical, o valor m�dio da altura feminina (1,63). Outra linha vermelha, na horizontal, indica o valor previsto pela linha de regress�o para o eixo y quando a altura � 1,63. Voc� ver� que esse valor � cerca de 37.3, conforme est� no intercept do modelo!

ggplot(data, aes(altura, calcado))+
  geom_point(size = 3, alpha = 0.4, aes(colour = genero))+
  geom_smooth(method = "lm")+
  geom_hline(yintercept=37.3958, linetype="dashed", color = "red", size = 0.5)+
  geom_vline(xintercept=163.1765, linetype="dashed", color = "red", size = 0.5)+
  theme_bw()

## E os participantes do g�nero masculino? O modelo indicou que a diferen�a ocasionada pela vari�vel g�nero � tal que, considerando a altura m�dia, um homem ter� um cal�ado 3.07 n�meros maiores que uma mulher. E qual a altura m�dia de um homem na nossa amostra? 1.7410. Um homem com essa altura, deveria ter um cal�ado de n�mero intercept + EstimateMasculino, isto � 37.3958 + 3.0217, ou 40.4175. Vamos ver se a linha de regress�o prev� que um homem de 1.74 calce um cal�ado de n�mero 40? Rode o c�digo abaixo:

ggplot(data, aes(altura, calcado))+
  geom_point(size = 3, alpha = 0.4, aes(colour = genero))+
  geom_smooth(method = "lm")+
  geom_hline(yintercept=40.4175, linetype="dashed", color = "blue", size = 0.5)+
  geom_vline(xintercept=174.1014, linetype="dashed", color = "blue", size = 0.5)+
  theme_bw()

## Mas eu preciso mesmo centrar minha vari�vel dependente? Em termos de testar a signific�ncia dos termos do seu modelo quando voc� n�o tem intera��o (aqui, "genero" e "altura"), isso n�o altera muita coisa em boa parte dos casos. No entanto, ao centrar nossa vari�vel dependente o intercept se torna mais informativo, e voc� come�a a ter uma no��o um pouco melhor do que um modelo linear est� fazendo. Se seu modelo tiver como vari�vel independente a intera��o entre fatores, n�o centrar a vari�vel resposta pode mascarar alguns efeitos, visto que o c�lculo est� sendo feito a partir do valor de y quando x = 0.