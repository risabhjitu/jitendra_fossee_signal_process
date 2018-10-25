function h = freqs (b, a, w)
//Compute the s-plane frequency response of the IIR filter.
//Calling Sequence
//h = freqs (b, a, w)
//Parameters 
//b: vector containing the coefficients of the numerator of the filter. 
//a: vector containing the coefficients of the denominator of the filter.
//w: vector containing frequencies
//Description
//It computes the s-plane frequency response of the IIR filter B(s)/A(s) as H = polyval(B,j*W)./polyval(A,j*W). 
//If called with no output argument, a plot of magnitude and phase are displayed.
//Examples
//B = [1 2];
//A = [1 1];
//w = linspace(0,4,128);
//freqs(B,A,w);
if(argn(2)~=3)
error("Wrong number of input arguments.")
end

if (argn(1)>1) then
    error("Wrong number of output arguments.")
end
  h= polyval(b,%i*w)./polyval(a,%i*w);

endfunction
