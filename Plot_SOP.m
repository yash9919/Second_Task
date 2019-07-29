load SOP.mat
lambdas=0:5:30;

semilogy(lambdas,SOP_val(1:7),'b');
title('Line Plot of SOP vs Lambda for various values of N')
ylabel('SOP');
xlabel('Lambda');
hold on;
semilogy(lambdas,SOP_val(8:14),'r');
hold on;
semilogy(lambdas,SOP_val(15:21),'g');
hold on;
semilogy(lambdas,SOP_val(22:28),'y');
 hold off;
legend('N=1','N=2','N=3','N=4');
