clc; clear;

//--------------------------------Lendo Base de Dados-------------------------------------------
base = csvRead('dermatology.data');

//--------------------------Pré-processamento de Dados------------------------------------------
[x_nulas, y] = find(string(base) == 'Nan') //encontrando valores nulos
base(x_nulas, :) = [] //apagando a linha do valor nulo
[x, y] = size(base);


//--------------------------Leave one out------------------------------------------
cont=0; //variável auxiliar

// Leave one out
for i = 1:x
    base_treino=base;
    
    base_teste = base(i, :);
    rotulo_teste=base_teste(35);
    vetor_teste = base_teste(1:34); //// teste para cada amostra
    
    base_treino(i, :) = []
    
    // Dividindo as classes
    [x1, y1] = find(base_treino(:, 35) == 1)
    [x2, y2] = find(base_treino(:, 35) == 2)
    [x3, y3] = find(base_treino(:, 35) == 3)
    [x4, y4] = find(base_treino(:, 35) == 4)
    [x5, y5] = find(base_treino(:, 35) == 5)
    [x6, y6] = find(base_treino(:, 35) == 6)
    
    base_treino_x = base_treino(:, 1:34);
    m_cov_lda = cov(base_treino_x);
    inv_m_cov = inv(m_cov_lda)
   
    // Calculando os centróides
    centroid_c1 = mean(base_treino_x(x1, :), 'r');
    centroid_c2 = mean(base_treino_x(x2, :), 'r');
    centroid_c3 = mean(base_treino_x(x3, :), 'r');
    centroid_c4 = mean(base_treino_x(x4, :), 'r');
    centroid_c5 = mean(base_treino_x(x5, :), 'r');
    centroid_c6 = mean(base_treino_x(x6, :), 'r');
    
    
    //LDA
    f1 = (vetor_teste - centroid_c1) * inv_m_cov * (vetor_teste - centroid_c1)'; 
    f2 = (vetor_teste - centroid_c2) * inv_m_cov * (vetor_teste - centroid_c2)'; 
    f3 = (vetor_teste - centroid_c3) * inv_m_cov * (vetor_teste - centroid_c3)'; 
    f4 = (vetor_teste - centroid_c4) * inv_m_cov * (vetor_teste - centroid_c4)'; 
    f5 = (vetor_teste - centroid_c5) * inv_m_cov * (vetor_teste - centroid_c5)'; 
    f6 = (vetor_teste - centroid_c6) * inv_m_cov * (vetor_teste - centroid_c6)';
    
    [a, b] = min([f1, f2, f3, f4, f5, f6])
    
    if rotulo_teste == b
        cont = cont + 1
    end
end

disp('Acurácia LDA utilizando Leave-one-out::');
acuracia = cont/x * 100
disp(acuracia);

