function morphwavelet_gui()
    % 创建界面窗口
    fig = uifigure('Name', '图像去噪与小波压缩演示系统', 'Position', [200 100 1000 600], 'Color', [1 1 1]);

    % 加载原始图像
    I = imread('Xiamen_University.jpg');
    I = im2double(I);

    % 图像预处理
    noisy = I;
    for c = 1:3
        noisy(:,:,c) = imnoise(I(:,:,c), 'salt & pepper', 0.1);
    end
    denoised = morph_denoise(noisy);
    coeffs = cell(1,3); S = cell(1,3); recon = zeros(size(I));
    for c = 1:3
        [~, coeffs{c}, S{c}] = wavelet_compress(denoised(:,:,c), 'haar', 2, 0.05);
        recon(:,:,c) = wavelet_reconstruct(coeffs{c}, S{c}, 'haar');
    end

    % 左侧图像显示（原图）
    ax1 = uiaxes(fig, 'Position', [80 280 360 280]);
    imshow(I, 'Parent', ax1);
    title(ax1, '原始图像');

    % 右侧图像显示（处理结果）
    ax2 = uiaxes(fig, 'Position', [560 280 360 280]);
    imshow(I, 'Parent', ax2);
    title(ax2, '处理结果');

    % 按钮通用样式
    btn_w = 120; btn_h = 40;
    base_x = 120; step_x = 160; base_y = 190; step_y = 60;

    % 按钮布局（2列）
    uibutton(fig, 'Text', '显示原始图像', 'Position', [base_x base_y btn_w btn_h], ...
        'FontSize', 14, 'ButtonPushedFcn', @(btn,event) imshow(I, 'Parent', ax2));

    uibutton(fig, 'Text', '加噪图像', 'Position', [base_x base_y - step_y btn_w btn_h], ...
        'FontSize', 14, 'ButtonPushedFcn', @(btn,event) imshow(noisy, 'Parent', ax2));

    uibutton(fig, 'Text', '去噪图像', 'Position', [base_x + step_x base_y btn_w btn_h], ...
        'FontSize', 14, 'ButtonPushedFcn', @(btn,event) imshow(denoised, 'Parent', ax2));

    uibutton(fig, 'Text', '压缩后图像', 'Position', [base_x + step_x base_y - step_y btn_w btn_h], ...
        'FontSize', 14, 'ButtonPushedFcn', @(btn,event) imshow(recon, 'Parent', ax2));

    uibutton(fig, 'Text', '退出系统', 'Position', [860 40 100 30], ...
        'FontSize', 12, 'ButtonPushedFcn', @(btn,event) close(fig));
end
