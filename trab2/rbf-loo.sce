/* Kamila Amélia Sousa Gomes
   Questão 02 RBF sem sucesso
   Reconhecimento de Padrões - PPGEEC
*/

clear;
clc

//-------------------------------------Lendo Base de Dados--------------------------------
base = csvRead('dermatology.data');

//-----------------------------Pré-processamento de Dados--------------------------------------
[x_nulas, columns_remove] = find(string(base) == 'Nan') ///encontrando valores nulos
base(x_nulas, :) = [] //apagando a linha do valor nulo

//-------------------------------Randomizar Base de Dados -------------------------------------

base = base(grand(1, 'prm', (1:size(base)(1))), :);

X = base(:, 1:34);
[N p] = size(X);

//-------------------------------------Normalização--------------------------------------
for i = 1:34
    X = X/max(X)
    //X(:, i) = (X(:, i)-mean(X(:, i)))/stdev(X(:, i))
end

D = base(:, 35);

//-----------------------------------Preparação de Rótulos-------------------------------
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
    label = base(i, 35)
    if label == 1
        new_label = [1, 0, 0, 0, 0, 0]
    elseif label == 2
        new_label = [0, 1, 0, 0, 0, 0]
    elseif label == 3
        new_label = [0, 0, 1, 0, 0, 0]
    elseif label == 4
        new_label = [0, 0, 0, 1, 0, 0]
    elseif label == 5
        new_label = [0, 0, 0, 0, 1, 0]
    elseif label == 6
        new_label = [0, 0, 0, 0, 0, 1]
    end
    base(i, 35:40) = new_label
end

//-----------------------------------Variáveis Auxiliares-------------------------------
q = 5;
Z = zeros(N-1, q);
z_teste = zeros(q, 1);

cont = 0;
//-----------------------------------Leave One Out-------------------------------
for i=1:358
    x_teste = X(i, :);
    d_teste = D(i, :);
    
    x_treino = X;
    d_treino = D;
    
    x_treino(i, :) = [];
    d_treino(i, :) = [];
    
    C = rand(q, p, 'normal');
    
    for i = 1:N-1
        for j = 1:q
            norma = norm(x_treino(i,:)-C(j,:));
            Z(i, j) = exp(-norma^2)
        end
    end   
    
    Zt = Z';
    dt = d_treino';
    Zt = [(-1)*ones(1, N-1); Zt]
    M = dt*Zt'*(Zt*Zt'+0.01*eye(q+1, q+1))^(-1); //usando lambda 0.01
    
    for i = 1:q
        z_teste(i) = exp(-norm(x_teste-C(i, :))^2);
    end
    
    zt_teste = [-1; z_teste];
    y_teste = M*zt_teste
    
    [a b] = max(d_teste)
    [c d] = max(y_teste)
    if b == d 
        cont = cont + 1
    end
end
//-------------------------------------------Resultado----------------------------------------------------
disp('Acurácia:')
acc = cont / 358;
disp(acc)


