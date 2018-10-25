function y = idst1(x,n)
//This function computes the inverse type I discrete sine transform.
//Calling Sequence
//Y = idst1(X)
//Y = idst1(X, N)
//Parameters
//X: Matrix or integer
//N: If N is given, then X is padded or trimmed to length N before computing the transform.
//Description
//This function computes the inverse type I discrete sine transform of Y. If N is given, then Y is padded or trimmed to length N before computing the transform. If Y is a matrix, compute the transform along the columns of the the matrix.
//Examples
//idst1([1,3,6])
//ans = 
//     3.97487  -2.50000   0.97487 
if(argn(2)<1 | argn(2)>2) then
    error("Wrong number of input arguments.");
end


 if argn(2) == 1,
    n = size(x,1);
    if n==1, n = size(x,2); 
        end
  end
  y = dst1(x, n) * 2/(n+1);

endfunction

//
//
//function x = idst (y, n)
//
//  if (nargin < 1 || nargin > 2)
//    print_usage;
//  endif
//
//  if nargin == 1,
//    n = size(y,1);
//    if n==1, n = size(y,2); endif
//  endif
//  x = dst(y, n) * 2/(n+1);
//
//endfunction
//
//%!test
//%! x = log(gausswin(32));
//%! assert(x, idst(dst(x)), 100*eps)
//
//
