%% Demo FEM-BBoption 
close all; 
clear; clc
addpath(genpath('./'))

%% Introduction
fl=fileread('demos/demo_intro.txt');
fprintf(fl)

%% Choice
demo_choice=input('What demo are you interested in? [0-3]: ');
switch demo_choice
    case 0
        run('demos/demo0/demo0.m')
    case 1
        run('demos/demo1/demo1.m')
    case 2
        run('demos/demo2/demo2.m')
end