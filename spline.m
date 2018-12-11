%Luis Aguirre Galindo
    tipo = input('Introduzca el tipo de spline');
    puntos = input('Introducir el vector con los puntos a interpolar en orden creciente');
	aux = input('0 = Interpolar tabla | 1 = Interpolar funcion');
    
	numPuntos = size(puntos,2); %Numpuntos = n + 1
	
	if (aux == 0) 
		imagenesP = input('Introducir el vector con los imagen de los puntos a interpolar');
	else
		sFuncion = input('Introducir la función con ''x'' como variable  ','s');
		fvectorizada = vectorize(sFuncion);
		f = eval(['@(x) ' fvectorizada]);
		imagenesP = f(puntos); 
	end
	lambda = zeros(1,numPuntos);
    mu = zeros(1,numPuntos);
    d = zeros(1,numPuntos);
    h = zeros(1,numPuntos);
    h(1) = puntos(2) - puntos(1); %x1 - x0
    
    %Recordar que lambda(1) = lambda_sub_0
    
    for j = 2 : numPuntos - 1 
      h(j) = puntos(j+1) - puntos(j); 
      lambda(j) = h(j) / (h(j) + h(j-1));
      mu(j) = 1 - lambda(j);
      d(j) = (6 /(h(j) + h(j-1))) * ( (imagenesP(j+1) - imagenesP(j)) / h(j) - (imagenesP(j) - imagenesP(j-1)) / h(j-1));
    end
    
    if (tipo == 2) 
        if aux == 0 
        y0 = input ('Introduce y_prima_subzero');
        yn = input ('Introduce y_prima_subn');
        else 
		fderivadaVec = vectorize(diff(sym(f)));
		fderivada = eval(['@(x) ' fderivadaVec]);
		yo = fderivada(puntos(1));
		yn = fderivada(puntos(numPuntos));
        end
            
        lambda(1) = 1;
        mu(numPuntos) = 1;
        d(1) =  6/h(1) * ( ((imagenesP(2) - imagenesP(1)) / h(1)) - y0);
        d(numPuntos) = 6/h(numPuntos-1) * ( yn - ((imagenesP(numPuntos) - imagenesP(numPuntos - 1)) / h(numPuntos-1)));
    end
    
    x = 2*ones(1,numPuntos);
    x1 = mu(1,2:numPuntos);
    x2 = lambda (1,1:numPuntos - 1);
    [M] = sist_trid(x,x1,x2,d);
    
    polsaux = [];
    
    for i = 1 : numPuntos - 1
      aux1 = [0,0,0,imagenesP(i)];
      aux2 = (((imagenesP(i+1)-imagenesP(i))/h(i)) - h(i)*((2*M(i)+M(i+1))/6))*[0, 0, 1, -puntos(i)];
      aux3 = (M(i)/2)*[0,1,-2*puntos(i), puntos(i)^2];
      aux4 =  ((M(i+1)-M(i))/(6*h(i)))*[1, -3*puntos(i), 3*puntos(i)^2, -puntos(i)^3];
      aux = aux1 + aux2 + aux3 + aux4;
      polsaux = [polsaux; aux];
    end
    %Pintamos los polinomios
    n = size(polsaux, 1);  
    for i = 1:n
        r = linspace(puntos(i), puntos(i + 1), 100);
        plot(r, polyval(polsaux(i,:), r));
        hold on;
    end
    hold off;

    