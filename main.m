clc;
clear;
close all;

%Cấu hình bài toán
CostFunction = @ZDT1;  % Gọi file ZDT1.m
nVar = 30;             % Số biến
VarMin = 0;            % Cận dưới
VarMax = 1;            % Cận trên

%Cấu hình thuật toán MOGWO
MaxIt = 200;           % Số vòng lặp
nPop = 100;            % Số lượng sói
nArchive = 100;        % Dung lượng Archive

%Chạy thuật toán
fprintf('Đang chạy MOGWO cho bài toán ZDT1...\n');
Archive = MOGWO(CostFunction, nVar, VarMin, VarMax, MaxIt, nPop, nArchive);

%Vẽ kết quả
costs = vertcat(Archive.Cost);

figure;
plot(costs(:,1), costs(:,2), 'ro', 'MarkerFaceColor', 'r'); hold on;

% Vẽ đường True PF (Lý thuyết) để so sánh
x_true = linspace(0, 1, 100);
y_true = 1 - sqrt(x_true);
plot(x_true, y_true, 'b-', 'LineWidth', 2);

title('Kết quả MOGWO - ZDT1');
xlabel('f1'); ylabel('f2');
legend('MOGWO Archive', 'True PF');
grid on;
