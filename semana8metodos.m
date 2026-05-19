clear; clc;

% pasa datos de la tabla a matlab
t = 0:0.5:15;
V = [4.8120, 4.2635, 3.7541, 3.2804, 2.8387, 2.4236, 2.0314, 1.6583, 1.3011, 1.2574, ...
    1.1460, 0.8624, 0.6048, 0.3720, 0.1672, -0.0186, -0.1805, -0.3142, -0.3148, -0.2769, ...
    -0.2100, 0.0483, 0.2931, 0.5185, 0.7214, 0.8982, 1.0456, 1.1618, 1.2465, 1.3001, 1.3228];

% parte 1
fprintf('Parte 1 ');
% funcion spline natural
pp = spline(t, V);
% V(4.3) y V(8.7) con el spline
fprintf('con spline ');
V_spline = ppval(pp, [4.3, 8.7]);
fprintf('V(4.3)= %.4f V\n', V_spline(1));
fprintf('V(8.7)= %.4f V\n', V_spline(2));
% aprox con interpolación lineal, los mismos valores
fprintf('con interpolación lineal ');
V_lineal = interp1(t, V, [4.3, 8.7], 'linear');
fprintf('V(4.3) lineal = %.4f V\n', V_lineal(1));
fprintf('V(8.7) lineal = %.4f V\n', V_lineal(2));
fprintf('\n');

% parte 2
fprintf('Parte 2 ');
h = 0.5;
% fórmula de diferencias centrales
dV = (V(3:end) - V(1:end-2)) / (2*h);
t_der = t(2:end-1);
% t=4.0, 8.0, 12.0
idx4 = find(t_der == 4.0);
idx8 = find(t_der == 8.0);
idx12 = find(t_der == 12.0);
%resultados
fprintf('V''(4.0) = %.4f V/ms\n', dV(idx4));
fprintf('V''(8.0) = %.4f V/ms\n', dV(idx8));
fprintf('V''(12.0) = %.4f V/ms\n', dV(idx12));
fprintf('\n');

%% Parte 3
fprintf('Parte 3 ');
% intervalos con cruce por cero aprox. en [7.0, 7.5] y [10.0, 10.5]
% aplicar bisección a la primera raíz (en [7.0, 7.5])
f = @(x) ppval(pp, x);
a = 7.0; b = 7.5; tol = 0.001;
% dos iteraciones:
for i = 1:2
    c = (a + b)/2;
    fc = f(c);
    fprintf('Iter %d: a=%.4f, b=%.4f, c=%.4f, f(c)=%.6f\n', i, a, b, c, fc);
    if f(a)*fc < 0
        b = c;
    else
        a = c;
    end
end
i_r = [a, b];
fprintf('intervalo después de dos iteraciones: [%.4f, %.4f]\n', i_r(1), i_r(2));
% seguir hasta tolerancia 10^(-3) ms
while (b - a) > tol
    c = (a + b)/2;
    if f(a)*f(c) < 0
        b = c;
    else
        a = c;
    end
end
raiz = (a + b)/2;
fprintf('raíz estimada con tol 1e-3: %.4f ms\n', raiz);
fprintf('valor en la raíz: %.6f V\n', f(raiz));

%% gráfica
figure;
plot(t, V, 'o-', 'LineWidth', 1.5); hold on;
t_fine = linspace(0, 15, 300);
plot(t_fine, ppval(pp, t_fine), 'r-', 'LineWidth', 1.5);
yline(0, 'k--');
plot(raiz, f(raiz), 'g*', 'MarkerSize', 20, 'LineWidth', 2);
xlabel('t (ms)'); ylabel('V (t)');
title('señal biosensor');
legend('Datos', 'spline cúbico', 'nivel cero', 'raíz');
grid on;
