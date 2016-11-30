function [node,element]=loadmeshes(prefix )
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
     ElementType = 3;                    %T6 element
elseif (nen ==8)
     ElementType = 8;                    %Q8 element
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

node=Nodes';
element=Elems';
