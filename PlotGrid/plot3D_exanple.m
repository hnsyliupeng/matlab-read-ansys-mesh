%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Writed by Liu Peng
% Email:hao122012@163.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%path(path,'./PlotGrid')
[node,element]=loadmeshes3d('bamboo');
% id=[1 2;2 3;3 4;4 1;5 6;6 7;7 8;8 5;1 5;2 6;3 7;4 8];
% iface=[1 2 3 4;2 3 6 7;1 4 8 5;3 4 8 7;1 2 6 5;5 6 7 8];
% id=[1 2 3 4 1]
% id1=[5 6 7 8 5];
% id2=[1 5 8 4 1 ];
% id3=[2 6 7 3 2];
% for iel=1:size(element,1)
%     sctr=element(iel,:);
% %     nnode=node(sctr(iface),:);
% %     nnode=nnode';
%     nl=sctr(id);
%     plot3(node(nl,1),node(nl,2),node(nl,3))
%     hold on
%     nl=sctr(id1);
%     plot3(node(nl,1),node(nl,2),node(nl,3))
%     hold on
%     nl=sctr(id2);
%     plot3(node(nl,1),node(nl,2),node(nl,3))
%     hold on
%     nl=sctr(id3);
%     plot3(node(nl,1),node(nl,2),node(nl,3))
% end

for iel=1:size(element,1)
    id=[1 2 3 4];
    id1=[2 6 7 3];
    id2=[3 4 8 7];
    id3=[1 4 8 5];
    id4=[1 2 6 5];
    id5=[5 6 7 8];
    sctr=element(iel,:);
    nl=sctr(id);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    hold on
    
    nl=sctr(id1);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    hold on
    nl=sctr(id2);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    hold on
    nl=sctr(id3);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    
    hold on
    nl=sctr(id4);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
    
    hold on
    nl=sctr(id5);
    nod1=node(nl,:);
    nod1=nod1';
    fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')
end
nl=sctr(id3);
nod1=node(nl,:);
nod1=nod1';
fill3(nod1(1,:),nod1(2,:),nod1(3,:),'b')


axis off
axis equal