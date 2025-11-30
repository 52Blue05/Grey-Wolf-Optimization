clc; clear; close all;

nVar = 30;            % số biến theo chuẩn ZDT1
VarMin = 0;          
VarMax = 1;

nPop = 50;            % số lượng sói
MaxIt = 200;          % vòng lặp

disp('Running MOGWO on ZDT1 ...');

pareto = MOGWO(@ZDT1, nVar, VarMin, VarMax, nPop, MaxIt);

% Vẽ Pareto Front
figure;
plot(pareto(:,1), pareto(:,2), 'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b');
xlabel('f1'); ylabel('f2');
title('Pareto Front - MOGWO on ZDT1');
grid on;
