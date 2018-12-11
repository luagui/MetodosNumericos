
%Luis Aguirre Galindo

A = input ('Introduzca la matriz de coeficientes');
B = input ('Introduzca los terminos independientes');

[sol, factLU] = factorizacion_lu(A,B);
disp('La solucion del sistema es:');
disp(sol);
disp('La factorizacion LU es:');
disp(factLU);

aux = input('Desea cambiar el vector de terminos independientes 1:Si, 0:No');

while aux == 1
	B = input ('Introduzca los terminos independientes');
	[sol] = factorizacion_lu(factLU,B);
	disp('La solucion del sistema es:');
	disp(sol);
	aux = input('Desea cambiar el vector de terminos independientes 1:Si, 0:No');
end