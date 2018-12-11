
%Luis Aguirre Galindo

function [sol, FLU]= factorizacion_lu(mA, mB)
    tam=size(mA,1);
	
	if nargout == 2 %La primera columna (L) la la calculamos a parte
        if (mA(1,1) == 0)   
			error('La matriz no admite factorizacion LU')
        end
        mA(2:tam,1) = mA(2:tam,1)/mA(1,1);
        
        
		for i = 2 :tam  %Calculamos cada U y L de la fila i
			for j=i:tam
				mA(i,j) = mA(i,j) - mA(i, 1:i-1) * mA(1:i-1, j); %Fila i-esima de la u
			end
			
			if (mA(i,i) == 0)   %Es decir, U(i,i) = 0
			error('La matriz no admite factorizacion LU');
            end
			for l = i + 1 : tam
				mA(l,i) = (mA(l,i) - mA(l, 1:i-1) * mA(1:i-1,i)) / mA(i,i); %Columna i esima de la u	
			end
		end
	end
	
%Ahora que tenemos A expresada como U (triangular superior) y L(triangular inferior, que sabemos que tiene 1 en la diagonal),
% calculamos la sol del sistema resolviendo por el metodo del remonte Lw = B, y Uu = w;

	W=1:1:tam;
	W(1)= mB(1); 
	
	for i = 2: tam 
	 W(i) = mB(i) - mA(i, 1:i-1)*W(1:i-1)';
	end
	
	%Ya hemos obtenido W, ya podemos calcular la solucion del sistema que llamaremos c
	c=1:1:tam;
	c(tam) = W(tam)/ mA(tam,tam);
	for i = tam - 1: -1: 1 
	 c(i) = (W(i) - mA(i, i+1:tam)*c(i+1:tam)') / mA(i,i); %Ha diferencia de L, U no tiene por qué tener 1 en la diagonal
	end
	
	sol = c;
	FLU = mA;
end