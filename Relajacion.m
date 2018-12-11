%Luis Aguirre Galindo

	% iter = numero de iteraciones que se desea
	% p = precision que se desea(error relativo)
	% v = variable de relajacion para el metodo
	
	mA = input('Introduzca la matriz A del sistema');
	B = input('Introduzca el vector de terminos independientes');
	iter = input('Introduza el numero maximo de iteraciones');
	p = input('Introduzca la precision del metodo requerida');
	v = input('Introduzca la variable de relajacion');

	tam = size(mA,1);
	rk = 1:1:tam;
	uk = 1:1:tam; %u0 es arbitrario, asi que da igual a qué lo inicialicemos
	dk = 1:1:tam;
    bol = 0;

	for k=1:iter
		for i=1:tam
		rk(i) = B(i) - mA(i,1:tam)*uk(1:tam)';
		dk(i) = v*rk(i)/mA(i,i);
		uk(i) = dk(i) + uk(i);
		end
		if norm(rk) < p*norm(B)
            bol = 1;
			disp ('El metodo ha terminado al alcanzar la precision requerida');
			disp ('El numero de iteraciones realizado ha sido: ')
			disp (k);
			break;
		end
    end
    if bol == 0 
        disp ('El test ha parado al alcanzar las iteraciones maximas');
    end
	sol = uk;


