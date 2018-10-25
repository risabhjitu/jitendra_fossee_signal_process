function y= sinewave(x, n,d)
//Return an x-element vector with I-th element given by 'sin(2* pi *(I+D-1)/N).'
//Calling Sequence
//y= sinewave(M)
//y= sinewave(M,N)
//y= sinewave(M,N,D)
//Parameters 
//Description
//Return an x-element vector with I-th element given by 'sin(2* pi *(I+D-1)/N).'
if(argn(2)<2 | argn(2)>3)
error("Wrong number of input arguments")
end

if argn(2)==2 then
    d=0;
end
  y = sin (((1 : x) + d - 1) * 2 *%pi / n);
endfunction
