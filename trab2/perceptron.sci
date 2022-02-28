/* Kamila Amélia Sousa Gomes
   Trabalho 02 - Questão 01
   Reconhecimento de Padrões - PPGEEC
*/

clear;
clc;

pontos = input('Digite a quantidade de pontos necessárias:')
for i = 1:pontos 
    clas(i) = input('Digite a classe(0 ou 1):')
        if clas(i)<>0 & clas(i)<>1 then
            disp('Esta classe não existe')
        elseif clas(i) == 0 then
            k1(i) = input('x da Classe0: ')
            k2(i) = input('y da Classe0:: ')
            k3(i) = input('z da Classe0:: ')
            
            clas2 = [k1 k2 k3 clas];
        else 
            k4(i) = input('x da Classe1: ')
            k5(i) = input('x da Classe1:')
            k6(i) = input('x da Classe1:')
            clas1 = [k4 k5 k6 clas];
  
        end

    disp('---------------------------------------------------------')  
end


//Preparando a base de dados

dados = cat(1,clas1,clas2) //concatenação de acordo com as linhas 
[rows d] = size(dados)
bias= (-1)*ones(rows,1) //criação da coluna bias
base = cat(2,bias,dados) //adicionando a coluna bias a matriz


// Pesos aleatórios
W = [];
for i = 1:4
    W(i) = rand()
end



// Percorrendo a matriz
for epoca = 1:10
    
    for it = 1:pontos
        
    // divisão entre os rotulos e atributos
    entrada = base(1,1:4)
    alvo = base(1,5)
    
    // Função da perceptron
    saida = entrada*W
    
    // Função de ativação
    if saida>=0 then
        saida=1
    else 
        saida=0
    end
    // calculo do erro
    erro = alvo - saida

    //Aprendizagem
    taxa_aprend = 0.5
    for i=1:4
        W(i)=W(i)+taxa_aprend*erro*entrada(i); //perceptron
    end
    
    disp('-------------Resultados--------------')
    disp('Epoca:')
    disp(epoca)
    disp('Entrada:')
    disp(entrada)
    disp('Saída esperada:')
    disp(alvo)
    disp('Saída real:')
    disp(saida)
    disp('Erro:')
    disp(erro)
    disp('Pesos')
    disp(W)
    end

end

// ---------------------------------Plotando Gráfico-----------------------------------------------------------------
scatter3d(clas1(:,1),clas1(:,2),clas1(:,3),'+',"markerEdgeColor", 'red') //classe1
scatter3d(clas2(:,1),clas2(:,2),clas2(:,3),'*',"markerEdgeColor", 'blue') //classe2

//intervalo´para plotagem
h = -100:5:100;
t = -100:5:100;

[H,T] = meshgrid(h,t);

beta = (W(1,1) - H*W(2,1) - T*W(3,1))/W(4,1) // plano
mesh(H,T,beta) //plotando gráfico 
