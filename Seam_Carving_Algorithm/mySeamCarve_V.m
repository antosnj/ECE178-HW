function [E,S] = mySeamCarve_V(EMap)
%find the vertical seam with lowest energy
%return: E: the energy of the choosen seam, S: the choosen seam
[R,C]=size(EMap);
E2=zeros(R,C);

for m=1:C
    E2(1,m)=EMap(1,m);
end

col_prev_store=zeros(R,C);

start_row=2;
for i=start_row:R
    for j=1:C
       ref=inf;
       if j==1   
       %In case we are on the first column:
       next_col=j+1;
       for k=j:next_col
           if E2(i-1,k)<ref
              ref=E2(i-1,k);
              E2(i,j)=EMap(i,j)+E2(i-1,k);
              col_prev_store(i,j)=k;
           end
       end
            
       elseif j==C
       %In case we are on the last column:   
       prev_col=j-1;
       for k=prev_col:j
            if E2(i-1,k)<ref
               ref=E2(i-1,k);
               E2(i,j)=EMap(i,j)+E2(i-1,k);
               col_prev_store(i,j)=k;
            end
       end
       else
       %Any other column/case:
       prev_col=j-1;
       next_col=j+1;
       for k=prev_col:next_col
            if E2(i-1,k)<ref
               ref=E2(i-1,k);
               E2(i,j)=EMap(i,j)+E2(i-1,k);
               col_prev_store(i,j)=k;
            end
       end
       end        
    end    
end

ref=inf;
last=0;
for j=1:C
    if E2(R,j)<ref
        ref=E2(R,j);
        last=j;
    end
end

S=zeros(R,1);
S(R,1)=last;
E=E2(R,last);
for i=R-1:-1:1
    aux=S(i+1,1);
    S(i,1)=col_prev_store(i+1,aux);
end
