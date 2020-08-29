function new_problem=updatePROB(problem)
% updatePROB updates the data in a problem_data object

r=problem.rate;
b=problem.costofcarry;
K=problem.strike;
Sigma=problem.cov_matrix;
timeint=problem.time;

L=1;
U=2;

bdCond={@(s1,s2, t) 0,...
    @(s1,s2,t) doubleOUT_call(s1, K, L, U, t, r, b, Sigma(1,1)), ... 
    @(s1,s2,t) doubleOUT_call(s2, K, L, U, t, r, b, Sigma(2,2))};

initV=@(s1,s2) max(s1+s2-K, 0);
geom=problem.geometry;

new_problem=problem_data(r,b,K,Sigma, geom, bdCond, timeint, initV);

end
