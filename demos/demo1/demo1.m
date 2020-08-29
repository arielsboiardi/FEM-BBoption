close all; clear; clc;
%% Load problem 0
problem=makePROB('problem0.m');

%% Introduction to this demo
file_intro=fileread('demos/demo1/intro.txt');
fprintf(file_intro)
problem.strike=input("K = ");

problem=updatePROB(problem);

%% Geometry discretization 
fprintf('The first mesh looks like this.\n')
figure(1)
msh=tri_mesh(problem.geometry);
msh.show;
msh.show_labels;
title("Meshed domain",...
        'interpreter','latex','FontSize',14)
n_of_refs=input('How many times shall I refine it? [0-5]: ');

%% Refinement
for idx=1:n_of_refs
    if idx>=6
        warning("Not enough memory for this grid, I will do 5 refinements")
        break
    end
    msh=msh.midsplitref;
end

fprintf('Here is your refined mesh! \n')

close
figure;
problem.geometry.show('LineWidth',1.5,'EdgeColor','r')
hold on; axis image off;
msh.show;
title("Refined mesh on the domain",...
        'interpreter','latex','FontSize',14)

%% Mass and stiffness matrix
M = Mass(msh);
A = Stiff(problem,msh);

%% Separation of nodes 
[DIR, DIRid, IND] = GRPnodes(msh);

%% Final condition
w0=INITeval(problem.initV, msh); % Evaluate initial condition
w0(DIR(DIRid==1))=0; % Link initial and boundary condition to avoid instability

%% Theta-method

% Discretization parameters
Nt=[];
while isempty(Nt)
    % Empty input is not admitted
    Nt=input("How many time steps shall I use?: ");
end

Dt=(problem.time(2)-problem.time(1))/Nt;
fprintf("The time step is %f\n", Dt)

theta=[];
while isempty(theta)
    theta=input("What theta-method do you want to use? \nRemeber that theta>1/2 is unstable! \ntheta = ");
end
    
% Matrices for theta-method
L = M/Dt + (1-theta)*A;
R = M/Dt - theta*A;
% Remove columns
LIND = rmCols(L,DIR);
% Since the iteration is alway the same it is usefull to compute once for
% all the pseuo inverse
PIND=pinv(LIND);

%% Time resolution 
cflag=input("Shall I procede to the time resolution? [Y/n]: ",'s');
if upper(cflag)=='N'
    return
end
close all

sflag=input("Do you want to see the time evolution? [y/N]: ",'s');
if isempty(sflag)
    sflag='N';
end

for idx=1:Nt
    w1DIR = DIReval(problem.bdcond, DIR, DIRid, msh, Dt*(idx));
    F = R*w0;
    B = L*w1DIR;
    w1IND = PIND * (F - B);
    w1 = mergeDIRINDvals(w1DIR, w1IND, IND);
    w0=w1;
    
    if upper(sflag)=='Y'
        TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);

        trisurf(TO, 'EdgeAlpha',0.3)
        axis equal
        title(sprintf("Solution at $t=%f$", Dt*(Nt-idx)),...
            'interpreter', 'latex', 'FontSize', 14)
        pause(0.1)
    end
end


figure
TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);
trisurf(TO, 'EdgeAlpha', 0.3)
axis equal
print('xport_figure','-dsvg', '-painters')
pause
