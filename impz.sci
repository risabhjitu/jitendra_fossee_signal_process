function [x_r, t_r] = impz(b, a, n, fs)
// It gives Impulse response of digital filter

//Calling Sequence
//x_r = impz(b)
//x_r = impz(b, a)
//x_r = impz(b, a, n)
//x_r = impz(b, a, n, fs)
//[x_r, t_r] = impz(b, a, n, fs)

//Parameters
//x_r: impz chooses the number of samples and returns the response in the column vector, x_r.
//t_r : impz returns the sample times in the column vector, t_r
// b : numerator coefficients of the filter
// a : denominator coefficients of the filter
// n : samples of the impulse response   t(by default ,n = length(t) and  is computed automatically.
// fs : sampling frequency

//Description
//[x_r,t_r] = impz(b,a) returns the impulse response of the filter with numerator coefficients, b, and denominator coefficients, a. impz chooses the number of samples and returns the response in the column vector, x_r, and the sample times in the column vector, t_r. t_r = [0:n-1]' and n = length(t) is computed automatically.

//Examples
//[x_r,t_r]=impz([0 1 1],[1 -3 3 -1],10)
//OUTPUT :
// t_r = 0.    1.     2.    3.    4.       5.      6.      7.      8.       9
// x_r=  0.    1.    4.    9.    16.    25.    36.    49.....64......81

//[x_r,t_r]=impz(1,[1 1],5)
//OUTPUT
// t_r =   0.    1.    2.    3.    4
//x_r =   1.  - 1.    1.  - 1.    1.

//This function is being called from Octave

if(argn(2)<1 | argn(2)>4)
error("Wrong number of input arguments.")
end

	
endfunction



function [x_r, t_r] = impz(b, a = [1], n = [], fs = 1)

  if nargin == 0 || nargin > 4
    print_usage;
  endif

  if isempty(n) && length(a) > 1
    precision = 1e-6;
    r = roots(a);
    maxpole = max(abs(r));
    if (maxpole > 1+precision)     # unstable -- cutoff at 120 dB
      n = floor(6/log10(maxpole));
    elseif (maxpole < 1-precision) # stable -- cutoff at -120 dB
      n = floor(-6/log10(maxpole));
    else                           # periodic -- cutoff after 5 cycles
      n = 30;

      ## find longest period less than infinity
      ## cutoff after 5 cycles (w=10*pi)
      rperiodic = r(find(abs(r)>=1-precision & abs(arg(r))>0));
      if !isempty(rperiodic)
        n_periodic = ceil(10*pi./min(abs(arg(rperiodic))));
        if (n_periodic > n)
          n = n_periodic;
        endif
      endif

      ## find most damped pole
      ## cutoff at -60 dB
      rdamped = r(find(abs(r)<1-precision));
      if !isempty(rdamped)
        n_damped = floor(-3/log10(max(abs(rdamped))));
        if (n_damped > n)
          n = n_damped;
        endif
      endif
    endif
    n = n + length(b);
  elseif isempty(n)
    n = length(b);
  elseif (! isscalar (n))
    ## TODO: missing option of having N as a vector of values to
    ##       compute the impulse response.
    error ("impz: N must be empty or a scalar");
  endif

  if length(a) == 1
    x = fftfilt(b/a, [1, zeros(1,n-1)]');
  else
    x = filter(b, a, [1, zeros(1,n-1)]');
  endif
  t = [0:n-1]/fs;

  if nargout >= 1 x_r = x; endif
  if nargout >= 2 t_r = t; endif
  if nargout == 0
    unwind_protect
      title "Impulse Response";
      if (fs > 1000)
        t = t * 1000;
        xlabel("Time (msec)");
      else
        xlabel("Time (sec)");
      endif
      plot(t, x, "^r;;");
    unwind_protect_cleanup
      title ("")
      xlabel ("")
    end_unwind_protect
  endif

endfunction

