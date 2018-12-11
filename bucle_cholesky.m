%Luis Aguirre Galindo
 b = input('Introduzca la matriz de terminos independientes');
 A = input('Introduzca la matriz de coeficientes');
 
 [sol, factCho] = factorizacion_cholesky(A,b);
disp('La solucion del sistema es:');
disp(sol);
disp('La factorizacion LU es:');
disp(factCho);

aux = input('Desea cambiar el vector de terminos independientes 1:Si, 0:No');

while aux == 1
	B = input ('Introduzca los terminos independientes');
	[sol] = factorizacion_lu(factCho,B);
	disp('La solucion del sistema es:');
	disp(sol);
	aux = input('Desea cambiar el vector de terminos independientes 1:Si, 0:No');
end