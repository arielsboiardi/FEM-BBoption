function problem=makePROB(datafile)
% makePROB builds a problem_data object containing problem data specified
% in datafile

fp=mfilename('fullpath');
fp=erase(fp, mfilename);
run(strcat(fp,'/problems/',datafile))

problem=problem_data(r,b,K,Sigma, geom, bdCond, timeint, initV);

end