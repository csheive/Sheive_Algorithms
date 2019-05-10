function I = Simpson(x,y)
%Simpson Takes x and y value vectors for some function and integrates using
%Simpson's 1/3 rule and trapezoid rule.
%   x and y vectors must be set, then plugged into this function. The
%   x values contained in the x vector are then analyzed to check for equal
%   spacing in groups of 3 values. If the 2 segments between the 3 x values
%   are equal, Simpson's 1/3 rule is used to integrate that section. If
%   those segments are not equal, the trapezoid rule is used to integrate
%   the first segment and then the next group of 3 x values are analyzed.
%   The sum of each application of Simpson's 1/3 rule and trapezoid rule is
%   calculated as the approximate value of the integral.

% checking for proper x and y vector dimensions
if numel(x) ~= numel(y)
    error('x and y vectors must have same dimensions.');
    return
end

% checking for proper x vector element spacing
num = numel(x);
check = linspace(x(1,1),x(1,num),num);
log_array = (check == x);
log_sum = sum(log_array);
if log_sum ~= num
    error('Unequal spacing, Simpsons rule cannot be performed.');
    return
end

% determining if trapezoid must be used
spacing = diff(x);
a = numel(spacing);
b = a/2;

% warn user if trapezoid rule must be used and set number of iterations
if floor(b) ~= b
    warning('Number of segments is odd, trapezoid rule must be used for last segment.');
    iter = b-0.5;
end

% set number of iterations
if floor(b) == b
    iter = b;
end

% applying Simpson's 1/3 rule
sum_mat = zeros(1,a);
i = 1;
for i = 1:iter
    k = 2*i-1;
    sum_mat(1,i) = (x(k+2)-x(k))*((y(k)+4*y(k+1)+y(k+2))/6);
end

% applying trapezoid rule (if needed)
if floor(b) ~= b
    r = numel(x);
    sum_mat(1,i+1) = (x(r)-x(r-1))*((y(r)+y(r-1))/2);
end

% calculating final answer
I = sum(sum_mat);

% displaying final answer
fprintf('Integral value I = %f\n',I);
     
end




