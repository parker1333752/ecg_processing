accx0 = mean(accx(1:2000));
accy0 = mean(accy(1:2000));
accz0 = mean(accz(1:2000));

acc(1,:) = accx' - accx0;
acc(2,:) = accy' - accy0;
acc(3,:) = accz' - accz0;

fun1 = @(x) -sum(abs([cos(x(1))*cos(x(2)),cos(x(1))*sin(x(2)),sin(x(1))] * acc));
% optimtool('ga')

% Best value of x, result from genetic algorithm.
x = [-0.34524283644330667	0.9033140780572351];
% 0.34526372669928707	4.044902917801239];
x = [cos(x(1))*cos(x(2)),cos(x(1))*sin(x(2)),sin(x(1))];

s = x*acc;
angle = acos(abs(s./sqrt([1,1,1]*(acc.*acc)))) * 180/pi;

acc1 = s;
addpath([pwd,'/fastICA']);
acc1 = (acc1-mean(acc1));%/std(acc1);
ecg1 = (ecg_f-mean(ecg_f));%/std(ecg_f);
ecg1 = ecg1';
% s = fastica([acc1;ecg1]); % a useless trial ...
