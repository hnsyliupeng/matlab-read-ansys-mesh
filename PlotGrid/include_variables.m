% ------------------------------------------------------------------------|
%                                                                         |
% MAE4700-5700, Finite Element Analysis for Mechanical & Aerospace Design |
%                                                                         |
% Copyright: Cornell University (this software should not be used without |
% written permission)                                                     |
%                                                                         |
% Authors: N. Zabaras (zabaras@cornell.edu) & Xiang Ma (xm25@cornell.edu) |
%                                                                         |
% ------------------------------------------------------------------------|
%

% File to include global variables

% nsd :           number of spatial dimensions
% nno :           number of total nodes
% nel :           number of total elements
% nen :           number of nodes on each element
% ndof:           degrees-of-freedom per node
% neq :           number of equations


global nsd nno nel nen ndof neq 

% Nodes:          Nodes(a,j) denotes the coordinates in the ith 
%                 direction on the jth node.

% Elems:          Connectivity information matrix. 
%                 global node number = Elems(local node number, 
%                                            element number) 

%  ElementType: 1: Quadrilateral, 2: Triangle

global Nodes Elems ElementType


% BoundaryNodes is an array of struct. Its length equals the number of
% boundaries. For each component, it has a vector which contains all 
% global node number on this boundary. i.e.
%       BoundaryNodes(i). Nodes =[global node number on ith boundary   ]

% Similarly, BoundaryElems is also an array of struct. Its length equals the number of
% boundaries. For each component, it has a vector which contains all 
% elems number on this boundary. i.e.
%       BoundaryElems(i). Elems =[global element number on ith boundary   ]
% It also contains a vector of surface indicatior which indicates the
% surface of the local finite elemnts according to the order in the
% BoundaryElem(i).Elems vector.
%       BoundaryElems(i). SurfaceIndicator = [].

% In general, the program will automatically set up these data.


global BoundaryNodes BoundaryElems 


% plot_mesh - string for output control: ['yes'] to plot the FE mesh
% plot_node - string for output control: ['yes'] to plot global node numbers
% plot_boundary - string for output control: ['yes'] to plot the boundary
% For big mesh, it is better not to plot node number and only plot the boundary.
global plot_mesh plot_node  plot_boundary 

