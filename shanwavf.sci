function [psi,x]=shanwavf(lb,ub,n,fb,fc)

// Complex Shannon Wavelet
// Calling Sequence
//	[psi,x]=shanwavf(lb,ub,n,fb,fc)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real valued integer strictly positive
//	fb: Real or complex valued vector or matrix, strictly positive value for scalar input
//	fc: Real or complex valued vector or matrix, strictly positive value for scalar input
// Description
//	This function implements the complex Shannon wavelet function and returns the value obtained. The complex Shannon wavelet is defined by a bandwidth parameter FB, a wavelet center frequency FC on an N point regular grid in the interval [LB,UB].
// Examples
// 1.	[a,b]=shanwavf (2,8,3,1,6)
//	a =   [-3.8982e-17 + 1.1457e-31i   3.8982e-17 - 8.4040e-31i  -3.8982e-17 + 4.5829e-31i]
//	b =   [2   5   8]

if (argn(2)~=5) then
	error ("Wrong number of input arguments.")
end
if n<=0 | fix(n)~=n then
    error('n must be a positive integer')
end

if ~isreal(fb) | ~isreal(fc) then
   error('both fb and fc must be real') 
end
if (fb<=0) | (fc<=0)  then
    error('both fb and fc must be positive')
end
x = linspace(lb,ub,n);
  psi = (fb.^0.5).*(sinc(fb.*x).*exp(2.*%i.*%pi.*fc.*x));

endfunction
