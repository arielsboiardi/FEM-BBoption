function geom=MakeGEOM(shapefile)
% MakeGEOM builds a poly_geo object from instruction in a given file in the
% geometries folder

fp=mfilename('fullpath');
fp=erase(fp, mfilename);
run(strcat(fp,'/geometries/',shapefile))

geom=poly_geo(vertices, edges, bdid);