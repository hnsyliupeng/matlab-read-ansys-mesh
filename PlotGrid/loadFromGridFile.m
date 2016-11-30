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
function loadFromGridFile(prefix );
include_variables;

% load header file
filename = sprintf('%s.header', prefix);
fid = fopen(filename,'r');
if ( fid == -1)
    fprintf(1, 'The opening of the header-file %s failed!\n', filename);
    return;
end
fclose(fid);
A = load(filename);
nel = A(1,1);         % number of elements                            
nno = A(1,2);         % number of total nodes
nBC = A(1,3);         % number of boundaries
nsd = A(2,1);         % number of spacial dimensions
nen = A(2,2);         % number of nodes on each element 

fprintf(1, '\n Grid information:\n');
fprintf(1, ' The number of elements is %d\n', nel);
fprintf(1, ' The number of nodes is %d\n', nno);
fprintf(1, ' The number of boundary types is %d\n', nBC);

%initialize
Nodes = zeros(nsd,nno);
Elems = zeros(nen,nel);

if (nen == 4)
    ElementType = 1;                     %Q4 element
elseif (nen ==3)
    ElementType = 2;                     %T3 element
elseif (nen ==6)
     ElementType = 3;                     %T6 element
else
    fprintf(1, 'This element type is not implemented\n');
end

% load nodes file
filename = sprintf('%s.node', prefix);
fid = fopen(filename,'r');
if ( fid == -1)
    fprintf(1, 'The opening of the node-file %s failed!\n', filename);
    return;
end
fclose(fid);

A     = dlmread(filename);
Nodes = A(:,2:nsd+1)';

% load element file
filename = sprintf('%s.elem', prefix);
fid = fopen(filename,'r');
if ( fid == -1)
    fprintf(1, 'The opening of the element-file %s failed!\n', filename);
    return;
end
fclose(fid);

A     = load(filename);
Elems = A(:,1:nen)';


% load boundary file
filename = sprintf('%s.boundary', prefix);
fid = fopen(filename,'r');
if ( fid == -1)
    fprintf(1, 'The opening of the boundary-file %s failed!\n', filename);
    return;
end

for n = 1 : nBC
    BoundaryNodes(n).Nodes = [];
end
    
% Sep 22, 2009: Fix the bug on reading the boundary nodes
% when there is a negtive coordiate in the file.
% We try to find the first location of each boundary in the file
i = 0;
count=0;
while 1
    tline = fgetl(fid);
    matches = findstr(tline,'Boundary');
    num = length(matches);
    if (num > 0 || ~ischar(tline))
%        A = dlmread(filename,'',[row_begin 0 row_end-1 col]);
%        BoundaryNodes(i).Nodes = A(:,1);
        locali=0;
        i = i+1;
        if ~ischar(tline),   break,   end
    else
        count=count+1;
        locali=locali+1;
        curr_line=str2num(tline);
        if length(curr_line)==nsd
            A(count,1:nsd+1)=[curr_line, 0];
        else
            A(count,1:nsd+1)=curr_line(:);
        end
        BoundaryNodes(i).Nodes(locali) = A(count,1);
    end
       
end
fclose(fid);


% %    Generate a surface indicator array according to the boundary indicator
  surfaceIndicator = [1:nBC];

% initialize the boundary elements
for n = 1 : nBC
    BoundaryElems(n).Elems = [];
    BoundaryElems(n).SurfaceIndicator=[];
end

% generate the surface indicator
GenElmSurfaceIndicator(surfaceIndicator);

fprintf(1, ' Finish loading grid! \n\n');
% -----------------------------------------------------    
function GenElmSurfaceIndicator(surfaceIndicator);
include_variables;
%function GenElmSurfaceIndicator(surfaceIndicator);
%  Discussion:
%   
%    Set the surfaceIndicator for each element
%
%  Input:
%    surfaceIndicator -- Array of surfaceIndicator


                %{direction, NodeID1,   NodeID2}
B4n2DCheckArray= [-1 ,        1,          4;
                  +1 ,        2,          3;
                  -2 ,        1,          2;
                  +2 ,        3,          4];
              
                %{direction, NodeID1,   NodeID2}
T3n2DCheckArray= [-1 ,        1,          3;
                  +1 ,        2,          3;
                  -2 ,        1,          2];
                %{direction, NodeID1,   NodeID2}
T6n2DCheckArray= [-1 ,        1,     6;
                  +1 ,        2,     5;
                  -2 ,        1,     4;
                  -3 ,        6,     3;
                  +2,         4,      2;
                  +3,         5,     3];

% extract the number of surface indicator
n = length(surfaceIndicator);

for e = 1:nel
    
    IsApplied = 0;
    
    for i = 1 : nen
        if (ElementType == 1) 
        surfID = B4n2DCheckArray(i,1);
        elseif (ElementType == 2) 
        surfID = T3n2DCheckArray(i,1);    
        elseif (ElementType == 3) 
        surfID = T6n2DCheckArray(i,1);     
        end
        
        for k = 1:n
            indicator = surfaceIndicator(k);
            allInd = 1;

            for j = 2:3
                if (ElementType == 1) 
                a = B4n2DCheckArray(i,j);
                elseif (ElementType == 2) 
                a = T3n2DCheckArray(i,j);
                elseif (ElementType == 3) 
                a = T6n2DCheckArray(i,j);    
                end
                A = Elems(a,e);
                if ( ~IsBoundaryNode(A, indicator))
                    allInd = 0;
                    break;
                end
            end

            if (allInd)
                BoundaryElems(indicator).Elems = [ BoundaryElems(indicator).Elems,e];
                BoundaryElems(indicator).SurfaceIndicator =  [BoundaryElems(indicator).SurfaceIndicator, surfID];
            end
        end
    end    
end

function OnBoundary = IsBoundaryNode(glbNodeID, indicator)
include_variables;
% function OnBoundary = IsBoundaryNode(glbNodeID, indicator)
% Discussion:
%   Check if the current NODE is on the boundary with the given indicator.
% Input:
%   glbNodeID    : global node number
%   indicator    : boundary indicator
% Output:
%   OnBoundary : 1,yes otherwise 0, no

OnBoundary = 0;

for i = 1:length(BoundaryNodes)
    BNode = BoundaryNodes(i). Nodes;
    
    for  j = 1 : length(BNode)
        if ( BNode(j) == glbNodeID && i == indicator)
            OnBoundary = 1;
        end
        if (OnBoundary == 1)
            break;
        end
    end
end




