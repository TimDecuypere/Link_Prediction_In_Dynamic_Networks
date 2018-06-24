clear all
beep off
close all

%%% Data prep employees %%%

filename='ia-contacts_dublin.txt';
M=readtable(filename);
A = round(table2array(M));
A = sortrows(A,3);
B = A(78666:324767,:); %% select range (manually found indices)
dlmwrite('ia-contacts_dublin-may11-jul5-2009.txt',B, 'precision','%.f')

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



w1 = B(1:(w_index(1)-1),:);
w2 = B(w_index(1):(w_index(2)-1),:);
w3 = B(w_index(2):(w_index(3)-1),:);
w4 = B(w_index(3):(w_index(4)-1),:);
w5 = B(w_index(4):(w_index(5)-1),:);
w6 = B(w_index(5):(w_index(6)-1),:);
w7 = B(w_index(6):(w_index(7)-1),:);
w8 = B(w_index(7):length(B),:);
w17 = B(1:(w_index(7)- 1), : );

dlmwrite('ia-contacts_dublin-w1.txt',w1, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w2.txt',w2, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w3.txt',w3, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w4.txt',w4, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w5.txt',w5, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w6.txt',w6, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w7.txt',w7, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w8.txt',w8, 'precision','%.f')
dlmwrite('ia-contacts_dublin-w17.txt', w17, 'precision', '%.f')

%figure
%histogram(yMonth)
%xlabel('Month histogram facebook forum');

figure
histogram(yWeek);
xlabel('Week histogram facebook forum');
