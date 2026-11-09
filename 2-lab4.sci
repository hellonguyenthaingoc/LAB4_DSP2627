clc; clear; clf;

// Tin hieu x(n) = 0.5^n u(n) + 0.4^n u(n), xet n = 0..20
n = 0:20;
x = 0.5.^n + 0.4.^n;

// Bien doi Z dang giai tich
z = poly(0, 'z');
X = z/(z - 0.5) + z/(z - 0.4);
disp("X(z) = "); disp(X);

// Zero va pole
zr = roots(X.num);
pl = roots(X.den);
disp("Zeros:"); disp(zr);
disp("Poles:"); disp(pl);
rmax = max(abs(pl));
disp("ROC: |z| > " + string(rmax));

// Kiem chung ROC bang tong rieng phan sum x(n) z^(-n), N = 200
N = 200; k = 0:N;
xk = 0.5.^k + 0.4.^k;

z1 = 1;      // nam trong ROC
S1 = sum(xk .* z1.^(-k));
disp("z = 1    : tong rieng = " + string(S1) + ", X(1) = " + string(horner(X, z1)));

z2 = 0.45;   // nam ngoai ROC
S2 = sum(xk .* z2.^(-k));
disp("z = 0.45 : tong rieng = " + string(S2) + " -> phan ky");

// Ve x(n)
subplot(1,2,1);
plot2d3(n, x);
plot(n, x, 'ro');
xgrid(); xtitle("x(n) = 0.5^n u(n) + 0.4^n u(n)", "n", "x(n)");
a = gca(); a.data_bounds = [-1, 0; 21, 2.2];

// Gian do zero-pole va ROC
subplot(1,2,2);
t = linspace(0, 2*%pi, 400);
plot(cos(t), sin(t), 'k--');                 // vong tron don vi
plot(rmax*cos(t), rmax*sin(t), 'm-');        // bien ROC |z| = 0.5
plot(real(zr), imag(zr), 'bo');
plot(real(pl), imag(pl), 'rx');
xgrid(); xtitle("Zero-Pole, ROC: |z| > 0.5", "Re(z)", "Im(z)");
a = gca();
a.isoview = "on";
a.data_bounds = [-1.3, -1.3; 1.3, 1.3];
legend(["Unit circle"; "|z| = 0.5"; "Zeros"; "Poles"], "lower_caption");

xs2png(gcf(), "bai2_scilab.png");
