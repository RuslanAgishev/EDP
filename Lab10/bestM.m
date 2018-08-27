load measurements
M = 40;
x1 = 5;
[Id_xb,Iv_xb, Id_r,Iv_r] = optindic(x1, z, M);

display(strcat('M=',num2str(M)));
display(strcat('Id_xb=',num2str(Id_xb)));
display(strcat('Iv_xb=',num2str(Iv_xb)));
display(strcat('Id_r=',num2str(Id_r)));
display(strcat('Iv_r=',num2str(Iv_r)));