clc; clear;

//--------------------------------Lendo Base de Dados------------------------------------------
base = csvRead('dermatology.data');


//-----------------------------Pré-processamento de Dados--------------------------------------
[x_nulas, y] = find(string(base) == 'Nan'); //encontrando valores nulos
base(x_nulas, :) = [] //apagando a linha do valor nulo


//---------------------------------------------------------------------------------------------
// grand = Geradores de números aleatórios
//Y=grand(n,'prm',vect)
//prm gerar n permutações aleatórias do vetor coluna ( m x 1) vect.
//n = inteiros, tamanho da matriz desejada Y
//disponível em: https://help.scilab.org/docs/5.3.0/en_US/grand.html
//---------------------------------------------------------------------------------------------



//-------------------------------Randomizar Base de Dados -------------------------------------

base = base(grand(1, 'prm', (1:size(base)(1))), :);

//-------------------------------------Holdout-------------------------------------------------

// Hold-out com sub-sampling de 20 execuções
x = grand(1, 'prm', 1:size(base)(1))(1:20)

dataset = base(x, :);
base(x, :) = [];

//Separa o dataset de acordo com as colunas de x e y
x = dataset(:,1:34)';
x = x./max(x); //normaliza os valores de x para ficarem entre 0 e 1

y = dataset(:,35)';
y = y./max(y); //normaliza os valores de y para ficarem entre 0 e 1

quat_amostras = length(y); //quantidade de amostras por treinamento 
num_neuronios = 8;
//calculo dos centroides
index = grand(1,"prm",1:quat_amostras); //retorna para a variavel indice, os indices de 1 até a quantidade de amostras de forma embaralhada.
t = x(index(1:num_neuronios)); //recebe n valores de x, de forma aleatoria


//Cada valor de entrada vai ser processado pelos neuronios separadamente
sig = 1;
pv = ones(num_neuronios,quat_amostras); //retorna uma matriz num_neuroniosXN
for i=1:quat_amostras
    u = abs(repmat(x(i),1,num_neuronios) - t); //retorna os valores do vetor normalizados
    pv(:,i) = exp(-(u.^2/(2*sig)));
end

//adicionando o valor do -1 do bias no vetor
pv = [-1*ones(1,quat_amostras);pv];

lambda = 1*10.^(-9); //define o valor do lambda
B = y*pv'*(pv*pv'+lambda*eye(num_neuronios+1,num_neuronios+1))^(-1);
y_ = B*pv;

R2 = 1 - sum((y-y_).^2)/sum((y-mean(y)).^2);
disp("VALOR DE R2");
disp(R2);

title("Valor de R2 = " + string(R2));
plot(x,y,".");
plot(x,y_,"k--");

