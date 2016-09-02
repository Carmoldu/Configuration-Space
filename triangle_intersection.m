function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag=true;

   aux1=checkEdge(P1(1,:),P1(2,:),P1(3,:),P2);
   aux2=checkEdge(P1(3,:),P1(1,:),P1(2,:),P2);
   aux3=checkEdge(P1(2,:),P1(3,:),P1(1,:),P2);

   
   aux4=checkEdge(P2(1,:),P2(2,:),P2(3,:),P1);
   aux5=checkEdge(P2(3,:),P2(1,:),P2(2,:),P1);
   aux6=checkEdge(P2(2,:),P2(3,:),P2(1,:),P1);
   
   if aux1 && aux2 && aux3 && aux4 && aux5 && aux6
      flag=true; 
   end
   

% xi = polyxpoly(P1(:,1),P1(:,2),P2(:,1),P2(:,2),'unique');
% 
% if isempty(xi)
%     flag=false;
% end

% *******************************************************************
end


function [Sign] = pointSign (A,B,C)
%This function returns the sign of the function of the line between A and B
%when C coordinates are introduced. Negative values mean that C is at the
%left of the line joining A and B and positive at the right.

    %compute the slope and offset of the function f(x,y)=Y-m*X-b
    m=(B(2)-A(2))/(B(1)-A(1));
    
    b=A(2)-m*A(1);
    
    if isnan(b)==1  %This takes care of vertical lines, as b would return NaN due to m being Inf
        b=0;
    end
    
    Sign=sign(C(2)-m*C(1)-b);
end

function flag = sameSign(A,B)
%Compares the sign of the entries and returns a flag acordingly

    if sign(A)==sign(B)    
        flag=true;
    else
        flag=false;
    end

end


function flag = checkEdge(A, B, C, P)
%this function checks if all the vertexes of one triangle fall at one side
%of an edge and the vertexes of the other one at the other side. A, B, C
%are the vertexes of one of the triangles being A-B the edge checked and P
%is a (3,2) matrix with the coordinates of the 3 vertixes of the second
%triangle. The function returns true if any of the vertices in P is at the
%same side as the vertices of A-B-C
    
    flag=false;
    
    refSign=pointSign (A,B,C);  %this returns at which side the 3rd vertex of the triangle is with reference to the line that joins the first 2 vertexes

    %compare the sign of the vertices of the other triangle with that of the
    %same triangle. If one of them HAS the same sign it means that the
    %triangles are intersecting.

    aux1 = sameSign(pointSign(A,B,P(1,:)) , refSign);
    aux2 = sameSign(pointSign(A,B,P(2,:)) , refSign);
    aux3 = sameSign(pointSign(A,B,P(3,:)) , refSign);

    if aux1 || aux2 || aux3
        flag=true;
    end

end