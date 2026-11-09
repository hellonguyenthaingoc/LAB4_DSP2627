atomsLoad("IPCV");

I = imread("anh.jpg");
H = ones(21, 21) / (21 * 21);
I_mo = imfilter(I, H);

scf(2);
clf();
imshow(I);
xtitle("Anh goc");

scf(3);
clf();
imshow(I_mo);
xtitle("Anh sau khi loc trung binh 5 x 5");
