
%Inicializacion
A = input('Introduzca la matriz cuadrada'); 
b = input('Introduzca el vector de terminos independientes');
M = A;
tam = size(A,1);
pointer=1:1:tam;

%Bucle principal
for i = 1: (tam - 1)
	%Escogemos el pivote (en principio el valor (pointer(i),i)
	[piv,aux] = max(abs(M(pointer(i:tam), i)));
	aux = aux + (i - 1); %Porque el indice que nos devuelve empieza a contar en la submatriz (pointer(i:size), i)
	if ( piv == 0 ) % El pivote elegido es nulo
		error('No se puede resolver por el metodo de eliminación Gaussiana. Resultado no valido');
	end
	%Permutamos la fila i y la fila del puntero elegido pointer(aux)
	aux1 = pointer(i);
	pointer(i) = pointer(aux);
	pointer(aux) = aux1;
	%Eliminamos debajo del pivote
	for k = (i+1):tam
		%Y recalculamos la columna i (debajo del pivote)
        M(pointer(k),i)= M(pointer(k),i) / M(pointer(i),i); %No podemos usar piv, porque la varible puede ser negativa, y piv es abs()
			%Restamos el dato de la fila pointer(k) de la columna i, a las i + 1, i + 2, ... , n
        M(pointer(k),i+1:tam) = M(pointer(k),i+1:tam) - M(pointer(i),i+1:tam)*M(pointer(k),i);
    end 
end

%Remonte triangular inferrior
w = 1:1:tam;
w(1) = b(pointer(1));
for i = 2:tam 
	w(i) = b(pointer(i)) - M(pointer(i), 1:i-1)*w(1:i-1)';
end
%Remonte triangular superior
sol= 1:1:tam;
sol(tam) = w(tam)/M(pointer(tam),tam);
for i = tam-1:-1:1
	sol(i) = (w(i) - M(pointer(i), i+1:tam)*sol(i+1:tam)')/M(pointer(i),i);
end

disp(sol);
disp('Es la solucion del sistema');
		
aux = input('Desea cambiar el vector de terminos independiente 1:Si, 0:No');

while aux == 1
	b = input('Introduzca el nuevo vector de terminos independientes');
	
	%Remonte triangular inferrior
	w = 1:1:tam;
	w(1) = b(pointer(1));
	for i = 2:tam 
		w(i) = b(pointer(i)) - M(pointer(i), 1:i-1)*w(1:i-1)';
	end
	%Remonte triangular superior
	sol= 1:1:tam;
	sol(tam) = w(tam)/M(pointer(tam),tam);
	for i = tam-1:-1:1
		sol(i) = (w(i) - M(pointer(i), i+1:tam)*sol(i+1:tam)')/M(pointer(i),i);
	end

	disp(sol);
	disp('Es la solucion del sistema');
			
	aux = input('Desea cambiar el vector de terminos independiente 1:Si, 0:No');
	
end
	

