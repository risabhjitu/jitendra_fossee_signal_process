function y = fftconv(X, Y, force)
//Convolve two vectors using the FFT for computation.
//Calling Sequence
//Y = fftconv(X, Y)
//Y = fftconv(X, Y, N)
//Parameters
//X, Y: Vectors 
//Description
//Convolve two vectors using the FFT for computation. 'c' = fftconv (X, Y)' returns a vector of length equal to 'length(X) + length (Y) - 1'.  If X and Y are the coefficient vectors of two polynomials, the returned value is the coefficient vector of the product polynomial.
//force: if force == 1, then the FFT's are "forced" to be of dyadic complexity.
//Examples
//fftconv([1,2,3], [3,4,5])
//ans = 
//    3.    10.    22.    22.    15. 
if(argn(2)<2 | argn(2)>3)
error("Wrong number of input arguments.");
end

if ~isvector(X) | ~isvector(Y) then
    error('X and Y must a vector')
elseif size(X)~=size(Y) then
    error('X and Y must be of same size')
end

if argn(2)==3 & force~=1 then
    error('force can be 1 only')   
end

nx = length(X);
ny = length(Y);


if argn(2)==3 then
 n = 2^(fix(log2(nx+ny))+1);
else
 n=nx+ny;
end;

A = fft1(X,n);
B = fft1(Y,n);
y= ifft1(A'.*B',n);
y = real(y(1:nx+ny-1));


endfunction
