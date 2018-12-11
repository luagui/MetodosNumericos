%Luis Aguirre Galindo
	puntos = input('Introducir el vector con los puntos a interpolar');
	aux = input('0 = Interpolar tabla | 1 = Interpolar funcion');
    
	numPuntos = size(puntos,2);
	
	if (aux == 0) 
		imagenesP = input('Introducir el vector con los imagen de los puntos a interpolar');
	else
		sFuncion = input('Introducir la función con ''x'' como variable  ','s');
		fvectorizada = vectorize(sFuncion);
		f = eval(['@(x) ' fvectorizada]);
		imagenesP = f(puntos); 
	end
	
	%Inicializamos la primera columna
	tabla = imagenesP;
	prod = [1];
	pol = [imagenesP(1)];
    prod = [prod, 0] - [0, prod.*puntos(1)];
	for j = 2 : numPuntos
		for i = 1 : numPuntos + 1 - j 
			tabla(i) = (tabla(i) - tabla(i+1)) / (puntos(i) - puntos(i+j-1));
        end		
		pol = [0 pol] + prod*tabla(1);
        prod = [prod, 0] - [0, prod.*puntos(j)];
		
	end
 %En la ultima vuelta calculamos el productorio de tam NumPuntos, por si
 %nos piden más puntos de interpolacion	
	pmax = max(puntos);
	pmin = min(puntos);
    %En la ultima vuelta calculamos el productorio de tam NumPuntos, por si
    %nos piden más puntos de interpolacion
	r = linspace(pmin, pmax, 100);
	plot(r, polyval(pol,r))
	hold on
	if aux==1
		fplot(f,[pmin pmax])
	end 
	hold off
    aux1 = input('Desea añadir otro punto de interpolacion (1 = SI | 0 = no)');
    
    while (aux1) 
        numPuntos = numPuntos+1;
        puntoExtra = input ('Introduce el punto extra');
        puntos(numPuntos) = puntoExtra;
        if (aux == 0) 
		imageneExtra = input('Introducir la imagen del punto extra');
        else
        imageneExtra = f(puntoExtra);
        end
        
        imagenesP(numPuntos) = imageneExtra;        
        %Recalculamos el vector;
       
        tabla(numPuntos) = imageneExtra;
        for i = numPuntos - 1: -1 : 1
              tabla(i) = (tabla(i) - tabla(i+1)) / (puntos(i) - puntos(numPuntos));  
        end
        
        pol = [0 pol] + prod*tabla(1);
        prod = [prod, 0] - [0, prod.*puntos(numPuntos)]; %Para la siguiente vuelta
        
        pmax = max(puntos);
        pmin = min(puntos);
        %En la ultima vuelta calculamos el productorio de tam NumPuntos, por si
        %nos piden más puntos de interpolacion
        r = linspace(pmin, pmax, 100);
        plot(r, polyval(pol,r))
        hold on
        if aux==1
            fplot(f,[pmin pmax])
        end 
        hold off
        
     aux1 = input('Desea añadir otro punto de interpolacion (1 = SI | 0 = no)');
    end
end