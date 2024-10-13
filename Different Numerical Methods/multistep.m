function [x, y]=multistep(f,x0,y0,xf,h,b,c0,A0,b0)
m=length(b);
[xinit0, yinit0]=rungekutta(f,x0,y0,x0+(m-1)*h,h,c0,A0,b0);
i=1; 
xinit=xinit0;
yinit=yinit0;
while xf-xinit(m)>1e-6 
    if xf-xinit(m)<h 
        h=xf-xinit(m); 
    end 
    x1= xinit(end) + h;
    sum= 0;
    for j=1:m 
        sum=sum+b(j)*f(xinit(j),yinit(j)); 
    end 
    y1= yinit(end) + h * sum;
    x(i)=x1;
    y(i)=y1(1);  
    i=i+1; 
    xinit=[xinit, x1]; 
    xinit(1)=[]; 
    yinit=[yinit, y1]; 
    yinit(1)=[]; 
end
x=[xinit0, x]; 
y=[yinit0, y];
end

% Problem
%f0=@(t,y) -y-5*exp(-t).*sin(5*t);
%ysol0=@(t) cos(5*t).*exp(-t);
%[x1,y1]= rungekutta(f,0,1,3,0.2,[0 1/2 1/2 1]',[0 0 0 0; 1/2 0 0 0; 0 1/2 0 0; 0 0 1 0],[1/6 1/3 1/3 1/6]');
%[x, y]= multistep(f0, 0, 1, 3, 0.1, [251/720 -1272/720 2616/720 -2774/720 1901/720]', [0 1/2 1/2 1]',[0 0 0 0; 1/2 0 0 0; 0 1/2 0 0; 0 0 1 0],[1/6 1/3 1/3 1/6]');
%plot(x,y,'*',x,ysol0(x),'-')
 
