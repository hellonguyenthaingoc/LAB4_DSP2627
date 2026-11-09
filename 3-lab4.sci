clc; clear; clf;

// Tin hieu x(n) = 0.5^n u(n) + 0.9^n u(-n-1), xet n = -20..20
n = -20:20;
x = 0.5.^n .* bool2s(n >= 0) + 0.9.^n .* bool2s(n <= -1);

// Bien doi Z dang giai tich
z = poly(0, 'z');
X = z/(z - 0.5) - z/(z - 0.9);
disp("X(z) = "); disp(X);

// Zero va pole
zr = roots(X.num);
pl = roots(X.den);
disp("Zeros:"); disp(zr);
disp("Poles:"); disp(pl);
r1 = 0.5; r2 = 0.9;
disp("ROC: " + string(r1) + " < |z| < " + string(r2));

// Kiem chung ROC bang tong rieng phan hai phia, n = -N..N
N = 200; k = -N:N;
xk = 0.5.^k .* bool2s(k >= 0) + 0.9.^k .* bool2s(k <= -1);

zt = [0.7, 0.4, 1];   // 0.7 trong ROC; 0.4 va 1 ngoai ROC
for i = 1:3
    S = sum(xk .* zt(i).^(-k));
    if zt(i) > r1 & zt(i) < r2 then
        disp("z = " + string(zt(i)) + " : tong rieng = " + string(S) + ..
             ", X(z) = " + string(horner(X, zt(i))) + " -> hoi tu");
    else
        disp("z = " + string(zt(i)) + " : tong rieng = " + string(S) + " -> phan ky");
    end
end

// Ve x(n)
subplot(1,2,1);
plot2d3(n, x);
plot(n, x, 'ro');
xgrid(); xtitle("x(n) = 0.5^n u(n) + 0.9^n u(-n-1)", "n", "x(n)");
a = gca(); a.data_bounds = [-21, 0; 21, 9];

// Gian do zero-pole va ROC (vanh khuyen)
subplot(1,2,2);
t = linspace(0, 2*%pi, 400);
plot(cos(t), sin(t), 'k--');              // vong tron don vi
plot(r1*cos(t), r1*sin(t), 'm-');         // bien trong |z| = 0.5
plot(r2*cos(t), r2*sin(t), 'g-');         // bien ngoai |z| = 0.9
plot(real(zr), imag(zr), 'bo');
plot(real(pl), imag(pl), 'rx');
xgrid(); xtitle("Zero-Pole, ROC: 0.5 < |z| < 0.9", "Re(z)", "Im(z)");
a = gca(); a.isoview = "on";
a.data_bounds = [-1.3, -1.3; 1.3, 1.3];
legend(["Unit circle"; "|z| = 0.5"; "|z| = 0.9"; "Zeros"; "Poles"], "lower_caption");

p = get_absolute_file_path("3-lab4.sci");
xs2png(gcf(), p + "bai3_scilab.png");
