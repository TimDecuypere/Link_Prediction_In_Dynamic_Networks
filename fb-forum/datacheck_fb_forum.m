clear all
beep off
close all

filename='fb-forum.txt';
M=readtable(filename);
A = table2array(M);
dt = datetime( round(A(:,3)), 'ConvertFrom', 'posixtime' );

yMonth = discretize(dt,'month','categorical');
figure
histogram(yMonth)
xlabel('Month histogram facebook forum');

yWeek = discretize(dt,'week','categorical');
figure
histogram(yWeek);
xlabel('Week histogram facebook forum');
