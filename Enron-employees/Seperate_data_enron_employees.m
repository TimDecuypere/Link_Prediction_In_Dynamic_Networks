clear all
beep off
close all

%%% Data prep employees %%%

filename='ia-enron-employees.txt';
M=readtable(filename);
A = round(table2array(M));
B = A(1002:49557,:); %% select range (manually found indices)
%dlmwrite('ia-enron-employees-feb2002-2004.txt',B, 'precision','%.f')

dt = datetime( B(:,4), 'ConvertFrom', 'posixtime' );
yMonth = discretize(dt,'month','categorical');
yWeek = discretize(dt,'week','categorical');
%%%% Find month indices
index_start=1;
m_index = [];
i=1;
while (yMonth(index_start) ~= yMonth(length(yMonth)))
    m_index = [m_index, find(yMonth > yMonth(index_start),1)];
    index_start = m_index(i);
    i=i+1;
end

%%%% Find week indices
index_start=1;
w_index = [];
i=1;
while (yWeek(index_start) ~= yWeek(length(yWeek)))
    w_index = [w_index, find(yWeek > yWeek(index_start),1)];
    index_start = w_index(i);
    i=i+1;
end


m13 = B(1:(m_index(3)-1),:);
m46 = B(m_index(3):(m_index(6)-1),:);
m79 = B(m_index(6):(m_index(9)-1),:);
m1012 = B(m_index(9):(m_index(12)-1),:);
m1315 = B(m_index(12):(m_index(15)-1),:);
m1618 = B(m_index(15):(m_index(18)-1),:);
m1921 = B(m_index(18):(m_index(21)-1),:);
m2224 = B(m_index(21):length(B),:);

dlmwrite('ia-enron-employees-m13.txt',m13, 'precision','%.f')
dlmwrite('ia-enron-employees-m46.txt',m46, 'precision','%.f')
dlmwrite('ia-enron-employees-m79.txt',m79, 'precision','%.f')
dlmwrite('ia-enron-employees-m1012.txt',m1012, 'precision','%.f')
dlmwrite('ia-enron-employees-m1315.txt',m1315, 'precision','%.f')
dlmwrite('ia-enron-employees-m1618.txt',m1618, 'precision','%.f')
dlmwrite('ia-enron-employees-m1921.txt',m1921, 'precision','%.f')
dlmwrite('ia-enron-employees-m2224.txt',m2224, 'precision','%.f')

% figure
% histogram(yMonth)
% xlabel('Month histogram facebook forum');
% 
% figure
% histogram(yWeek);
% xlabel('Week histogram facebook forum');
