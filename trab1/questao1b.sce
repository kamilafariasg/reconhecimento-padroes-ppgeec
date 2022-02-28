clear; clc;

//Lendo Base de Dados
base = fscanfMat('aerogerador.dat'); 

//Separando base de Dados
x = base(:,1);  
y = base(:,2); 
n = size(base)(1);

//Plotando Base de Dados
plot(x,y,'*');

//--------------------------------------------------------Polinômio Grau 2------------------------------------------------------------------------

A = [x.^2 x x.^0];///Devido ao aumento do grau do polinomio, deve-se também aumentar o numero de colunas com 1's
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;

printf('Polinomio de Grau 2\n')

//Cálculo do R2
R2_p2 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 2= %f\n', R2_p2);

//Cálculo do R2 ajustado
p = 2 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
R2_ajustado_p2 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 2 = %f\n', R2_ajustado_p2);

//Gráfico
//title('R2 polinômio grau 2:  ' + string(R2_p2) + '  -  ' + 'R2 ajustado polinômio grau 2: ' + string(R2_ajustado_p2))
plot(x,Y_chap,'y-','linewidth',4);

//--------------------------------------------------------Polinômio Grau 3-------------------------------------------------------------------------

A = [x.^3 x.^2 x x.^0];//Devido ao aumento do grau do polinomio, deve-se também aumentar o numero de colunas com 1's
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;


printf('Polinomio de Grau 3\n')

//Cálculo do R2
R2_p3 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 3= %f\n', R2_p3);

//Cálculo do R2 ajustado
p = 3 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
R2_ajustado_p3 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 3 = %f\n', R2_ajustado_p3);

//Gráfico
//title('R2 polinômio grau 3:  ' + string(R2_p3) + '  -  ' + 'R2 ajustado polinômio grau 3: ' + string(R2_ajustado_p3))
plot(x,Y_chap,'r-','linewidth',3);

//--------------------------------------------------------Polinômio Grau 4-------------------------------------------------------------------------

A = [x.^4 x.^3 x.^2 x x.^0]; //Devido ao aumento do grau do polinomio, deve-se também aumentar o numero de colunas com 1's
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;

printf('Polinomio de Grau 4\n')

//Cálculo do R2
R2_p4 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 4= %f\n', R2_p4);

//Cálculo do R2 ajustado
p = 4 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
[l,c] = size(Y_chap);
n = l;
R2_ajustado_p4 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 4 = %f\n', R2_ajustado_p4);

//Gráfico
//title('R2 polinômio grau 4:  ' + string(R2_p4) + '  -  ' + 'R2 ajustado polinômio grau 4: ' + string(R2_ajustado_p4))
plot(x,Y_chap,'g-','linewidth',4);

//--------------------------------------------------------Polinômio Grau 5-------------------------------------------------------------------------

A = [x.^5 x.^4 x.^3 x.^2 x x.^0];///Devido ao aumento do grau do polinomio, deve-se também aumentar o numero de colunas com 1's
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;

printf('Polinomio de Grau 5\n')

//Cálculo do R2
R2_p5 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 5= %f\n', R2_p5);

//Cálculo do R2 ajustado
p = 5 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
R2_ajustado_p5 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 5 = %f\n', R2_ajustado_p5);

//Gráfico
//title('R2 polinômio grau 5:  ' + string(R2_p5) + '  -  ' + 'R2 ajustado polinômio grau 5: ' + string(R2_ajustado_p5))
plot(x,Y_chap,'c-','linewidth',4);

//--------------------------------------------------------Polinômio Grau 6-------------------------------------------------------------------------

A = [x.^6 x.^5 x.^4 x.^3 x.^2 x x.^0];
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;


printf('Polinomio de Grau 6\n')

//Cálculo do R2
R2_p6 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 6= %f\n', R2_p6);

//Cálculo do R2 ajustado
p = 6 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
R2_ajustado_p6 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 6= %f\n', R2_ajustado_p6);

//Gráfico
//title('R2 polinômio grau 6:  ' + string(R2_p6) + '  -  ' + 'R2 ajustado polinômio grau 6: ' + string(R2_ajustado_p6))
plot(x,Y_chap,'m-','linewidth',4);

//--------------------------------------------------------Polinômio Grau 7-------------------------------------------------------------------------

A = [x.^7 x.^6 x.^5 x.^4 x.^3 x.^2 x x.^0];
vetor_beta = (A'*A)^(-1)*A'*y;
Y_chap = A*vetor_beta;

printf('Polinomio de Grau 7\n')

//Cálculo do R2
R2_p7 = 1 - sum((y-Y_chap).^2)/sum((y-mean(y)).^2); 
printf('O valor de R2 para polinômio de grau 7= %f\n', R2_p7);

//Cálculo do R2 ajustado
p = 7 + 1; // p é usado no cálculo de r2 ajustado e 3 é o grau do polinomio.
R2_ajustado_p7 = 1 - ((sum((y-Y_chap).^2))/(n-p))/((sum((y-mean(y)).^2))/(n-1));
printf('O valor de R2 ajustado para polinômio de grau 7= %f\n', R2_ajustado_p7);

//Gráfico
//title('R2 polinômio grau 7:  ' + string(R2_p7) + '  -  ' + 'R2 ajustado polinômio grau 6: ' + string(R2_ajustado_p7))
plot(x,Y_chap,'k-','linewidth',4);
//-------------------------------------------------------------------------------------------------------------------------------------------------

legend('Dados', 'Grau 2', 'Grau 3', 'Grau 4', 'Grau 5','Grau 6','Grau 7');

