function [H, W] = freqz (b, a, n, region, Fs)
////This function returns the complex frequency response H of the rational IIR filter whose numerator and denominator coefficients are B and A, respectively.
////Calling Sequence
////[H, W] = freqz(B, A, N, "whole", Fs)
////[H, W] = freqz(B)
////[H, W] = freqz(B, A)
////[H, W] = freqz(B, A, N)
////H = freqz(B, A, W)
////[H, W] = freqz(..., FS)
////freqz(...)
////Parameters
////B, A, N: Integer or Vector
////Description
//// Return the complex frequency response H of the rational IIR filter whose numerator and denominator coefficients are B and A, respectively.
////
////The response is evaluated at N angular frequencies between 0 and 2*pi.
//// Fs: response at specific frequencies
////The output value W is a vector of the frequencies.
//// 
////If A is omitted, the denominator is assumed to be 1 (this corresponds to a simple FIR filter).
////
////If N is omitted, a value of 512 is assumed. For fastest computation, N should factor into a small number of small primes.
////
////If the fourth argument, "whole", is omitted the response is evaluated at frequencies between 0 and pi.
////
////     'freqz (B, A, W)'
////
////Evaluate the response at the specific frequencies in the vector W. The values for W are measured in radians.
////
////     '[...] = freqz (..., FS)'
////
////Return frequencies in Hz instead of radians assuming a sampling rate FS. If you are evaluating the response at specific frequencies W, those frequencies should be requested in Hz rather than radians.
////
////     'freqz (...)'
////
////Plot the magnitude and phase response of H rather than returning them.
////Examples
////H = freqz([1,2,3], [4,3], [1,2,5])
////ans = 
////       0.4164716 - 0.5976772i  - 0.4107690 - 0.2430335i    0.1761948 + 0.6273032i  


if (argn(1)>2)
    error("Wrong number of output arguments.");
end

  if (argn(2) < 1 | argn(2)> 5)
    error("Wrong number of input arguments.");
  elseif (argn(2) == 1)
    ## Response of an FIR filter.
    a = []; n =[]; region = []; Fs = [];
  elseif (argn(2) == 2)
    ## Response of an IIR filter
    n =[]; region = []; Fs = [];
  elseif (argn(2) == 3)
    region = []; Fs = [];
  elseif (argn(2) == 4)
    Fs = [];
    if (type(region)~=10 & ~ isempty (region))
      Fs = region; 
      region = [];
    end
  end

  if (isempty (a)) 
    a = 1; 
  end
  if (isempty (n))
    n = 512; 
  end
  if (isempty (region))
    if (isreal (b) & isreal (a))
      region = "half";
    else
      region = "whole";
    end
  end
  
  if (isempty (Fs)) 
    if (argn(1) == 0) 
      Fs = 2; 
    else 
      Fs = 2*%pi; 
    end
  end

  la = length (a);
  a = matrix (a, 1, la);
  lb = length (b);
  b = matrix (b, 1, lb);
  k = max ([la, lb]);

  if (~ isscalar (n))
    if (argn(2) == 4) 
      w = 2*%pi*n/Fs;
    else
      w = n;
    end
    n = length (n);
    extent = 0;
  elseif (strcmp (region, "whole"))
    w = 2 * %pi * (0:n-1) / n;
    extent = n;
  else
    w = %pi * (0:n-1) / n;
    extent = 2 * n;
  end

  if (length (b) == 1)
    if (length (a) == 1)
      hb = b * ones (1, n);
    else
      hb = b;
    end
  elseif (extent >= k) 
      var=zeros(1,extent)
      var(1:length(b))=b
    hb = fft1 (var);
    hb = hb(1:n);
  else
        var=zeros(1,k)
      var(1:length(b))=b 
    hb = polyval (var, exp (%i*w));
  end
  if (length (a) == 1)
    ha = a;
  elseif (extent >= k)
       var=zeros(1,extent)
      var(1:length(b))=b
    ha = fft1 (var);
    ha = ha(1:n);
  else
       var=zeros(1,k)
      var(1:length(a))=a
    ha = polyval (var, exp (%i*w));
  end
  h = hb ./ ha;
  w = Fs * w / (2*%pi);
    H = h;
    W = w;


endfunction
