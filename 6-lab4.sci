
clc; clear; clf;

// Tin hieu
x = [1 2 -3 2 1];   N = length(x);  nx = 0:N-1;
h = [1 0 -1];       M = length(h) - 1;
Ly = N + M;         ny = 0:Ly-1;

// ===== 1) Phuong phap gap va dich chuyen =====
// y(n) = sum_{k=0}^{M} h(k) x(n-k)
y1 = zeros(1, Ly);
for n = 0:Ly-1
    s = 0;
    for k = 0:M
        if (n-k >= 0) & (n-k <= N-1) then
            s = s + h(k+1) * x(n-k+1);   // Scilab danh chi so tu 1
        end
    end
    y1(n+1) = s;
end
disp("y(n) - gap va dich chuyen:"); disp(y1);

// ===== 2) Phuong phap ma tran =====
// H kich thuoc (N+M) x N, cot j la h dich xuong j-1 hang
H = zeros(Ly, N);
for j = 1:N
    H(j:j+M, j) = h';
end
disp("Ma tran H:"); disp(H);
y2 = (H * x')';
disp("y(n) - ma tran:"); disp(y2);

// ===== Kiem tra bang ham co san =====
y3 = convol(h, x);
disp("y(n) - convol():"); disp(y3);
disp("Sai khac lon nhat: " + string(max(abs([y1 - y2, y1 - y3]))));

// ===== 3) Nang luong =====
Ex = sum(x.^2);
Ey = sum(y1.^2);
disp("Ex = " + string(Ex) + ",  Ey = " + string(Ey));
Exc = cumsum(x.^2);     // nang luong tich luy
Eyc = cumsum(y1.^2);

// ===== Ve tren cung mot hinh =====
subplot(3,1,1);
plot2d3(nx, x); plot(nx, x, 'bo');
xgrid(); xtitle("x(n)", "n", "x(n)");
a = gca(); a.data_bounds = [-1, -4.5; 7, 4.5];

subplot(3,1,2);
plot2d3(ny, y1); plot(ny, y1, 'ro');
xgrid(); xtitle("y(n) = x(n) * h(n)", "n", "y(n)");
a = gca(); a.data_bounds = [-1, -4.5; 7, 4.5];

subplot(3,1,3);
plot(nx, Exc, 'b-o');
plot(ny, Eyc, 'r-s');
xgrid(); xtitle("Nang luong tich luy E(n) = sum |s(k)|^2", "n", "E(n)");
a = gca(); a.data_bounds = [-1, 0; 7, 45];
legend(["E_x, tong = " + string(Ex); "E_y, tong = " + string(Ey)], "in_lower_right");

p = get_absolute_file_path("6-lab4.sci");
xs2png(gcf(), p + "bai6_scilab.png");
