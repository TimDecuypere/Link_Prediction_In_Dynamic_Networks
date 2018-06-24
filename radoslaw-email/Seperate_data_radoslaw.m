clear all
beep off
close all

%%% Data prep employees %%%

filename='ia-radoslaw-email.txt';
M=readtable(filename);
B = round(table2array(M));
%B = A(1002:49557,:); %% select range (manually found indices)
dlmwrite('ia-radoslaw-email-jan-02-2010-sep-30-2010.txt',B, 'precision','%.f')

dt = datetime( B(:,4), 'ConvertFrom', 'posixtime' );
yMonth = discretize(dt,'month','categorical');
%yWeek = discretize(dt,'week','categorical');
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
% index_start=1;
% w_index = [];
% i=1;
% while (yWeek(index_start) ~= yWeek(length(yWeek)))
%     w_index = [w_index, find(yWeek > yWeek(index_start),1)];
%     index_start = w_index(i);
%     i=i+1;
% end


m1 = B(1:(m_index(1)-1),:);
m2 = B(m_index(1):(m_index(2)-1),:);
m3 = B(m_index(2):(m_index(3)-1),:);
m4 = B(m_index(3):(m_index(4)-1),:);
m5 = B(m_index(4):(m_index(5)-1),:);
m6 = B(m_index(5):(m_index(6)-1),:);
m7 = B(m_index(6):(m_index(7)-1),:);
m8 = B(m_index(7):(m_index(8)-1),:);
m9 = B(m_index(8):length(B),:);
m18 = B(1: (m_index(8) - 1), :);


dlmwrite('ia-radoslaw-email-m1.txt',m1, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m2.txt',m2, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m3.txt',m3, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m4.txt',m4, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m5.txt',m5, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m6.txt',m6, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m7.txt',m7, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m8.txt',m8, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m9.txt',m9, 'precision','%.f')
dlmwrite('ia-radoslaw-email-m18.txt', m18, 'precision', '%.f')

figure
histogram(yMonth)
xlabel('Month histogram facebook forum');

% figure
% histogram(yWeek);
% xlabel('Week histogram facebook forum');
