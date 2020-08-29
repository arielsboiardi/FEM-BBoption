close all; clear; clc;
%% Load problem 0
problem=makePROB('problem0.m');

%% Introduction to thid demo
file_intro=fileread('demos/demo0/intro.txt');
fprintf(file_intro)

%% Geometry description 
fprintf('This is the domain of the problem \n')

figure;
problem.geometry.show('LineWidth',1.5,'EdgeColor','r')
title("Geometry of the domain",...
        'interpreter','latex','FontSize',14)

input('Enter to mesh the domain...')

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
cflag=input('Shall I compute the mass and stiffness matrices? [Y/n]: ','s');
if upper(cflag)=='N'
    return
end

M = Mass(msh);
A = Stiff(problem,msh);

sflag=input('Matrices computed! Do you want to see their structure? [y/N]: ','s');
if upper(sflag)=='Y'
    figure
    spy(A)
    title('Matrix sparsity pattern',...
        'interpreter','latex','FontSize',14)
end

%% Separation of nodes 
fprintf("I now separe Dirichlet and independent nodes\n")
[DIR, DIRid, IND] = GRPnodes(msh);
sflag=input("Do you want to check out the indices of Dirichlet nodes? [y/N]: ",'s');
if upper(sflag)=='Y'
    DIR
end

%% Final condition
w0=INITeval(problem.initV, msh); % Evaluate initial condition
w0(DIR(DIRid==1))=0; % Link initial and boundary condition to avoid instability

sflag=input("Do you want to see the payoff function? [y/N]: ",'s');
if upper(sflag)=='Y'
    figure
    TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);
    trisurf(TO, 'FaceColor', 'w')
    axis equal
    title("Payoff function, $V(S_1, S_2, T)$",...
        'interpreter','latex','FontSize',14)
end

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

sflag=input("Do you want to see the time evolution? [Y/n]: ",'s');
if isempty(sflag)
    sflag='Y';
end

for idx=1:Nt
    w1DIR = DIReval(problem.bdcond, DIR, DIRid, msh, Dt*(idx));
    F = R*w0;
    B = L*w1DIR;
    w1IND = PIND * (F - B);
    w1 = mergeDIRINDvals(w1DIR, w1IND, IND);
    w0=w1;
    
    if upper(sflag)~='N'
        TO=triangulation(msh.elems, msh.nodes(:,1), msh.nodes(:,2), w0);

        trisurf(TO, 'EdgeAlpha',0.3)
        axis equal
        title(sprintf("Solution at $t=%f$", Dt*(Nt-idx)),...
            'interpreter', 'latex', 'FontSize', 14)
        pause(0.1)
    end
end
