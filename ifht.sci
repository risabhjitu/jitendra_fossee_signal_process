function m = ifht(d,n, dim)
//Calculate the inverse Fast Hartley Transform of real input D
//Calling Sequence
//m= ifht (d)
//m= ifht (d,n)
//m= ifht (d,n,dim)
//Parameters 
//d: real or complex valued scalar or vector
//n: Similar to the options of FFT function
//dim: Similar to the options of FFT function 
//Description
//Calculate the inverse Fast Hartley Transform of real input d. If d is a matrix, the inverse Hartley transform is calculated along the columns by default. The options n and dim are similar to the options of FFT function.
//
//The forward and inverse Hartley transforms are the same (except for a scale factor of 1/N for the inverse hartley transform), but implemented using different functions.
//
//The definition of the forward hartley transform for vector d, m[K] = 1/N \sum_{i=0}^{N-1} d[i]*(cos[K*2*pi*i/N] + sin[K*2*pi*i/N]), for 0 <= K < N. m[K] = 1/N \sum_{i=0}^{N-1} d[i]*CAS[K*i], for 0 <= K < N.
//Examples
//ifht(1 : 4)
//ifht(1:4, 2)

if(argn(2)<1 | argn(2)>3)
error("Wrong number of Inputs")
end
 if (argn(2) == 1)
    v = ifft1(d);
  elseif ( argn(2) == 2 )
    v = ifft1(d,n);
  else
   v = ifft1(d,n,dim);
  end

  m = real(v) + imag(v);


endfunction

