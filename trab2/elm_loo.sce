/* Kamila Amélia Sousa Gomes
   Questão 02 - ELM Leave-One-Out 
   Reconhecimento de Padrões - PPGEEC
*/

clear; 
clc;

//--------------------------------Lendo Base de Dados------------------------------------------
base = csvRead('dermatology.data')

//-----------------------------Pré-processamento de Dados--------------------------------------
[x_nulas, columns_remove] = find(string(base) == 'Nan') ///encontrando valores nulos
base(x_nulas, :) = [] //apagando a linha do valor nulo

//-------------------------------Randomizar Base de Dados -------------------------------------

base = base(grand(1, 'prm', (1:size(base)(1))), :);

/*
---------------------------------------------------------------------------------------------
Função responsável por randomizar, onde:

grand = função que gera números aleatórios, formada por:
            Y=grand(n,'prm',vect)
n = inteiros, tamanho da matriz desejada Y
prm = gera n permutações aleatórias do vetor coluna ( m x 1) vect.
vect = vetor/matriz

disponível em: https://help.scilab.org/docs/5.3.0/en_US/grand.html
--------------------------------------------------------------------------------------------

*/

//-------------------------------Variáveis Auxiliares para execução da ELM-------------------------------------
acc_final = 0;



p = 34; //quantidade de atributos
q = input("Digite a quantidade de Neurônios Ocultos desejada: ")//20; // quantidade de neuronios ocultos

W= rand(q,p+1,'normal'); //matriz de pesos aleatorios
//------------------------------- Normalização --------------------------------------------------

for i = 1:p
    base(:, i) = (base(:, i) - mean(base(:, i)))/stdev(base(:, i))
end


//-------------------------------Rótulos-------------------------------
/*
São 6 classes, onde: 
    Classe 1 será representada´por [1 0 0 0 0 0]
    Classe 2 será representada´por [0 1 0 0 0 0]
    Classe 3 será representada´por [0 0 1 0 0 0]
    Classe 4 será representada´por [0 0 0 1 0 0]
    Classe 5 será representada´por [0 0 0 0 1 0]
    Classe 6 será representada´por [0 0 0 0 0 1]
*/
for i = 1:358
    rotulo = base(i, 35)
    if rotulo == 1
        new_rotulo = [1, 0, 0, 0, 0, 0]
    elseif rotulo == 2
        new_rotulo = [0, 1, 0, 0, 0, 0]
    elseif rotulo == 3
        new_rotulo = [0, 0, 1, 0, 0, 0]
    elseif rotulo == 4
        new_rotulo = [0, 0, 0, 1, 0, 0]
    elseif rotulo == 5
        new_rotulo = [0, 0, 0, 0, 1, 0]
    elseif rotulo == 6
        new_rotulo = [0, 0, 0, 0, 0, 1]
    end
    base(i, 35:40) = new_rotulo
end

//-------------------------------Leave One Out ------------------------------------------------
for i = 1:358
    //variaveis auxiliares
    acc = 0;
    cont = 0;
    
    //Separando base treino e base teste
    base_treino = base
    base_treino(i, :) = []
    base_teste = base(i, :)
    
    // base treino
    X = base_treino(:, 1:34)
    D = base_treino(:, 35:40)
    
    // Base teste
    x_teste = base_teste(:, 1:34)
    d_teste = base_teste(:, 35:40)
    
    // Camada Oculta
    X = [(-1)*ones(1, 357);X']
    
    //Função ativação Sigmoide
    Z = 1./(1+exp(W*X))
    
    //Calculo dos Pesos dos Neuronios de Saida
    M = D'*Z'*(Z*Z'+0.01*eye(q, q))^(-1) // usando lambda = 0.01
    
    // Camada de Saída
    z_base_teste = W*[(-1)*ones(1, 1);x_teste']
    z_base_teste = 1./(1+exp(z_base_teste))
    output = M*z_base_teste
    
    // Validação
    [a b] = max(d_teste(1, :))
    [c d] = max(output(:, 1))
    
    if b==d
       cont = cont + 1
    end


    acc = cont / 1
    acc_final = acc_final + acc
end

//------------------------------- Resultado------------------------------------------------
disp('Média de Acurácia ELM com Leave-One-Out:');
acc_final = acc_final / 358;
disp(acc_final);
