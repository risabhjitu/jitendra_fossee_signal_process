function y = fftfilt (b, x, N)


  if (argn(2) < 2 | argn(2) > 3)
    error("Wrong number of input arguments");
  end
//  transpose = (rows (x) == 1);
  if (size(x,1)==1)
    x = x.';
  end

  [rx, cx] = size (x);
  [rb, cb] = size (b);

  if min ([rb, cb]) ~= 1
    error (" b should be a vector");
  end

  lb = rb * cb;
  b = matrix (b, lb, 1);

  if (argn(2) == 2)
 
    N = 2 ^ (ceil (log (rx + lb - 1) / log (2)));
    B = fft1 (b, N);
    y = ifft1 (fft1 (x, N) .* B(:,ones (1, cx)));
  else
  
    if (~ (isscalar (N)))
      error (" N has to be a scalar");
    end
    N = 2 ^ (ceil (log (max ([N, lb])) / log (2)));
    L = N - lb + 1;
    B = fft1 (b, N);
    B = B(:,ones (cx,1));
    R = ceil (rx / L);
    y = zeros (rx, cx);
    for r = 1:R;
      lo = (r - 1) * L + 1;
      hi = min (r * L, rx);
      tmp = zeros (N, cx);
      tmp(1:(hi-lo+1),:) = x(lo:hi,:);
      tmp = ifft1 (fft1 (tmp) .* B);
      hi  = min (lo+N-1, rx);
      y(lo:hi,:) = y(lo:hi,:) + tmp(1:(hi-lo+1),:);
    end
  end

  y = y(1:rx,:);
  if (size(x,1)==1)
    y = y.';
  end



  if (isreal (b) & isreal (x))
    y = real (y);
  end
  if (~ or (b - round (b)))
    idx = ~or (x - round (x));
    y(:,idx) = round (y(:,idx));
  end

endfunction
