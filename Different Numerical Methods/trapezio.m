function [x, y]=trapezio(f,dfdy,x0,y0,xf,h,TOL) % dfdy: η παράγωγος της f ως προς y
i=1; x(1)=x0; y(1)=y0(1);
while xf-x0>1e-6
    if xf-x0<h
        h= xf-x0; end
    x1=x0+h;
    g=@(y) y0+(h/2)*(f(x1,y)+f(x0,y0))-y;
    dg=@(y) (h/2)*dfdy(x1,y)-1; % η παράγωγος της g ως προς y (δηλ ως προς 𝑦𝑖+1)
    [y1, found]=nr(g,dg,y0,TOL,1000);
    if ~found 
        break; end
    i=i+1;
    x(i)=x1;
    y(i)=y1(1);
    x0=x1; y0=y1;
end
end


%Πρόβλημα
%f= @(x,y) 5.*exp(5*x).*(y-x).^2 + 1;
%f1= @(x) x - exp(-5*x);
%df2= @(x,y) 10*exp(5*x)*(y-x);
%[x1, y1]= trapezio(f,df2,0,-1,2,0.25,1e-2);
%plot(x1,y1,'*',x1,f1(x1),'-')