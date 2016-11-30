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
function PlotGrid;
include_variables;

% It plots the grid to verify that you entered the correct mesh

if (strcmpi(plot_mesh,'yes')==1)
    fprintf(1, ' Plotting grid...\n\n');
    figure;

    for i = 1:nel

        glb = Elems(:,i)';
        XX = [Nodes(1, glb),Nodes(1,glb(1))];
        YY = [Nodes(2, glb),Nodes(2,glb(1))];
        plot(XX,YY);hold on;

        if (strcmpi(plot_node,'yes')==1)
            if (ElementType ==1)
                text(XX(1),YY(1),sprintf('%d',Elems(1,i)));
                text(XX(2),YY(2),sprintf('%d',Elems(2,i)));
                text(XX(3),YY(3),sprintf('%d',Elems(3,i)));
                text(XX(4),YY(4),sprintf('%d',Elems(4,i)));
                text((XX(2)+XX(1))/2,(YY(3)+YY(2))/2,sprintf('(%d)',i),...
                    'HorizontalAlignment','center','VerticalAlignment','middle');
            elseif (ElementType ==2)
                text(XX(1),YY(1),sprintf('%d',Elems(1,i)));
                text(XX(2),YY(2),sprintf('%d',Elems(2,i)));
                text(XX(3),YY(3),sprintf('%d',Elems(3,i)));
                text((XX(2)+XX(1)+XX(3))/3,(YY(3)+YY(2)+YY(1))/3,sprintf('(%d)',i),...
                    'HorizontalAlignment','center','VerticalAlignment','middle');
            else
                fprintf(1, 'This element type is not implemented\n');
            end
        end

    end
    hold on;
    if (strcmpi(plot_boundary,'yes')==1)
        nbc = length(BoundaryElems);
        for i = 1:nbc
            BElems = BoundaryElems(i). Elems;
            SurfID = BoundaryElems(i).SurfaceIndicator;
            Num = length(BElems);
            for j = 1:Num
                elem = BElems(j);
                if (ElementType ==1)
                    switch(SurfID(j))
                        case -2
                            glb1 = Elems(1,elem); glb2 = Elems(2,elem);
                        case +1
                            glb1 = Elems(2,elem); glb2 = Elems(3,elem);
                        case +2
                            glb1 = Elems(3,elem); glb2 = Elems(4,elem);
                        case -1
                            glb1 = Elems(1,elem); glb2 = Elems(4,elem);
                    end
                elseif (ElementType ==2)
                    switch(SurfID(j))
                        case -2
                            glb1 = Elems(1,elem); glb2 = Elems(2,elem);
                        case +1
                            glb1 = Elems(2,elem); glb2 = Elems(3,elem);
                        case -1
                            glb1 = Elems(1,elem); glb2 = Elems(3,elem);
                    end
                end
                x1 = Nodes(1,glb1);y1 = Nodes(2,glb1);
                x2 = Nodes(1,glb2);y2 = Nodes(2,glb2);
                plot([x1 x2],[y1 y2],'r','LineWidth',3); hold on;
                text((x1+x2)/2,(y1+y2)/2,sprintf('%d',i),...
                    'HorizontalAlignment','center','VerticalAlignment','middle');
            end
        end
    end
    title('2D Grid Plot'); axis image;
end