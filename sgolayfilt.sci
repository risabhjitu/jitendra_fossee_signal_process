function y = sgolayfilt (x, p, n, m, ts)

//This function applies a Savitzky-Golay FIR smoothing filter to the data
//Calling Sequence
//y = sgolayfilt (x)
//y = sgolayfilt (x, p)
//y = sgolayfilt (x, p, n)
//y = sgolayfilt (x, p, n, m)
//y = sgolayfilt (x, p, n, m, ts)
//Parameters 
//x: vector or matrix of real or complex numbers 
//p: polynomial order, real number less than n, default value 3
//n: integer, odd number greater than p
//m: vector of real positive valued numbers, length n
//ts: real number, default value 1 
//Description
//This function applies a Savitzky-Golay FIR smoothing filter to the data given in the vector x; if x is a matrix, this function operates
//on each column. 
//The polynomial order p should be real, less than the size of the frame given by n. 
//m is a weighting vector with default value identity matrix.
//ts is the dimenstion along which the filter operates. If not specified, the function operates along the first non singleton dimension. 
//Examples
//sgolayfilt([1;2;4;7], 0.3, 3, 0, 0)
//ans =
//    2.3333333  
//    2.3333333  
//    4.3333333  
//    4.3333333 

if(argn(2)<3 | argn(2)>5)
error("Wrong number of input arguments.")
end

if (argn(2)==3) then
    m=0; ts=1;
end
if (argn(2)==4) then
    ts=1;
end

  if (argn(2) >= 3)
    F = sgolay(p, n, m, ts);
  elseif (prod(size(p)) == 1)
    n = p+3-(p-fix(p./2).*2);
    F = sgolay(p, n);
  else
    F = p;
    n = size(F,1);
    if (size(F,1) ~= size(F,2))
      error("F must be a Savitzsky-Golay filter set");
    end
  end

  transpose = (size(x,1) == 1);
  if (size(x,1) == 1) then
       x = x.'; 
       end
  len = size(x,1);
  if (len < n)
    error("Data seems to be insufficient for filter");
  end


  k = floor(n/2);
  z = filter1(F(k+1,n:-1:1), 1, x);
  y = [ F(1:k,:)*x(1:n,:) ; z(n:len,:) ; F(k+2:n,:)*x(len-n+1:len,:) ];

  if (size(x,1) == 1) then
       y = y.'; 
       end

endfunction
