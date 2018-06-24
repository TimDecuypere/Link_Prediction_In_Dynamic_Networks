clear all
beep off
close all

%%% Data prep employees %%%

filename='ia-reality-call.txt';
M=readtable(filename);
A = round(table2array(M));
A = sortrows(A,3);
B = A(1544:50123,:); %% select range (manually found indices)
dlmwrite('ia-reality-call-sep27-2004-jan2-2005.txt',B(:,1:3), 'precision','%.f')

dt = datetime( B(:,3), 'ConvertFrom', 'posixtime' );
%yMonth = discretize(dt,'month','categorical');
yWeek = discretize(dt,'week','categorical');

%%%% Find month indices
% index_start=1;
% m_index = [];
% i=1;
% while (yMonth(index_start) ~= yMonth(length(yMonth)))
%     m_index = [m_index, find(yMonth > yMonth(index_start),1)];
%     index_start = m_index(i);
%     i=i+1;
% end
% 

%%%% Find week indices
index_start=1;
w_index = [];
i=1;
while (yWeek(index_start) ~= yWeek(length(yWeek)))
    w_index = [w_index, find(yWeek > yWeek(index_start),1)];
    index_start = w_index(i);
    i=i+1;
end



w12 = B(1:(w_index(2)-1),:);
w34 = B(w_index(2):(w_index(4)-1),:);
w56 = B(w_index(4):(w_index(6)-1),:);
w78 = B(w_index(6):(w_index(8)-1),:);
w910 = B(w_index(8):(w_index(10)-1),:);
w1112 = B(w_index(10):(w_index(12)-1),:);
w1314 = B(w_index(12):length(B),:);
w112 = B(1 : (w_index(12) - 1), :);


dlmwrite('ia-reality-call-w12.txt',w12, 'precision','%.f')
dlmwrite('ia-reality-call-w34.txt',w34, 'precision','%.f')
dlmwrite('ia-reality-call-w56.txt',w56, 'precision','%.f')
dlmwrite('ia-reality-call-w78.txt',w78, 'precision','%.f')
dlmwrite('ia-reality-call-w910.txt',w910, 'precision','%.f')
dlmwrite('ia-reality-call-w1112.txt',w1112, 'precision','%.f')
dlmwrite('ia-reality-call-w1314.txt',w1314, 'precision','%.f')
dlmwrite('ia-reality-call-w112.txt', w112, 'precision', '%.f')



%figure
%histogram(yMonth)
%xlabel('Month histogram facebook forum');

figure
histogram(yWeek);
xlabel('Week histogram facebook forum');
