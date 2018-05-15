function [x, iter] = sqrtn(a, tol)
%sqrtn Square root of a scalar by Newton's method.
%      X = sqrtn(A,TOL) computes the square root of the scalar
%      A by Newton's method (also known as Heron's method).
%      A is assumed to be >= 0.
%      TOL is a convergence tolerance (default EPS).
%      [X,ITER] = sqrtn(A,TOL) returns also the number of
%      iterations ITER for convergence.

  % default tol = eps
  switch nargin
    case 1
      tol = eps;
  end


  % initial
  x = a;
  iter = 0;
  fprintf('%s%14s%21s\n', 'k', 'x_k', 'rel. change');

  % iteration
  % do while
  condition = true;

  while condition
    iter = iter + 1;
    x_new = 1 / 2 * (x + a / x);
    relative_change = abs(x_new - x) / abs(x_new);
    fprintf('%d:  %.16e   %.2e\n', iter, x_new, relative_change);
    condition = ~ (relative_change < tol);
    x = x_new;
  end

end
