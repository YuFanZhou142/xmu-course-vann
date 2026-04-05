function visual_compare(original, restored)
% 可视化对比：原图 vs 处理图像
% 输入图像需为 RGB double 格式，范围 [0,1]

%% 1. 直方图对比（RGB）
figure('Name','RGB直方图对比');
colors = {'Red', 'Green', 'Blue'};
for c = 1:3
    subplot(3,2,(c-1)*2+1);
    imhist(original(:,:,c));
    title(['原图 - ', colors{c}]);

    subplot(3,2,(c-1)*2+2);
    imhist(restored(:,:,c));
    title(['恢复图 - ', colors{c}]);
end

%% 2. 差异图
figure('Name','差异热力图');
diff_img = abs(rgb2gray(original) - rgb2gray(restored));
imshow(diff_img, []);
colormap hot; colorbar;
title('原图与恢复图差异热力图');

%% 3. 边缘图对比
figure('Name','边缘结构对比');
edge1 = edge(rgb2gray(original), 'sobel');
edge2 = edge(rgb2gray(restored), 'sobel');
subplot(1,2,1); imshow(edge1); title('原图边缘结构');
subplot(1,2,2); imshow(edge2); title('恢复图边缘结构');

%% 4. 三通道像素强度分布对比
figure('Name','三通道像素强度分布对比');
for c = 1:3
    subplot(3,1,c);
    temp_ori = original(:,:,c);
    ori_sorted = sort(temp_ori(:));
    temp_res = restored(:,:,c);
    res_sorted = sort(temp_res(:));
    plot(ori_sorted, 'r'); hold on;
    plot(res_sorted, 'b');
    title(['通道 ', colors{c}, ' 像素强度分布']);
    legend('原图','恢复图');
end
