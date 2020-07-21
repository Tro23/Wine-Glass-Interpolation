A = dlmread('object.key','',1,0);
B = dlmread('object.key','',[0 0 0 1]);

count=0;
C=B(2);
k=B(1);
[m,n]=size(A);

Uv= zeros(1,k-1);
re = mod(C, k-1);
quo = floor(C./(k-1));

 
if re == 0
  for l1 = 1: k-1
      Uv(1,l1)=quo;
  end
elseif re ~= 0
    for l1 = 1: re
        Uv(1,l1)=quo + 1;
    end
    for r = re+1: k-1
      Uv(1,r)=quo;
    end
end
V=length(Uv);
R1=A(1:3,1:3);
R2=A(4:6,1:3);
R3=A(7:9,1:3);
R4=A(10:12,1:3);
R5=A(13:15,1:3);
P1=A(1:3,4:4);
P2=A(4:6,4:4);
P3=A(7:9,4:4);
P4=A(10:12,4:4);
P5=A(13:15,4:4);

Q1= R_to_Q(R1);
Q2=R_to_Q(R2);
Q3=R_to_Q(R3);
Q4=R_to_Q(R4);
Q5=R_to_Q(R5);

R11=Q_to_R(Q1);

key_q=vertcat(Q1,Q2,Q3,Q4,Q5);

Q=Bisect(Q1,Q2);

Q11=Double(Q3,Q4);


    a=key_q(1,:);
    b=key_q(5,:);
    stacked_q=zeros(B(2),4);

   stacked_q=Q_interpolation(key_q,k,B(2));
   disp(stacked_q);
   [r1,r2]=size(stacked_q);
   disp(r1);
   disp(r2);
   Rr=zeros(r1,3);
M1= [2 -2 1 1; -3 3 -2 -1; 0 0 1 0; 1 0 0 0];

   for i=1:r1
       R=Q_to_R(stacked_q(i,:));
       Rr=vertcat(Rr,R);
   end
   disp(Rr);
   [e1,e2]=size(Rr);
   disp(e1);
   Rf=Rr(69:269, 1:3);
   disp(Rf);
   [e11,e22]=size(Rf);
   disp(e11);
   PP=vertcat(P1',P2',P3',P4',P5');
   PI=zeros(e11,1);
   for i=1:k-1
   MLT=[PP(i,:);PP(i+1,:);0 0 0; 0 0 0];
   if i~=k-1
   for du=0:Uv(1,i)-1

    u=du/(Uv(1,i));
    U= [u^3, u^2, u, 1];
    
    PI1=U*M1*MLT;
    PI=vertcat(PI,PI1');
   end
   elseif i==k-1
       for du=0:Uv(1,i)-1
    u=du/(Uv(1,i)-1);
    U= [u^3, u^2, u, 1];
    
    PI1=U*M1*MLT;
    PI=vertcat(PI,PI1');
       end
   end
   end
disp(PI);
disp(e11);
PF=PI(202:402);
disp(PF);
w=length(PI);
disp(w);
FI=horzcat(Rf,PF);
disp(FI);

dlmwrite('object.traj',C,'delimiter',' ');
dlmwrite('object.traj',FI,'-append',...
'delimiter',' ','roffset',1)

