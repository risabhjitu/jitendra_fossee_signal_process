function A=fftshift1(x, dim)
//Perform a shift of the vector X, for use with the 'fft1' and 'ifft1' functions, in order the move the frequency 0 to the center of the vector or matrix.
//Calling Sequence
// fftshift1 (X)
// fftshift1 (X, DIM)
//Parameters 
//X:It is a vector of N elements corresponding to time samples
//DIM: The optional DIM argument can be used to limit the dimension along which the permutation occurs
//Description
//Perform a shift of the vector X, for use with the 'fft1' and 'ifft1' functions, in order the move the frequency 0 to the center of the vector or matrix.
//
//If X is a vector of N elements corresponding to N time samples spaced by dt, then 'fftshift1 (fft1 (X))' corresponds to frequencies
//
//f = [ -(ceil((N-1)/2):-1:1)*df 0 (1:floor((N-1)/2))*df ]
//
//where df = 1 / dt.
//
//If X is a matrix, the same holds for rows and columns.  If X is an array, then the same holds along each dimension.
    ind=list()
    if argn(2)<2 then
        
        for n=size(x)
            c=ceil(n/2)
            ind($+1)=[c+1:n, 1:c]           
    end
     A=x(ind(:))   
elseif argn(2)==2 then
     if length(size(x))==2|3 & dim>3 then
         dim=3
     elseif length(size(x))>3 & dim>length(size(x)) then
         dim=length(size(x))     
        end
            for n=size(x)
            ind($+1)=:    
    end
    c1=ceil((size(x,dim))/2)
    ind(dim)=[c1+1:(size(x,dim)), 1:c1]
   
    A=x(ind(:))   
else
    error('Too many inputs')
 end
 
   
endfunction

