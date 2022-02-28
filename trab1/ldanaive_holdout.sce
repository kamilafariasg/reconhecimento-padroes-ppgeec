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
base_treino=base;

// Dividindo as classes
[x1, y1] = find(base_treino(:, 35) == 1)
[x2, y2] = find(base_treino(:, 35) == 2)
[x3, y3] = find(base_treino(:, 35) == 3)
[x4, y4] = find(base_treino(:, 35) == 4)
[x5, y5] = find(base_treino(:, 35) == 5)
[x6, y6] = find(base_treino(:, 35) == 6)

X_treino = base_treino(:, 1:34);
m_cov_lda = cov(X_treino);
inv_m_cov = inv(m_cov_lda);
   
// Calculando os centróides
centroid_c1 = mean(X_treino(x1, :), 'r');
centroid_c2 = mean(X_treino(x2, :), 'r');
centroid_c3 = mean(X_treino(x3, :), 'r');
centroid_c4 = mean(X_treino(x4, :), 'r');
centroid_c5 = mean(X_treino(x5, :), 'r');
centroid_c6 = mean(X_treino(x6, :), 'r');

// Hold-out com sub-sampling de 20 execuções
x = grand(1, 'prm', 1:size(base)(1))(1:20)
base_teste = base(x, :);
base(x, :) = [];

X_teste = base_teste(:, 1:34)
Y_teste = base_teste(:, 35)
    
//auxiliares 
cont=0;   
a = size(X_teste);

//LDA
for i = 1:a(1)
    vetor_teste = X_teste(i, :)
    rotulo_teste = Y_teste(i)
    f1 = (vetor_teste - centroid_c1) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c1)'; 
    f2 = (vetor_teste - centroid_c2) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c2)'; 
    f3 = (vetor_teste - centroid_c3) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c3)'; 
    f4 = (vetor_teste - centroid_c4) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c4)'; 
    f5 = (vetor_teste - centroid_c5) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c5)'; 
    f6 = (vetor_teste - centroid_c6) * (eye(34,34).*inv_m_cov) * (vetor_teste - centroid_c6)';
    
    [a, b] = min([f1, f2, f3, f4, f5, f6])
    if rotulo_teste == b
        cont = cont + 1
    end
end

disp('Média de Acurácia LDA Versão Naive com Hold-Out:');
acuracia = cont/size(X_teste)(1) * 100
disp(acuracia);
