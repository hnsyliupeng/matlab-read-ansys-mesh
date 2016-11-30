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

% This is the main program for plotting mesh which is from the four grid
% files.
%
% When you load grid which is generated from ANSYS, the boundary indicators
% is generall not in a sequential order. You may use this code to plot the
% mesh in order to check your boundary indicator before actually solving your
% prolbem.


clc;
clear all;
close all; 

include_variables;      % include global variables

plot_mesh = 'yes';
plot_node = 'no';
plot_boundary = 'yes';

loadFromGridFile('ansys'); % Here there is no need to give the full name of the
                        % file, you only need to give the prefix of the files. 

PlotGrid;               % plot the grid and related boundary indicator

