function [L,U,P] = luFactor(A)
%luFactor Factors 3x3 square matrix into upper and lower triangular
%matrices.
%   This function takes a square 3x3 coefficient matrix [A] of a system of
%   equations and decomposes it into upper [U] and lower [L] triangular
%   matrices, and also outputs the pivot matrix [P]. In order to pass a
%   square matrix through this function, a variable name for that matrix
%   must be made to input.

% Checking that the matrix is a square matrix. LU factorization can only be
% done for a square matrix.
[a,b] = size(A);
if a ~= b
    error('Inputted matrix must be a square matrix.');
end

% Setting initial matrices to be altered by function. These matrices will
% become the final answers after running through the function.
L = eye(b);
P = L;
U = A;

% Finding the absolute values of the elements in matrix A. These will be
% used in order to properly pivot the matrix U.
for i = 1:b
    [piv,a] = max(abs(U(i:b,i)));
    a = a+i-1;
    if a ~= i
       
        % Swapping rows m and i in U matrix. (pivoting)
        % This is based off of the absolute values of the matrix elements.
        row = U(i,:);
        U(i,:) = U(a,:);
        U(a,:) = row;
        
        % Swapping rows m and i in P matrix. (pivoting)
        % This is based off of the absolute values of the matrix elements.
        row = P(i,:);
        P(i,:) = P(a,:);
        P(a,:) = row;
        if i >= 2
            row = L(i,1:i-1);
            L(i,1:i-1) = L(a,1:i-1);
            L(a,1:i-1) = row;
        end
    end
    for h = i+1:b
        L(h,i) = U(h,i)/U(i,i);
        U(h,:) = U(h,:)-L(h,i)*U(i,:);
    end
end

% Displaying L (lower triagonal), U (upper triagonal), and P (pivot) 
% matrices.
% L, lower triagonal matrix of A
L
% U, upper triagonal matrix
U
% P, pivot matrix
P

end

