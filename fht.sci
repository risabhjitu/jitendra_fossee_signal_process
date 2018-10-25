function y=fht(d,n,dim)
//The Function calculates the Fast Hartley Transform of real input.
//Calling Sequence
//M = fht (D)
//M = fht (D, N)
//M = fht (D, N, DIM)
//Parameters 
//Description
//This function calculates the Fast Hartley transform of real input D. If D is a matrix, the Hartley transform is calculated along the columns by default.
//Examples
//fht(1:4)
//ans =
//   10   -4   -2   0  
//This function is being called from Octave.
funcprot(0);
rhs=argn(2);
if(argn(2)<1 | argn(2)>3) then
    error("Wrong number of input arguments.")
end

if (argn(2)==3) then
     Y = fft1(d,n,dim);   
elseif (argn(2)==2) then
      Y = fft1(d,n);     
else
     Y = fft1(d);         
end
y= real(Y) - imag(Y);

endfunction
