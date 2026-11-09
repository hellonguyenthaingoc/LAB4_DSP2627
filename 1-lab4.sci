clc; clear; clf;

// Tin hieu x(n), n = -2..2
n = -2:2;
x = [2 -1 2 -3 4];

// Bien doi Z: X(z) = sum x(n) z^(-n)
z = poly(0, 'z');
X = 0;
for k = 1:length(n)
    X = X + x(k) * z^(-n(k));
end
disp("X(z) = "); disp(X);

// Zero va pole
zr = roots(X.num);
pl = roots(X.den);
disp("Zeros:"); disp(zr);
disp("|Zeros|:"); disp(abs(zr));
disp("Poles (huu han):"); disp(pl);
disp("ROC: 0 < |z| < inf (tin hieu hai phia, do dai huu han)");

// Ve x(n)
subplot(1,2,1);
plot2d3(n, x);
plot(n, x, 'ro');
xgrid(); xtitle("x(n)", "n", "x(n)");
a = gca(); a.data_bounds = [-3, -4; 3, 5];

// Ve gian do zero-pole


subplot(1,2,2);
t = linspace(0, 2*%pi, 400);
plot(cos(t), sin(t), 'k--');
plot(real(zr), imag(zr), 'bo');
plot(real(pl), imag(pl), 'rx');
xstring(0.05, 0.05, "(2)");                // ghi chu pole boi 2
xgrid(); xtitle("Zero-Pole", "Re(z)", "Im(z)");
a = gca();
a.isoview = "on";
a.data_bounds = [-1.6, -1.6; 1.6, 1.6];    // mo rong khung
legend(["Unit circle"; "Zeros"; "Poles"], "lower_caption");  // dua legend xuong duoi
