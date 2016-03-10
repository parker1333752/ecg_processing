accx0 = mean(accx(1:2000));
accy0 = mean(accy(1:2000));
accz0 = mean(accz(1:2000));
acc(1,:) = accx' - accx0;
acc(2,:) = accy' - accy0;
acc(3,:) = accz' - accz0;

%% 寻找ACC值变化最剧烈的方向的最优化函数
fun1 = @(x) -sum(abs([cos(x(1))*cos(x(2)),cos(x(1))*sin(x(2)),sin(x(1))] * acc));
% optimtool('ga') %该函数能打开遗传算法工具，求出使func1最优的x解。(Setting as ga.png)

% Best value of x, result from genetic algorithm.
x = [-0.001 3.101];
x = [cos(x(1))*cos(x(2)),cos(x(1))*sin(x(2)),sin(x(1))];


%% s为加速度值矢量投影到x方向的取值，angle为加速度值矢量与x方向的夹角
s = x*acc;
angle = acos(abs(s./sqrt([1,1,1]*(acc.*acc)))) * 180/pi;


%% 归一化以后的加速度值与ecg值进行ICA分离
acc1 = s;
addpath([pwd,'/fastICA']);
acc1 = (acc1-mean(acc1))/std(acc1);
ecg1 = (ecg_f-mean(ecg_f))/std(ecg_f);
ecg1 = ecg1';
out = fastica([acc1;ecg1]); 
