clear; clc; 

//Lendo Base de Dados
base = fscanfMat('aerogerador.dat'); 

x = base(:,1);  
y = base(:,2); 
n= length(x);

//Plotando Base de Dados
//plot(x,y,'*');


//Divisão de Classes

base1 = []
base2 = []
base3 = []

//Intervalos
for i = 1:n(1)
    x = base(i, :)
    if x(1) <= 4 then
        base1 = cat(1, base1, x)
   elseif x(1) > 4 && x(1) < 7 then
       base2 = cat(1, base2, x)
   elseif x(1) >= 7 then
        base3 = cat(1, base3, x)
   end
end


//-------------------------------------------------------------------------------------------------------------------------------------------------
//Regressão Linear Classe 1
x_c1 = base1(:, 1);
y_c1 = base1(:, 2);

n_c1= length(x_c1);

beta_1_c1 = (sum(x_c1.*y_c1)-(1/n_c1)*sum(y_c1)*sum(x_c1))/(sum(x_c1.^2)-(1/n_c1)*sum(x_c1)^2);
beta_0_c1=mean(y_c1)-beta_1_c1*mean(x_c1);
y_chap_c1=beta_0_c1+beta_1_c1*x_c1;


//Equação para o cálculo de R2
R2_classe1 = 1 - sum((y_c1-y_chap_c1).^2)/sum((y_c1-mean(y_c1)).^2);  
printf('O valor de R2 para Classe 1= %f\n', R2_classe1);


//Plotando Reta da Regressão Linear
xset('window', 1); //Apagar para plotar todos os gráficos em uma janela
scatter(x_c1, y_c1, style=color("blue"))
title('O valor de R2 para Subdivisão 1=  ' + string(R2_classe1))
plot2d(x_c1, y_chap_c1 ,style=color("red"))
//-------------------------------------------------------------------------------------------------------------------------------------------------
//Regressão Linear Classe 2
x_c2 = base2(:, 1);
y_c2 = base2(:, 2);

n_c2= length(x_c2);

beta_1_c2 = (sum(x_c2.*y_c2)-(1/n_c2)*sum(y_c2)*sum(x_c2))/(sum(x_c2.^2)-(1/n_c2)*sum(x_c2)^2);
beta_0_c2=mean(y_c2)-beta_1_c2*mean(x_c2);
y_chap_c2=beta_0_c2+beta_1_c2*x_c2;

//Equação para o cálculo de R2
R2_classe2 = 1 - sum((y_c2-y_chap_c2).^2)/sum((y_c2-mean(y_c2)).^2);  
printf('O valor de R2 para Subdivisão 2 = %f\n', R2_classe2);

//Plotando Reta da Regressão Linear
xset('window', 2);
scatter(x_c2, y_c2, style=color("blue"))
title('O valor de R2 para Classe 2=  ' + string(R2_classe2))
plot2d(x_c2, y_chap_c2 ,style=color("black"))
  
//-------------------------------------------------------------------------------------------------------------------------------------------------
//Regressão Linear Classe 3
x_c3 = base3(:, 1);
y_c3 = base3(:, 2);

n_c3= length(x_c3);

beta_1_c3 = (sum(x_c3.*y_c3)-(1/n_c3)*sum(y_c3)*sum(x_c3))/(sum(x_c3.^2)-(1/n_c3)*sum(x_c3)^2);
beta_0_c3=mean(y_c3)-beta_1_c3*mean(x_c3);
y_chap_c3=beta_0_c3+beta_1_c3*x_c3;


//Equação para o cálculo de R2
R2_classe3 = 1 - sum((y_c3-y_chap_c3).^2)/sum((y_c3-mean(y_c3)).^2);  
printf('O valor de R2 para Classe 3= %f\n', R2_classe3);

//Plotando Reta da Regressão Linear
xset('window', 3);
scatter(x_c3, y_c3, style=color("blue"))
title('O valor de R2 para Subdivisão 3=  ' + string(R2_classe3))
plot2d(x_c3, y_chap_c3 ,style=color("yellow"))  
//-------------------------------------------------------------------------------------------------------------------------------------------------


