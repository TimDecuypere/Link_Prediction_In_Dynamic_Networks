clear all
beep off
close all

%%% Data prep employees %%%

filename='fb-forum.txt';
M=readtable(filename);
A = round(table2array(M));
%B = A(1:1237867,:); %% select range (manually found indices)
%dlmwrite('fb-forum-oct-may2004.txt',A, 'precision','%.f')

dt = datetime( A(:,3), 'ConvertFrom', 'posixtime' );
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


m1 = A(1:(m_index(1)-1),1:2);
m2 = A(m_index(1):(m_index(2)-1),1:2);
m3 = A(m_index(2):(m_index(3)-1),1:2);
m4 = A(m_index(3):(m_index(4)-1),1:2);
m5 = A(m_index(4):(m_index(5)-1),1:2);
m6 = A(m_index(5):(length(A)),1:2);

m15 = vertcat(m1, m2, m3, m4, m5);


%dlmwrite('fb-forum-m1.csv',m1, 'precision','%.f','delimiter',',')
%dlmwrite('fb-forum-m2.csv',m2, 'precision','%.f','delimiter',',')
%dlmwrite('fb-forum-m3.csv',m3, 'precision','%.f','delimiter',',')
%dlmwrite('fb-forum-m4.csv',m4, 'precision','%.f','delimiter',',')
%dlmwrite('fb-forum-m5.csv',m5, 'precision','%.f','delimiter',',')
%dlmwrite('fb-forum-m6.csv',m6, 'precision','%.f','delimiter',',')
dlmwrite('fb-forum-m15.csv',m15,'precision','%.f','delimiter',',') 



% figure
% histogram(yMonth)
% xlabel('Month histogram facebook forum');
% 
% figure
% histogram(yWeek);
% xlabel('Week histogram facebook forum');
