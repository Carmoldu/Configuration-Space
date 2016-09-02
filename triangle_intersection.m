function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag=true;

P1 = [P1;P1(1,:)];
P2 = [P2,;P2(1,:)];


flag1=checkTriangle(P1,P2);
flag2=checkTriangle(P2,P1);

if flag1 || flag2
    flag=false;
end


% *******************************************************************
end

function flag=checkTriangle(A,B)
%This function determines if any edge of a triangle (P1) defines a separation
%between its vertexes and another triangles vertexes (P2). If an edge
%like this one exists, it returns true

flag=false;

    for j = 2:4
               
        %We obtain the vector that defines the edge
        x = A(j,1) - A(j-1,1);
        y = A(j,2) - A(j-1,2); 

        %And an origin point for the vector
        x_o = A(j-1,1);
        y_o = A(j-1,2);

        %Then we compute the normal vector
        x_normal = -y;
        y_normal = x;



        ownVertexSide = zeros(1,3);
        otherTriangleSide = zeros(1,3);
        
        %we compute at which side are the vertexes of the triangle and
        %compare it to the side at which the other triangles vertexs are

        for k=1:3
            %the side will be defined by the sign of the vector product
            %between the normal vector relative to the edge and the vector
            %defined by the vertex and the reference point 
            ownVertexSide(k) = sign(x_normal * (A(k,1) - x_o) + y_normal * (A(k,2) - y_o));    
        end
        for k=1:3
            otherTriangleSide(k) = sign(x_normal * (B(k,1) - x_o) + y_normal * (B(k,2) - y_o));    
        end
        if ( min(ownVertexSide) > -1 && max(otherTriangleSide) < 1) || ( max(ownVertexSide) < 1 && min(otherTriangleSide) > -1)
            flag = true;
            break;
        end
    end


end
