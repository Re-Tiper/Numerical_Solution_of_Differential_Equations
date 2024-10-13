function [x, y]=pc(f,x0,y0,xf,h,bp,bc,c0,A0,b0)
m=length(bp);
[xinit0, yinit0]=rungekutta(f,x0,y0,x0+(m-1)*h,h,c0,A0,b0);
i=1; xinit=xinit0; yinit=yinit0;
while xf-xinit(m)>1e-6 
    if xf-xinit(m)<h 
        h=xf-xinit(m); end 
    x1=xinit(m)+h;
    sum=0;
    for j=1:m 
        sum=sum+bp(j)*f(xinit(j),yinit(j)); end

    y1p=yinit(m)+h*sum;
    sum=0;
    for j=1:m-1 
        sum=sum+bc(j)*f(xinit(j+1),yinit(j+1)); end 
    sum=sum+bc(m)*f(x1,y1p);
    y1c=yinit(m)+h*sum;
    x(i)=x1; y(i)=y1c;

    i=i+1; 
    xinit=[xinit x1];
    xinit(1)=[]; 
    yinit=[yinit y1c];
    yinit(1)=[];  
end
x=[xinit0 x]; y=[yinit0 y]; 
end

%Problem
%f0=@(t,y) -y-5*exp(-t).*sin(5*t);
%ysol0=@(t) cos(5*t).*exp(-t);
%bp=[251/720 -1274/720 2616/720 -2774/720 1901/720]';
%bc=[-19/720 106/720 -264/720 646/720 251/720]';
%b0=[1/6 1/3 1/3 1/6]';
%c0=[0 1/2 1/2 1]';
%A0=[0 0 0 0;1/2 0 0 0;0 1/2 0 0; 0 0 1 0];
%[t1 y1]=multistep(f0,0,1,3,0.2,bp,c0,A0,b0);
%[t2 y2]=pc(f0,0,1,3,0.2,bp,bc,c0,A0,b0);
%plot(t1,y1,'*',t2,y2,'x',t1,ysol0(t1),'-')
