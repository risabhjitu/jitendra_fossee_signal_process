function A = ifft1(x, n, dim)
//Calculates the inverse discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
//Calling Sequence
//ifft1 (x, n, dim)
//ifft1 (x, n)
//ifft1 (x)
//Parameters 
//x: input matrix
//n: Specifies the number of elements of x to be used
//dim: Specifies the dimention of the matrix along which the inverse FFT is performed

//The inverse FFT is calculated along the first non-singleton dimension of the array. Thus, inverse FFT is computed for each column of x.
//
//n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the inverse FFT is calculated, then x is resized and padded with zeros.
//Similarly, if n is smaller, then x is truncated.
//
//dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//ifft1 (x, n, dim)
          
          
          rhs = argn(2)
          if rhs==1 then
                    
         if isvector(x) then         
         x=x(:);  
         end        
          
 for l=1:size(x,2)         
  xx= x(:,l);     
N = max(size(xx));          
for k = 1:N
  AA(1,k) = 0;
  for nn = 1:N
   AA = mtlb_i(AA,k,mtlb_a(AA(k),mtlb_e(xx,nn) .*exp((((((1*%i) .*2) .*%pi) .*(nn-1)) .*(k-1)) ./N)));
   
  end;
end; 
A(l,:)=(1/N)*AA;
end 
A=A';                  
        // end



                
         elseif rhs==2 then
                   
                   
 if isvector(x) then 
 

   x=x(:); 
   end      
          
 for l=1:size(x,2) 
       xx= x(:,l);       
    if length(xx)>=n then
            xx=xx(1:n)
  else
            xd=zeros(n,1);
            xx(max(size(xd))) = 0;         
  end                             
N = max(size(xx));          
for k = 1:N
  AA(1,k) = 0;
  for nn = 1:N
   AA = mtlb_i(AA,k,mtlb_a(AA(k),mtlb_e(xx,nn) .*exp((((((1*%i) .*2) .*%pi) .*(nn-1)) .*(k-1)) ./N)));
   
  end;
end; 
A(l,:)=(1/N)*AA;
end 
A=A';                  
       //   end        
                    
                    
        elseif rhs==3 then
                  
       if dim==1 then
                              
     if isvector(x) then 
       // x=x(:); 
end  
for l=1:size(x,2) 
       xx= x(:,l);       
    if length(xx)>=n then
            xx=xx(1:n)
  else
            xd=zeros(n,1);
            xx(max(size(xd))) = 0;         
            end                              
N = max(size(xx));          
for k = 1:N
  AA(1,k) = 0;
  for nn = 1:N
   AA = mtlb_i(AA,k,mtlb_a(AA(k),mtlb_e(xx,nn) .*exp((((((1*%i) .*2) .*%pi) .*(nn-1)) .*(k-1)) ./N)));
   
  end;
end; 
A(l,:)=(1/N)*AA;
end 
A=A'; 

 
                 
         elseif dim==2 then        
                 
          if isvector(x) then 
       // x=x(:); 
end  
for l=1:size(x,1) 
       xx= x(l,:);       
    if length(xx)>=n then
            xx=xx(1:n)
  else
            xd=zeros(n,1);
            xx(max(size(xd))) = 0;         
            end                              
N = max(size(xx));          
for k = 1:N
  AA(1,k) = 0;
  for nn = 1:N
   AA = mtlb_i(AA,k,mtlb_a(AA(k),mtlb_e(xx,nn) .*exp((((((1*%i) .*2) .*%pi) .*(nn-1)) .*(k-1)) ./N)));
   
  end;
end; 
A(l,:)=(1/N)*AA;
end 
A=A; 
       
      elseif dim>2 then 

      A=[];               
           for m=1:n
             A=[A x];
           end
           disp(A)
         A=matrix(A, [size(x,1) size(x,2) (repmat(1,[dim-3 1]))' n])                                          
                  
    end                
                                      
          end
          
endfunction














