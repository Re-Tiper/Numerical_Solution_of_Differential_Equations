function [x, y]= errorcontrol(f,x0,y0,xf,c1,A1,b1,c2,A2,b2,TOL)
s1=length(b1); 
s2=length(b2);
dim=length(y0);
hmax=(xf-x0)/5; 
hmin=(xf-x0)/20000; 
h=(xf-x0)/100
i=1; x(1)=x0; y(1)=y0(1);
while xf-x0>1e-6 && h>=hmin
    if xf-x0<h 
        h= xf-x0 
    end
    
    k1=zeros(s1,dim);
    for j=1:s1
        k1(j,:)=h*f(x0+c1(j)*h,y0+(A1(j,:)*k1)');
    end
    k2=zeros(s2,dim);
    for j=1:s2
        k2(j,:)=h*f(x0+c2(j)*h,y0+(A2(j,:)*k2)');
    end 
    x1= x0 + h;
    y1_1= y0+(b1'*k1)'; 
    y1_2= y0+(b2'*k2)';
    error=norm(y1_1-y1_2);
    if error<TOL
        i=i+1; x(i)=x1; y(i)=y1_2(1); x0=x1; y0=y1_2; 
        if error<TOL/1000 && h/2<=hmax 
            h= 2*h 
        end 
    else 
        h= h/2 
    end 
end 
if h<hmin
    disp('The tolerance is not sufficient')
end

% Πρόβλημα
%f1= @(t,y) [y(2 ) -y(1)]';
%ysol1= @(t) cos(t);
%c1= [0 1/2 1]';
%A1= [0 0 0; 1/2 0 0; -1 2 0];
%b1= [1/6 2/3 1/6]';
%c2= [1 1/2 1/2 1]';
%A2= [0 0 0 0; 1/2 0 0 0; 0 1/2 0 0; 0 0 1 0];
%b2= [1/6 1/3 1/3 1/6]';
%[t1 y1]= rungekutta(f1, 0, [1;0], 600*pi(), 0.5, c2, A2, b2);
%plot(t1,ysol1(t1),'c-',t1,y1,'b*-')
%ylim([-1.5, 1.5])

%TOL=1e-4
%[t2 y2]= errorcontrol(f1, 0, [1;0], 600*pi(), c1, A1, b1, c2, A2, b2, TOL);
%plot(t2,ysol1(t2),'c-',t2,y2,'b*-')

%Εφαρμογή
%c1 = [0 1/2 1]';
%A1=[0 0 0;1/2 0 0;-1 2 0];
%b1=[1/6 2/3 1/6]';
%[x3,y3]= errorcontrol(f,0,-1,2,c1,A1,b1,c2,A2,b2,1e-2);
%plot(x3,y3,'*',x3,f1(x3),'-')