function c = clustersegment(x)
//This function calculates boundary indexes of clusters of 1’s.
//Calling Sequence
//c = clustersegment(x)
//Parameters 
//s: scalar, vector or matrix of real numbers (clusters of 1s) 
//c: output variable, cell array of size 1 by N, where N is the number of rows in s
//Description
//This function calculates boundary indexes of clusters of 1’s.
//This function calculates the initial and end indices of the sequences of 1's present in the input argument.
//The output variable c is a cell array of size 1 by N, where N is the number of rows in s and each element has two rows indicating the initial index and end index of the cluster of 1's respectively. The indexing starts from 1.
//Examples
//y = clustersegment ([0,1,0,0,1,1])
//y  =
//    2.    5.  
//    2.    6.  


if(argn(2)~=1)
error("Wrong number of input arguments.")
end

 // ## Find discontinuities
  bool_discon = diff(x,1,2);
  [Np Na] = size(x);
  c = cell(1,Np);

  if Np >1 then
            c1=list();
            
  end

  for i = 1:Np
            c = cell(1,Np);
      
    idxUp = find(bool_discon(i,:)>0)+1;
    idxDwn = find(bool_discon(i,:)<0);
    tLen = length(idxUp) + length(idxDwn);

    if x(i,1)==1 then
     // ## first event was down
  //   disp('Here'); disp(idxUp); disp(idxDwn)
   //  disp(tLen)

      c(i).entries(1) = 1;
      c(i).entries(2:2:tLen+1) = idxDwn;
      c(i).entries(3:2:tLen+1) = idxUp;
    else
              
     // ## first event was up
      c(i).entries(1:2:tLen) = idxUp;
      c(i).entries(2:2:tLen) = idxDwn;
    end

    if x(i,$)==1 then
     // ## last event was up
      c(i).entries($+1) = Na;
    end
    
    tLen = length(cell2mat(c(i)));
    
    if tLen ~=0 then
             
              
              if Np == 1 then
                         c=matrix(cell2mat(c(i)),2,tLen/2);
              else
                      
              t = matrix(cell2mat(c(i)),2,tLen/2);
           
              
               c1(i)=t
              end
              
              if Np >1 then
              c=c1;
              end
             
     
     
    end
    
end


endfunction
