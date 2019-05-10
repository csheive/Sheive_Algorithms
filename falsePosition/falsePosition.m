function [root,fx,ea,iter] = falsePosition(func,x_l,x_u,es,maxiter)
%falsePosition Bracketing root finding method.
%   This function asks for the function being analyzed, a lower bound, an
%   upper bound, desired relative error, and maximum number of iterations.
%   This function uses the false position method of finding the root of a
%   function.

% change to long format
format long

% checking for lower and upper bound order
if x_l > x_u
    error('Lower bound must be less than upper bound.')
end

% checking for appropriate number of input arguments
if nargin < 3
    error('Three inputs minimum: falsePosition(func,x_l,x_u,es,maxiter)')
elseif nargin > 5
    error('Five inputs maximum: falsePosition(func,x_l,x_u,es,maxiter)')
end

% checking bounds
if sign(func(x_l)) == sign(func(x_u))
    error('Upper and lower bounds do not bracket root.')
end

% setting default values of error and max iterations if not specified by
% user
if nargin == 3
    es = 0.0001;
    maxiter = 200;
end

% finding the root using the false position method
iter = 0;
e_a = 1;
e_ap = 1;
x_r = 0;
while (e_a > 0.0001 || e_a == 0) && iter < 200
    e_ap = e_a;
    iter = iter + 1;
    x_rp = x_r;
    x_r = x_u - (func(x_u)*(x_l-x_u))/(func(x_l)-func(x_u));
    if iter > 1
        e_a = abs(((x_r-x_rp)/x_r)*100);
    end
    if sign(func(x_r)) == sign(func(x_l))
        x_l = x_r;
    elseif sign(func(x_r)) == sign(func(x_u))
        x_u = x_r;
    end
end

% evaluating function at root and re-naming variables
fx = func(x_r);
root = x_r;
ea = e_a;

% outputs
fprintf('Approximate root: %s\n',root)
fprintf('Function evaluated at root: %s\n',fx)
fprintf('Approximate percent relative error: %s\n',ea)
fprintf('Number of iterations: %f\n',iter)


