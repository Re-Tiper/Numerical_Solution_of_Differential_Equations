function [x, found]=nr(f,df,x0,acc,n)
    x=x0;
    count=0;
    found=1;
    while count<n && abs(f(x))>acc
        x=x-f(x)/df(x);
        count=count+1;
    end
    if abs(f(x))>acc
        found=0;
        disp('Newton-Raphson accuracy was not achieved')
    end
end
