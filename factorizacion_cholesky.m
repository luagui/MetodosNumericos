%Luis Aguirre Galindo
function [sol, FC]= factorizacion_cholesky(mA, B)
	tam = size(mA,1);
	
	if nargout == 2
		cH = zeros(tam) %zeros hace matriz automaticamente
		
		%Calculemos la matriz B ( la primera columna la calculamos a parte)
		cH(1,1) = sqrt(mA(1,1));
		if ( cH(1,1) <= 0 )
				error ('La matriz no admite factorizacion Cholesky')
		end
		for (j=2:tam) 
			cH(j,1) = mA(1,j) / cH(1,1);
		end 
		
		for (i=2:tam) 
			%Calculemos el valor aux , antes de realizar la raiz, para ver si es positivo
			aux = mA(i,i) - cH(i,1:i-1)*cH(i,1:i-1)';
			if ( aux <= 0 )
				error ('La matriz no admite factorizacion Cholesky')
			end
			cH(i,i) = sqrt(aux);
			
			%Calculamos el resto de valores de la columna i;
			for (j=i+1:tam) 
				cH(j,i) = (mA(i,j) - cH(i,1:i-1)*cH(j,1:i-1)') / cH(i,i);
			end
		
		end
		%Una vez calculada la matriz cH, podemos calcular la solucion del sistema. Para ello
		%primero resolvemos cHw = B, y luego cH'u = w
	end
	%Remonte inferior para resolver cHw = b
	W=1:1:tam;
	W(1) = B(1)/ cH(1,1);
	for i = 2:tam 
	 W(i) = (B(i) - cH(i, 1:i-1)*W(1:i-1)') / cH(i,i); 
	end
	
	%Remonte superior para resolver cH'u = w
	
	cHT = cH';
	u = 1:1:tam;
	u(tam) = W(tam)/ cHT(1,1);
	
	for i = tam - 1: -1: 1 
	 u(i) = (W(i) - cHT(i, i+1:tam)*u(i+1:tam)') / cHT(i,i); %A diferencia de L, U no tiene por qué tener 1 en la diagonal
	end
	
	sol = u;
	FC = cH;
	
end

	
	