%% Square with square hole
vertices=[0 0; 0 1; 1 1; 1 0];
inner_square=[0.25,0.25]+0.5*vertices;
additional_vertices=0.25*vertices;
additional_vertices=[additional_vertices; 
    [0,0.75]+additional_vertices;
    [0.75,0.75]+additional_vertices;
    [0.75,0]+additional_vertices];
vertices=[vertices; inner_square; additional_vertices];
edges=[1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5];
bdid=[];

clear additional_vertices inner_square 