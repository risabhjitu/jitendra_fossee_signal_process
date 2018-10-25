function y = dst1(x, n)
//Computes the type I discrete sine transform of x
//Calling Sequence
//y= dst1(x)
//y= dst1(x,n)
//Parameters 
//x: real or complex valued vector
//n= Length to which x is trimmed before transform 
//Description
//Computes the type I discrete sine transform of x. If n is given, then x is padded or trimmed to length n before computing the transform. If x is a matrix, compute the transform along the columns of the the matrix.

if(argn(2)>2 |argn(2)<1)
error("Wrong number of input arguments");
end
if isvector(x) then
          x=x(:);
end


[r, c] = size (x);

if argn(2)==1 then
          n=r;
end

if n>r then
          aa = zeros(n,c);
         
          aa(1:size(x,1),:) =x;
          x=aa;      //x[ x; zeros(n-r,c) ];
elseif n<r then
       x= x(1:n,:)//(r-n+1 : n,:) = [];   
end



y=zeros(2*(n+1),c);
y(2:n+1,:)=x;
y(n+3:2*(n+1),:)=-(x($:-1:1,:))// 
y=fft1(y);
y=y(2:n+1,:)/(-2*sqrt(-1));



//
//y = fft ([zeros(1,c); x ; zeros(1,c); -(x($:-1:1,:)) ])/-2*%i;
//y = y(2:r+1,:);
  if isreal(x), 
            y = real (y); 
          end

endfunction





//
//
//
//function y = dst (x, n)
//
//  if (nargin < 1 || nargin > 2)
//    print_usage;
//  endif
//
//  transpose = (rows (x) == 1);
//  if transpose, x = x (:); endif
//
//  [nr, nc] = size (x);
//  if nargin == 1
//    n = nr;
//  elseif n > nr
//    x = [ x ; zeros(n-nr,nc) ];
//  elseif n < nr
//    x (nr-n+1 : n, :) = [];
//  endif
//
//  y = fft ([ zeros(1,nc); x ; zeros(1,nc); -flipud(x) ])/-2j;
//  y = y(2:nr+1,:);
//  if isreal(x), y = real (y); endif
//
//  ## Compare directly against the slow transform
//  ## y2 = x;
//  ## w = pi*[1:n]'/(n+1);
//  ## for k = 1:n, y2(k) = sum(x(:).*sin(k*w)); endfor
//  ## y = [y,y2];
//
//  if transpose, y = y.'; endif
//
//endfunction
//
//%!test
//%! x = log(linspace(0.1,1,32));
//%! y = dst(x);
//%! assert(y(3), sum(x.*sin(3*pi*[1:32]/33)), 100*eps)
//
