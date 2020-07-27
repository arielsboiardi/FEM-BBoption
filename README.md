# FEM-BBoption

 Codes for the final project of the course Mathamatical models in Finance

In this project the evaluation of a barrier basket option is carried out with FEM solution of the classical Black-Scholes-Morton equation. 

### What is missing

- [x] Appropriete data structure for mesh data
- [x] Appropriete data structure for domain geometry data
- [x] Assembly procedure 
  - [x] Mass matrix
  - [x] Stiffness matrix
- [x] Transfer meshing procedure to `tri_mesh`
- [x] Implement mesh refinement in `tri_mesh` class
  - [x] Build refinement method for the class
  - [x] Keep track o physical boundaries and boundary conditions in refinement
  - [ ] ~~Fix refinement procedure for non convex domains (remove non interior vertices)~~
  - [x] Fix all other usages of refinement
- [ ] Mass and stiffness matrix compilation 
- [ ] Boundary conditions in the system
- [ ] Make data structures more memory efficient via sparse matrices
