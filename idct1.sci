function y = idct1(x,n)
//Compute the inverse discrete cosine transform of input.
//Calling Sequence
//Y = idct1(X)
//Y = idct1(X, N)
//Parameters
//X: Matrix or integer
//N: If N is given, then X is padded or trimmed to length N before computing the transform.
//Description
// This function computes the inverse discrete cosine transform of input X.  If N is given, then X is padded or trimmed to length N before computing the transform.  If X is a matrix, compute the transform along the columns of the the matrix.  The transform is faster if X is real-valued and even length.
//Examples
//idct1([1,3,6])
//ans = 
//     5.1481604  - 4.3216292    0.9055197 

if (argn(2)<1 | argn(2)>2) then
    error("Wrong number of input arguments.");
end

  if size(x,1) == 1 then
      x = x (:); 
      end
  
  [r, c] = size (x);
  if argn(2) == 1
    n = r;
  elseif n > r
    x = [x ; zeros(n-r,c)];
  elseif n < r
   // x((n-r+1):n, :) = [];
   x=x(1:n,:)
  end

  if (isreal(x) &  (n-fix(n./2).*2) == 0 ) 
    w = [ sqrt(n/4); sqrt(n/2)*exp((%i*%pi/2/n)*[1:n-1]') ] * ones (1, c);
    y = ifft1 (w .* x);
    y([1:2:n, n:-2:1], :) = 2*real(y);
  elseif n == 1
    y = x;
  else

    w = [sqrt(4*n); sqrt(2*n)*exp((%i*%pi/2/n)*[1:n-1]') ] * ones (1, c);
    y = x.*w;

    w = exp(-%i*%pi*[n-1:-1:1]'/n) * ones(1,c);
    y = ifft1 ( [ y ; zeros(1,c); y(n:-1:2,:).*w ] );

    y = y(1:n, :);
    
    if isreal(x) then
        y = real (y); 
        end
  end
  if size(x,1) == 1 then
      y = y.'; 
      end

endfunction
