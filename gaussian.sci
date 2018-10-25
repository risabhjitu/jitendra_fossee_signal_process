function w = gaussian (m, a)
//This function returns a Gaussian convolution window.
//Calling Sequence
//w = gaussian (m)
//w = gaussian (m, a)
//Parameters 
//m: positive integer value
//a:  Width measured in frequency units
//w: output variable, vector of real numbers
//Description
//This function returns a Gaussian convolution window of length m supplied as input, to the output vector w.
//The second parameter is the width measured in sample rate/number of samples and should be f for time domain and 1/f for frequency domain. The width is inversely proportional to a.
//Examples
//gaussian(5,6)
//ans  =
//    5.380D-32  
//    1.523D-08  
//    1.         
//    1.523D-08  
//    5.380D-32  

if(argn(2)<1 | argn(2)>2)
error("Wrong number of input arguments.")
end

if(argn(2)==1)
    a=1;
end

 if (~isscalar(m) | ~(ceil(m)==m) | ~m>0) then
     error('m must be positive integer')
 end
 
  w = exp(-0.5*(([0:m-1]'-(m-1)/2)*a).^2);
endfunction
