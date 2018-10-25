function y= fractdiff(x,d)
//Compute the fractional differences (1-L)^d x where L denotes the lag-operator and d is greater than -1.
//Calling Sequence
// fractdiff (X, D)
//Description
//Compute the fractional differences (1-L)^d x where L denotes the lag-operator and d is greater than -1.

if(argn(2)~=2)
		error("Wrong number of input arguments");
end


N = 100;

  if (~ isvector (x) | ~isscalar(d))
    error ("X must be a vector and D must be a scalar");
  end
  
  if (d<= -1) then
      error ("D must be > -1");
  end
  
  if (d >= 1)
    for k = 1 : d
      x = x(2 : length (x)) - x(1 : length (x) - 1);
    end
  end

  if (d >-1)
       d=d-fix(d./1).*1;

    if (d ~= 0)
      n = (0 : N)';
      w = real (gamma (-d+n) ./ gamma (-d) ./ gamma (n+1));
      y = fftfilt (w, x);
      y = y(1 : length (x));
    else
      y = x;
    end

  end
  
  
endfunction

//
//function retval = fractdiff (x, d)
//
//  if (nargin != 2)
//    print_usage ();
//  endif
//
//  N = 100;
//
//  if (! isvector (x))
//    error ("fractdiff: X must be a vector");
//  endif
//
//  if (! isscalar (d))
//    error ("fractdiff: D must be a scalar");
//  endif
//
//
//  if (d >= 1)
//    for k = 1 : d
//      x = x(2 : length (x)) - x(1 : length (x) - 1);
//    endfor
//  endif
//
//  if (d > -1)
//
//    d = rem (d, 1);
//
//    if (d != 0)
//      n = (0 : N)';
//      w = real (gamma (-d+n) ./ gamma (-d) ./ gamma (n+1));
//      retval = fftfilt (w, x);
//      retval = retval(1 : length (x));
//    else
//      retval = x;
//    endif
//
//  else
//    error ("fractdiff: D must be > -1");
//
//  endif
//
//endfunction
//
