A = dlmread('robot.key','',1,0);
B = dlmread('robot.key','',[0 0 0 1]);
[m,n]= size(A);
M= size(B);
C= B(2);
k=B(1);
re = mod(C, k-1);
quo = floor(C./(k-1));

M1= [2 -2 1 1; -3 3 -2 -1; 0 0 1 0; 1 0 0 0];

P= zeros(C,n);

Uv= zeros(1,k-1);
b=0;
v=1;
 
if re == 0
  for i = 1: k-1
      Uv(1,i)=quo;
  end
elseif re ~= 0
    for i = 1: re
        Uv(1,i)=quo + 1;
    end
    for r = re+1: k-1
      Uv(1,r)=quo;
    end
end
V=length(Uv);
k1=2*k;
K=zeros(4,1);
G=zeros(4,1);
for i = 1:2:k1-3
 for w = 1: n

     K=[A(i,w); A(i+2,w); A(i+1,w); A(i+3,w)];
     G=horzcat(G,K);
     
 end

end

if re~=0
 for i=1:re
   for j=1:n
          v=v+1;
   for du=0:Uv(1,i)-1
    b=b+1; 
    u=du/Uv(1,i);
    U= [u^3, u^2, u, 1];
    N=U*M1;
    K=G(:,v);
    P(b,j)=N*K;


   end
  

   end


 end
 for i=re+1:k-1
  if i~=k-1
  for j=1:n
   v=v+1;
   for du=0:Uv(1,i)-1
    b=b+1;
    u=du/(Uv(1,i));
    U= [u^3, u^2, u, 1];
    N=U*M1;
    K=G(:,v);    
    P(b,j)=N*K;


   end 
    
  end
  elseif i==k-1
  for j=1:n
   v=v+1;
   for du=0:Uv(1,i)-1
    b=b+1;
    u=du/(Uv(1,i)-1);
    U= [u^3, u^2, u, 1];
    N=U*M1;
    K=G(:,v);    
    P(b,j)=N*K;
   end
  end
  end


 end
elseif i==re
  if i~=k-1
  for j=1:n
   v=v+1;
   for du=0:Uv(1,i)-1
    b=b+1;
    u=du/(Uv(1,i));
    U= [u^3, u^2, u, 1];
    N=U*M1;
    K=G(:,v);    
    P(b,j)=N*K;


   end 
    
  end
  elseif i==k-1
  for j=1:n
   v=v+1;
   for du=0:Uv(1,i)-1
    b=b+1;
    u=du/(Uv(1,i)-1);
    U= [u^3, u^2, u, 1];
    N=U*M1;
    K=G(:,v);    
    P(b,j)=N*K;
   end
  end
  end
end
T=P(:);
R= T(T ~= 0);
t=length(T);
r=length(R);
Z=reshape(R,[C,n]);
disp(r);

dlmwrite('robot.ang',C,'delimiter',' ');
dlmwrite('robot.ang',Z,'-append',...
'delimiter',' ','roffset',1)
