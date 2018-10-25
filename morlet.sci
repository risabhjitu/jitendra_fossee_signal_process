function [psi,x] = morlet (lb,ub,n)
// Generates Morlet wavelets
// Calling Sequence
//	[psi,x]= morlet(lb,ub,n)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real strictly positive scalar number
// Description
//	This function returns values of the Morlet wavelet in the specified interval for all the sample points.
// Examples
// 1.	[a,b]=morlet(1,2,3)
//	a =	[0.17205   0.11254  -0.11356]
//	b =	[1.0000   1.5000   2.0000]
// 2.	[a,b]=morlet([1 2 3],[1 2 3],1)
//	a =	[0.1720498;  -0.1135560;  -0.0084394]
//	b =	[1;   2;   3]

if (argn(2)<3) then
	error ("Wrong number of input arguments.")
elseif (n<=0)
    error('n must be positive')
    elseif (~isscalar(lb) | ~isscalar(ub)| ~isscalar(n)) then
     error('input must be scalars')
else 
    x = linspace(lb,ub,n);
  psi = cos(5.*x) .* exp(-x.^2/2) ;
end
endfunction



