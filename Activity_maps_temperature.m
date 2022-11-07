%% Correlation coefficient 
clc
clear 
close all

img_cold = double(imread('1.bmp'));
avrI0 = mean(mean(img_cold));
[height, width] = size(img_cold);


input_folder_path = "D:\Experimental data\turned off PCB\"; 

image_files = dir(strcat(input_folder_path, '*.bmp'));
nfiles = length(image_files);
result = zeros(nfiles);
for n=1:nfiles
    img_name = strcat(int2str(n), '.bmp');
    img_path = strcat(input_folder_path, img_name);
    img_hot = double(imread(img_path));    
    avrI_hot = mean(mean(img_hot));
        
    sum_numerator = 0;
    sum_denominator_left = 0;
    sum_denominator_right = 0;
    for i=1:height
        for j=1:width
            numerator = (img_cold(i,j)-avrI0)*(img_hot(i,j)-avrI_hot);
            sum_numerator = sum_numerator + numerator;
            denominator_left = (img_cold(i,j)-avrI0)^2;
            sum_denominator_left = sum_denominator_left + denominator_left;
            denominator_right = (img_hot(i,j)-avrI_hot)^2;
            sum_denominator_right = sum_denominator_right + denominator_right;
            result(n) = 1 - sum_numerator/sqrt(sum_denominator_left*sum_denominator_right);        
        end
    end
end
plot(result);

xlabel('Image number');
ylabel('Correlation coefficient')
%% Difference 
clc
clear 
close all

img_cold = double(imread('1.bmp'));
avrI0 = mean(mean(img_cold));
[height, width] = size(img_cold);

input_folder_path = "D:\Experimental data\turned off PCB\"; 

image_files = dir(strcat(input_folder_path, '*.bmp'));
nfiles = length(image_files);
result = zeros(nfiles);
for n=1:nfiles
    img_name = strcat(int2str(n), '.bmp');
    img_path = strcat(input_folder_path, img_name);
    img_hot = double(imread(img_path));    
    result(n) = mean(mean(abs(img_cold-img_hot)));      
   
end
plot(result);
xlabel('Image number');
ylabel('Difference coefficient')
%%
clc
clear 
close all

img_cold = double(imread('1.bmp'));
avrI0 = mean(mean(img_cold));
[height, width] = size(img_cold);

input_folder_path = "D:\Experimental data\turned off PCB\"; 

image_files = dir(strcat(input_folder_path, '*.bmp'));

img_path = strcat(input_folder_path, '2.bmp');
img_hot = double(imread(img_path));    
result1 = abs(img_cold-img_hot);

img_path = strcat(input_folder_path, '100.bmp');
img_hot = double(imread(img_path));    
result2 = abs(img_cold-img_hot);

img_path = strcat(input_folder_path, '200.bmp');
img_hot = double(imread(img_path));    
result3 = abs(img_cold-img_hot);

value_range = [0 30];

imshow(result1, "Colormap", turbo, 'DisplayRange', value_range, 'Border', 'tight');
colorbar;
title(sprintf('Cold Board. M.V. = %.2f', mean(mean(result1))))
figure;
imshow(result2, "Colormap", turbo, 'DisplayRange', value_range, 'Border', 'tight');
colorbar;
title(sprintf('Warm Board. M.V. = %.2f', mean(mean(result2))))

figure;
imshow(result3, "Colormap", turbo, 'DisplayRange', value_range, 'Border', 'tight');
colorbar;
title(sprintf('Hot Board. M.V. = %.2f', mean(mean(result3))))
