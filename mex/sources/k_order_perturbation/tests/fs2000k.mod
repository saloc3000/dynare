// This file replicates the estimation of the CIA model from 
// Frank Schorfheide (2000) "Loss function-based evaluation of DSGE models" 
// Journal of  Applied Econometrics, 15, 645-670.
// the data are the ones provided on Schorfheide's web site with the programs.
// http://www.econ.upenn.edu/~schorf/programs/dsgesel.ZIP
// You need to have fsdat.m in the same directory as this file.
// This file replicates: 
// -the posterior mode as computed by Frank's Gauss programs
// -the parameter mean posterior estimates reported in the paper
// -the model probability (harmonic mean) reported in the paper
// This file was tested with dyn_mat_test_0218.zip
// the smooth shocks are probably stil buggy
//
// The equations are taken from J. Nason and T. Cogley (1994) 
// "Testing the implications of long-run neutrality for monetary business
// cycle models" Journal of Applied Econometrics, 9, S37-S70.
// Note that there is an initial minus sign missing in equation (A1), p. S63.
//
// Michel Juillard, February 2004
// Modified for testing k_order_perturbation by GP, Jan-Feb 09

options_.usePartInfo=0;
options_.use_k_order=0;

//var m m_1 P P_1 c e W R k d n l gy_obs gp_obs Y_obs P_obs y dA P2 c2;
var m m_1 P P_1 c e W R k d n l gy_obs gp_obs y dA P2 c2;
varexo e_a e_m;

parameters alp bet gam mst rho psi del;

alp = 0.33;
bet = 0.99;
gam = 0.003;
mst = 1.011;
rho = 0.7;
psi = 0.787;
del = 0.02;

model (use_dll);
dA = exp(gam+e_a);
log(m) = (1-rho)*log(mst) + rho*log(m_1(-1))+e_m;
-P/(c(+1)*P(+1)*m)+bet*P(+1)*(alp*exp(-alp*(gam+log(e(+1))))*k^(alp-1)*n(+1)^(1-alp)+(1-del)*exp(-(gam+log(e(+1)))))/(c2(+1)*P2(+1)*m(+1))=0;
W = l/n;
-(psi/(1-psi))*(c*P/(1-n))+l/n = 0;
R = P*(1-alp)*exp(-alp*(gam+e_a))*k(-1)^alp*n^(-alp)/W;
1/(c*P)-bet*P*(1-alp)*exp(-alp*(gam+e_a))*k(-1)^alp*n^(1-alp)/(m*l*c(+1)*P(+1)) = 0;
c+k = exp(-alp*(gam+e_a))*k(-1)^alp*n^(1-alp)+(1-del)*exp(-(gam+e_a))*k(-1);
P*c = m;
m-1+d = l;
e = exp(e_a);
y = k(-1)^alp*n^(1-alp)*exp(-alp*(gam+e_a));
gy_obs = dA*y/y(-1);
gp_obs = (P/P_1(-1))*m_1(-1)/dA;
//Y_obs/Y_obs(-1) = gy_obs;
//P_obs/P_obs(-1) = gp_obs;
P2 = P(+1);
c2 = c(+1);
m_1 = m;
P_1 = P;
end;

initval;
m = mst;
m_1=mst;
P = 2.25;
P_1 = 2.25;
c = 0.45;
e = 1;
W = 4;
R = 1.02;
k = 6;
d = 0.85;
n = 0.19;
l = 0.86;
y = 0.6;
gy_obs = exp(gam);
gp_obs = exp(-gam); 
dA = exp(gam);
  P2=P;
  c2=c;
end;

shocks;
var e_a; stderr 0.014;
var e_m; stderr 0.005;
end;

//unit_root_vars P_obs Y_obs;

steady(solve_algo = 2);

check;

estimated_params;
alp, beta_pdf, 0.356, 0.02; 
bet, beta_pdf, 0.993, 0.002;
gam, normal_pdf, 0.0085, 0.003;
mst, normal_pdf, 1.0002, 0.007;
rho, beta_pdf, 0.129, 0.223;
psi, beta_pdf, 0.65, 0.05;
del, beta_pdf, 0.01, 0.005;
stderr e_a, inv_gamma_pdf, 0.035449, inf;
stderr e_m, inv_gamma_pdf, 0.008862, inf;
end;

//varobs P_obs Y_obs;
varobs gp_obs gy_obs;

steady(solve_algo = 2);

//observation_trends;
//P_obs (log(mst)-gam);
//Y_obs (gam);
//end;

//options_.useAIM = 1;
estimation(datafile=fsdat,nobs=192,loglinear,mh_replic=2000,
	mode_compute=4,mh_nblocks=2,mh_drop=0.45,mh_jscale=0.65);

