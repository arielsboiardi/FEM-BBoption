function wh=solver_FEMBBoption(problem, mesh, options)
%FEMBBoSolver solution of the two asset double knock out barrier option 
% pricing with FEM-BBoption library. 
%
%   w=FEMBBoSolver(problem, mesh, options) computes the solution of the
%   problem with parameters problem, on the mesh. Options contians the
%   parameters of the solver such as time step and theta.
%
% Input:
%   problem: problem_data object with the parameters of the problem
%   mesh: tri_mesh containing the description of the mesh
%   options: solver_options containing parameters of the solver
%
% Output: 
%   wh: solution of problem approximated on the mesh with FEM-BBoption 
%

% Matrices computation
M = Mass(mesh);
A = Stiff(problem,mesh);

% Separation of nodes and matrix compilation 
[DIR, DIRid, IND] = GRPnodes(mesh);

A=rmRows(A,DIR);
M=rmRows(M,DIR);

%% Time discretization by theta-method

% Discretization parameters
Nt=options.Nt;
Dt=(problem.time(2)-problem.time(1))/Nt;

theta=options.theta;

% Matrices for theta-method
L = M/Dt + (1-theta)*A;
R = M/Dt - theta*A;

LIND = rmCols(L,DIR);
PIND=pinv(LIND);

%% Time evolution
w0=INITeval(problem.initV, mesh);
w0(DIR(DIRid==1))=0;

for idx=1:Nt
    w1DIR = DIReval(problem.bdcond, DIR, DIRid, mesh, Dt*(idx));
    F = R*w0;
    B = L*w1DIR;
    w1IND = PIND * (F - B);
    w1 = mergeDIRINDvals(w1DIR, w1IND, IND);
    w0=w1;
end
wh=w0;
end
