# semana8mn
Tarea Semana 8 de Métodos Numéricos

En el inicio del código se cargaron los datos de tiempo y voltaje del biosensor y se utilizó un spline cúbico natural para interpolar valores entre los puntos medidos, lo que permitió estimar V(4.3) y V(8.7) y comparar con la interpolación lineal para observar que el spline genera una curva más suave. 

Para la parte 2, se aplicó la fórmula de diferencias centradas para calcular la derivada en t=4.0, 8.0 y 12.0 ms, obteniendo la velocidad de cambio del voltaje y permitiendo interpretar si la deformación del tejido aumentaba o disminuía. 

Para la parte 3, se identificaron los intervalos donde la señal cruza por cero (en [7.0, 7.5] y [10.0, 10.5]) y se empleó el método de bisección sobre el spline en el intervalo [7.0, 7.5] ms, realizando dos iteraciones y determinar la raíz en 7.4468 ms, que corresponde al instante en que el circuito de decisión cambia de estado al pasar el voltaje por cero.
