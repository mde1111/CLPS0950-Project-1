pixels_per_um = 10.91;
%um_length = pixel_length / pixels_per_um; % Convert length in pixels to um

axon_terminal = imread('MAX_021421_animalFB_40x_01-1.tif',2);
muscle_endplate = imread('MAX_021421_animalFB_40x_01-1.tif',1);
imshow(axon_terminal);
axon_thresh = graythresh(axon_terminal);
axon_med = medfilt2(axon_terminal);
axon_thresh = graythresh(axon_terminal);
bw_axon = imbinarize(axon_med, axon_thresh);
axon_filt = medfilt2(bw_axon);
axon_filt_2 = wiener2(axon_filt,[5 5]);
imshow(axon_filt_2);
axon_area = bwarea(axon_filt_2);
axon_area_um2 = axon_area / (pixels_per_um^2);
axon_perim_img = bwperim(axon_filt_2);
axon_perim = sum(axon_perim_img(:));
axon_perim_um = axon_perim / pixels_per_um;
disp(axon_area_um2);
disp(axon_perim_um);

imshow(muscle_endplate);
endplate_thresh = graythresh(muscle_endplate);
endplate_med = medfilt2(muscle_endplate);
endplate_thresh = graythresh(muscle_endplate);
bw_endplate = imbinarize(endplate_med, endplate_thresh);
endplate_filt = medfilt2(bw_endplate);
endplate_filt_2 = wiener2(endplate_filt,[5 5]);
imshow(endplate_filt_2);
endplate_area = bwarea(endplate_filt_2);
endplate_perim = bwperim(endplate_filt_2);
endplate_area_um2 = endplate_area / (pixels_per_um^2);
endplate_perim_img = bwperim(endplate_filt_2);
endplate_perim = sum(endplate_perim_img(:));
endplate_perim_um = endplate_perim / pixels_per_um;
disp(endplate_area_um2);
disp(endplate_perim_um);
