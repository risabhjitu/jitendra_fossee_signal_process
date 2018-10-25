function [y, z] = filter1(b, a, x, z)
// Parameters
//b: Matrix or Integer or polynomial
//a: Matrix or Integer or polynomial
//x: Matrix or Integer 
// z: Matrix and Integer
//Examples
//filter1([1,2,3], [3,4,5], [5,6,7])
//ans = 
//    1.6666667    3.1111111    4.4074074  
    //Implements a direct form II transposed implementation of the standard
    //difference equation

    if argn(2)< 3 | argn(2) > 4
        error('Wrong number of input arguments');
    end

    if argn(2) == 3
        z = 0;
    end

    if ~isreal(b) & ismatrix(b) & typeof(b)~="polynomial"
        error('b must be a real vector or polynomial");
    elseif ~isreal(a) & ismatrix(a) & typeof(b)~="polynomial"
        error('a must be a real vector or polynomial");
    elseif ~isreal(x)& ismatrix(x)
        error('x must be a real vector");
    elseif ~isreal(z)& ismatrix(z)
        error('z must be a real vector");
    end

    if typeof(b) == "polynomial" & (size(a,2)*size(a,1)) ~= 1
        error( 'a polynomial and 1-by-1 matrix or two polynomials expected');
    end


    if typeof(a) == "polynomial" & (size(b,2)*size(b,1)) ~= 1
        error('a polynomial and 1-by-1 matrix or two polynomials expected');
    end

    if typeof(b) == "polynomial" | typeof(a) == "polynomial"
        c = b/a;
        b = numer(c);
        a = denom(c);
        deg_b = degree(b);
        deg_a = degree(a);
        deg = max(deg_b, deg_a);
        b = coeff(b, deg:-1:0);
        a = coeff(a, deg:-1:0);
    end

    if a(1) == 0
        error('First element of a must not be zero');
    end

    //force vector orientation
    b   = matrix(b, -1, 1);
    a   = matrix(a, -1, 1);
    mnx = size(x);
    x   = matrix(x, 1, -1);

    //normalize
    b = b / a(1);
    a = a / a(1);

    n = max(size(b, "*"), size(a, "*"))-1;
    if n > 0 then
        if argn(2) < 4 then
            z = zeros(n, 1);
        else
            z = matrix(z, n, 1);
        end

        a($ + 1:(n + 1)) = 0;
        b($ + 1:(n + 1)) = 0;

        A     = [-a(2:$), [eye(n - 1, n - 1); zeros(1, n - 1)] ];
        B     = b(2:$) - a(2:$) * b(1); //C = eye(1, n); D = b(1);

        [z, X] = ltitr(A, B, x, z);
        y     = X(1, :) + b(1) * x;

    else
        y     = b(1) * x;
        z     = [];
    end
    y = matrix(y, mnx);

endfunction

