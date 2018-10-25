function y= spencer(x)
//Return Spencer's 15 point moving average of each column of X.
//Calling Sequence
//spencer(X)
//Parameters 
//X: Real scalar or vector
//Description
//Return Spencer's 15 point moving average of each column of X.

if(argn(2)~=1) then
error("Wrong number of input arguments");
end
  [xr, xc] = size(x);

  n = xr;
  c = xc;

  if (isvector(x))
   n = length(x);
   c = 1;
   X = matrix(x, n, 1);
   disp(X)
   disp(n); disp(c)
  
  end

  W = [-3, -6, -5, 3, 21, 46, 67, 74, 67, 46, 21, 3, -5, -6, -3] / 320;

  retval = fftfilt (W, X);
  retval = [zeros(7,c); retval(15:n,:); zeros(7,c);];
retval=retval';
disp(retval)
  y = matrix(retval, xr, xc);

endfunction

//function retval = spencer (X)
//
//  if (nargin != 1)
//    usage ("spencer (X)");
//  endif
//
//  [xr, xc] = size(X);
//
//  n = xr;
//  c = xc;
//
//  if (isvector(X))
//   n = length(X);
//   c = 1;
//   X = reshape(X, n, 1);
//  endif
//
//  W = [-3, -6, -5, 3, 21, 46, 67, 74, 67, 46, 21, 3, -5, -6, -3] / 320;
//
//  retval = fftfilt (W, X);
//  retval = [zeros(7,c); retval(15:n,:); zeros(7,c);];
//
//  retval = reshape(retval, xr, xc);
//
//endfunction
