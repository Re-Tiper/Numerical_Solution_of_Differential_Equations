function [x,y]=improvedeuler(f,x0,y0,xf,h)
i=1; x(1)=x0; y(1)=y0(1);

while xf-x0>1e-6 
    if xf-x0<h 
        h= xf-x0; end

    k1= h*f(x0,y0);
    x1= x0 + h;
    y1= y0 + k1; 
    k2= h*f(x1,y1);
    y1= y0 +0.5*(k1+k2);
    i= i+1;
    x(i)= x1; 
    y(i)= y1(1); 
    x0=x1; y0=y1;
end
end

%Problem 1
%f= @(t,y) -y - 5.*exp(-t).*sin(5.*t);
%f1= @(t) cos(5.*t).*exp(-t);
%[x,y1]= euler(f,0,1,3,0.2);
%[x,y2]= improvedeuler(f,0,1,3,0.2);
%plot(x,y1,'*',x,y2,'+',x,f1(x),'-')

%[x,y1]= euler(f,0,1,3,0.1);
%[x,y2]= improvedeuler(f,0,1,3,0.1);
%plot(x,y1,'*',x,y2,'+',x,f1(x),'-')

%Problem 2
%f1= @(x) cos(x);
%f=@(t,y) [y(2) -y(1)]';
%[x, y1] = euler(f, 0, [1 0]', 6*pi(), 0.1);
%[x, y2] = improvedeuler(f, 0, [1 0]', 6*pi(), 0.1);
%plot(x,y1,'*',x,y2,'+',x,f1(x),'-')

%er1= [abs(y1-f1(x))];
%er2= [abs(y2-f1(x))];
%plot(x,er1,'*',x,er2,'+')