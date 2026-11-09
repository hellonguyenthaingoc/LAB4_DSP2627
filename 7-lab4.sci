x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);
n = 0:(N-1); 

// Tính năng lượng của x(n)
Ex = x.^2;

// PHƯƠNG PHÁP 1: FOLDING AND SHIFTING
y_fold = zeros(1, N);
for i = 0:(N-1)
    sum_val = 0;
    for k = 0:(N-1)
        // Tính chỉ số dịch vòng (i - k) mod N
        // Cộng 1 vì mảng trong Scilab bắt đầu từ index 1
        idx = pmodulo(i - k, N) + 1; 
        sum_val = sum_val + x(k + 1) * h(idx);
    end
    y_fold(i + 1) = sum_val;
end
Ey_fold = y_fold.^2; // Năng lượng của y(n)

// PHƯƠNG PHÁP 2: MA TRẬN (TOEPLITZ)
// Tạo ma trận Toeplitz vòng: 
// Cột 1 là h, hàng 1 là [h(1), h(N), h(N-1), h(N-2)...]
r_circ = [h(1), h(N:-1:2)];
H_matrix = toeplitz(h, r_circ);

// Nhân ma trận H với vector cột x' để ra y, sau đó chuyển vị ngược lại thành hàng
y_mat = (H_matrix * x')'; 
Ey_mat = y_mat.^2; // Năng lượng của y(n)

// VẼ ĐỒ THỊ 1: KẾT QUẢ PHƯƠNG PHÁP FOLDING AND SHIFTING
scf(0); clf(0);

subplot(4,1,1);
plot2d3(n, x, style=2); xgrid();
title('Biểu đồ của x(n)'); xlabel('n'); ylabel('x(n)');

subplot(4,1,2);
plot2d3(n, y_fold, style=5); xgrid();
title('Biểu đồ của y(n) = x(n) * h(n) (Folding and Shifting)'); xlabel('n'); ylabel('y(n)');

subplot(4,1,3);
plot2d3(n, Ex, style=6); xgrid();
title('Biểu đồ của Ex(n)'); xlabel('n'); ylabel('Ex(n)');

subplot(4,1,4);
plot2d3(n, Ey_fold, style=4); xgrid();
title('Biểu đồ của Ey(n)'); xlabel('n'); ylabel('Ey(n)');

// VẼ ĐỒ THỊ 2: KẾT QUẢ PHƯƠNG PHÁP MA TRẬN TOEPLITZ
scf(1); clf(1);

subplot(4,1,1);
plot2d3(n, x, style=2); xgrid();
title('Biểu đồ của x(n)'); xlabel('n'); ylabel('x(n)');

subplot(4,1,2);
plot2d3(n, y_mat, style=5); xgrid();
title('Biểu đồ của y(n) = x(n) * h(n) (Toeplitz)'); xlabel('n'); ylabel('y(n)');

subplot(4,1,3);
plot2d3(n, Ex, style=6); xgrid();
title('Biểu đồ của Ex(n)'); xlabel('n'); ylabel('Ex(n)');

subplot(4,1,4);
plot2d3(n, Ey_mat, style=4); xgrid();
title('Biểu đồ của Ey(n)'); xlabel('n'); ylabel('Ey(n)');
