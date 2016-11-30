%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writed by Liu Peng
% Email:hao122012@163.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% path(path,'./PlotGrid')
[node,element]=loadmeshes('ansys');%Read the nodes and elements from ansys
node=[node zeros(size(node,1),1)];
%Filling the element
for iel=1:size(element,1)
    id=[1 2 3 4];
    sctr=element(iel,:);
    nl=sctr(id);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    hold on
      
end
 view(2)
axis off
axis equal