function y=czt(x,m,w,a)
////Chirp Z Transform
////Calling Sequence
////czt (x)
////czt (x, m)
////czt (x, m, w)
////czt (x, m, w, a)
////Parameters 
////x: Input scalar or vector
////m: Total Number of steps
////w: ratio between points in each step
////a: point in the complex plane 
////Description
////Chirp z-transform. Compute the frequency response starting at a and stepping by w for m steps. a is a point in the complex plane, and w is the ratio between points in each step (i.e., radius increases exponentially, and angle increases linearly).
////Examples
//// m = 32;                               ## number of points desired
//// w = exp(-j*2*pi*(f2-f1)/((m-1)*Fs));  ## freq. step of f2-f1/m
//// a = exp(j*2*pi*f1/Fs);                ## starting at frequency f1
//// y = czt(x, m, w, a);
    
 [row, col] = size(x);
 if row == 1, x = x(:); col = 1; end

 if nargin < 2 | isempty(m), m = length(x(:,1)); end
 if length(m) > 1, error("czt: m must be a single element\n"); end
 if nargin < 3 | isempty(w), w = exp(-2*j*%pi/m); end
 if nargin < 4 | isempty(a), a = 1; end
 if length(w) > 1, error("czt: w must be a single element\n"); end
 if length(a) > 1, error("czt: a must be a single element\n"); end
//   

    n=max(size(x));
    nm=max([n,m]);

    //create sequence h(n)=[w*exp(-j*phi)]**(-n*n/2)

    //w=w*exp(-%i*phi);
    idx=(-nm+1:0);
    idx=-idx.*idx/2;
    h=exp(idx*log(w));
    h(nm+1:2*nm-1)=h(nm-1:-1:1);

    //create g(n)

   // a=a*exp(%i*theta);
    idx=(0:n-1);
    g=exp(-idx*log(a))./h(nm:nm+n-1);
    g=x.*g;

    //convolve h(n) and g(n)

    hc=h(nm:nm+m-1);
    hc(m+1:m+n-1)=h(nm-n+1:nm-1);
    gc=0*ones(hc);
    gc(1:n)=g;
    hf=fft(hc,-1);
    gf=fft(gc,-1);
    hcg=fft(hf.*gf,1);

    //preserve m points and divide by h(n)

    y=hcg(1:m)./h(nm:nm+m-1);
endfunction




