var DOTQ Q1 Q2 Q3 Q4 X1 X2 X3 X4 C D1 D2 D3 D4 V;

varexo E_D1 E_D2 E_D3 E_D4;

parameters beta, r1, r2, r3, r4, gamma, ed1, ed2, ed3, ed4, rho1, rho2, rho3, rho4;

beta = 0.95;
r1 = 0.2;
r2 = 0.1;
r3 = 0.06;
r4 = 0.03;

gamma = 0.7;
ed1 = 0.1;
ed2 = 0.1;
ed3 = 0.1;
ed4 = 0.1;

rho1 = 0.3;
rho2 = 0.01;
rho3 = 0.6;
rho4 = 0.6;

model;
1 = (C + X1 + X2 + X3 + X4)/ (D1*Q1 + D2*Q2 + D3*Q3 + D4*Q4);
1 = (Q1(-1) + X1(-1) - r1*X1(-1)*X1(-1))/(DOTQ*Q1);  
1 = (Q2(-1) + X2(-1) - r2*X2(-1)*X2(-1))/(DOTQ*Q2);
1 = (Q3(-1) + X3(-1) - r3*X3(-1)*X3(-1))/(DOTQ*Q3);  
1 = (Q4(-1) + X4(-1) - r4*X4(-1)*X4(-1))/(DOTQ*Q4);
Q1+Q2+Q3+Q4 = 1;
1 = beta*DOTQ(+1)^(-gamma)*C(+1)^(-gamma)/(1-2*r1*X1(+1))*(D1(+1)*(1-2*r1*X1(+1))+1)/(C^(-gamma)/(1-2*r1*X1));
1 = beta*DOTQ(+1)^(-gamma)*C(+1)^(-gamma)/(1-2*r2*X2(+1))*(D2(+1)*(1-2*r2*X2(+1))+1)/(C^(-gamma)/(1-2*r2*X2));
1 = beta*DOTQ(+1)^(-gamma)*C(+1)^(-gamma)/(1-2*r3*X3(+1))*(D3(+1)*(1-2*r3*X3(+1))+1)/(C^(-gamma)/(1-2*r3*X3));
1 = beta*DOTQ(+1)^(-gamma)*C(+1)^(-gamma)/(1-2*r4*X4(+1))*(D4(+1)*(1-2*r4*X4(+1))+1)/(C^(-gamma)/(1-2*r4*X4));


1 = D1(-1)^rho1/D1*ed1^(1-rho1)*exp(E_D1);
1 = D2(-1)^rho2/D2*ed2^(1-rho2)*exp(E_D2);
1 = D3(-1)^rho3/D3*ed3^(1-rho3)*exp(E_D3);
1 = D4(-1)^rho4/D4*ed4^(1-rho4)*exp(E_D4);

/*
D1-ed1 = rho1*(D1(-1)-ed1) + E_D1;
D2-ed2 = rho2*(D2(-1)-ed2) + E_D2;
D3-ed3 = rho3*(D3(-1)-ed3) + E_D3;
D4-ed4 = rho4*(D4(-1)-ed4) + E_D4;
*/

V/(C^(1-gamma)/(1-gamma) + beta*V(+1)) = 1;
end;

initval;
Q1	=0.0769231;
Q2	=0.1538462;
Q3	=0.2564103;
Q4	=0.5128205;
X1	=0.0049761;
X2	=0.0099522;
X3	=0.0165871;
X4	=0.0331741;
D1	=0.1;
D2	=0.1;
D3	=0.1;
D4	=0.1;
DOTQ	=1.0646251;
C	=0.0353105;
V	=24.450057;
end;

/*
vcov = [
0.0005 0 0 0;
0 0.00025 0 0;
0 0 0.0005 0;
0 0 0 0.00025
];
*/

vcov = [
0.05 0 0 0;
0 0.025 0 0;
0 0 0.05 0;
0 0 0 0.025
];

order=4;
