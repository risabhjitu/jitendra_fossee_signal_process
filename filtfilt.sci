function [y]=filtfilt(b,a,x)

// Zero phase digital filtering
// Calling Sequence
//	[y]=filtfilt(b,a,x)
// Parameters
//	b: Real or complex valued vector or matrix
//	a: Real or complex valued vector or matrix
//	x: Real or complex valued vector or matrix
// Description
//	In theory, it forwards and reverse filters the signal and corrects phase distortion upto an extent by a one-pass filter but squares the magnitude response in the process. Practically though, the correction isn't perfect and magnitude response, particularly the stop band is distorted.
// Examples
// 1.	y=filtfilt (1,2*%i,[%i -4 0])        // Number of Output argument should be equal to 1
//	y =   [-0.25i   1   0]

if (argn(2)~=3) then
	error ("Wrong number of input arguments.")
else 
    if size(x,1)==1
        x=x(:);
    end
    
  lx = size(x,1);
  a = a(:).';
  b = b(:).';
  lb = length(b);
  la = length(a);
  n = max(lb, la);
  lrefl = 3 * (n - 1);
  if la < n, a(n) = 0; end
  if lb < n, b(n) = 0; end

  kdc = sum(b) / sum(a);
  if (abs(kdc) < %inf) 
      A=b - kdc * a
      A1=A(:,$:-1:1);
      A2=cumsum(A1);
      si=A2(:,$:-1:1);
    //si = fliplr(cumsum(fliplr(b - kdc * a)));
  else
    si = zeros(size(a,1), size(a,2)); 
  end
  si(1) = [];

  for (c = 1:size(x,2)) 
    v = [2*x(1,c)-x((lrefl+1):-1:2,c); x(:,c);
         2*x($,c)-x(($-1):-1:$-lrefl,c)]; 

    v = filter(b,a,v,si*v(1)); 
                   
    v1 = filter1(b,a,v($:-1:1,:),si*v($)); 
    v=v1($:-1:1,:)
    y(:,c) = v((lrefl+1):(lx+lrefl));
  end

  if (size(x,1)==1)   
      y=y'                
    y = y($:-1:1,:);               
  end

    
    
    end
endfunction

//
//function y = filtfilt(b, a, x)
//
//  if (nargin != 3)
//    print_usage;
//  endif
//  rotate = (size(x,1)==1);
//  if rotate,                    # a row vector
//    x = x(:);                   # make it a column vector
//  endif
//
//  lx = size(x,1);
//  a = a(:).';
//  b = b(:).';
//  lb = length(b);
//  la = length(a);
//  n = max(lb, la);
//  lrefl = 3 * (n - 1);
//  if la < n, a(n) = 0; endif
//  if lb < n, b(n) = 0; endif
//
//  kdc = sum(b) / sum(a);
//  if (abs(kdc) < inf) 
//    si = fliplr(cumsum(fliplr(b - kdc * a)));
//  else
//    si = zeros(size(a)); 
//  endif
//  si(1) = [];
//
//  for (c = 1:size(x,2)) 
//    v = [2*x(1,c)-x((lrefl+1):-1:2,c); x(:,c);
//         2*x(end,c)-x((end-1):-1:end-lrefl,c)]; 
//
//    v = filter(b,a,v,si*v(1));                  
//    v = flipud(filter(b,a,flipud(v),si*v(end))); 
//    y(:,c) = v((lrefl+1):(lx+lrefl));
//  endfor
//
//  if (rotate)                   
//    y = rot90(y);               
//  endif
//
//endfunction
//
//
