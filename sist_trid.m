%luis Aguirre
function [sol] = sist_trid(x1,x,x2,d)
    diag = x;
    diagI = x1;
    diagS = x2;
    
    tam = size(diag,2);
    mD = d;
    m = 1:1:tam;
    g = 1:1:tam;
    solAux= 1:1:tam;
    
    if (size(diagI,2) == tam - 1 && size(diagS,2) == tam - 1)

        m(1)= diag(1);
        g(1)= mD(1)/m(1);

        for k = 2:tam
            m(k)= diag(k) - (diagS(k-1)*diagI(k-1))/m(k-1);
            g(k)= (mD(k)- g(k-1)*diagI(k-1))/m(k);
        end

        solAux(tam) = g(tam);
        for k=tam-1:-1:1
            solAux(k)= g(k) - (diagS(k)*solAux(k+1))/m(k);
        end

        sol=solAux;
    else    
        error('Los tamaños de las diagonales no son adecuados')
    end
end 

