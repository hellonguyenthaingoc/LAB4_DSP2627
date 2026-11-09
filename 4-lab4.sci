Fs = 8000;
f = 440;
t = (0:(Fs-1)) / Fs;
x = 0.5 * sin(2 * %pi * f * t);

wavwrite(x, Fs, "am_thanh_lab4.wav");
[y, FsDoc, bits] = wavread("am_thanh_lab4.wav");

K = round(0.01 * FsDoc);
n = 0:(K-1);
scf(1);
clf();
plot2d(n / FsDoc, y(1, 1:K));
xtitle("Dang song trong 10 ms dau", "Thoi gian (s)", "Bien do");
playsnd(y, FsDoc);
