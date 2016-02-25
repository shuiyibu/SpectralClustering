function NN(A)
figure();
hold on
[N,dim]=size(A);
B=A';
% x=A(:,1);
% y=A(:,2);
x=B(1,:);
y=B(2,:);
% dist=zeros(N,N);
% for i=1:N
%     for j=1:N
%         dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
%     end
% end
tic;
dist = L2_distance(B,B,1); %��������
toc
[sdist,index]=sort(dist,2);
%����ӦK���㷨����
sdist2=sort(sdist(:,2));                %��һ������С�����������
%---����ȥ�벿������---%
flag=0;
r=1;
nb=zeros(1,N);                          %��Ȼ�ھӸ���
%NNN=zeros(N,N);                        %�������Ȼ�ھӼ�
while flag==0
    mdist=sdist2(end-(r-1));            %���һ�����о������ı�
    [d,num]=ismember(mdist,sdist(:,2)); %�����������ھ�������е�����num
    c=index(num,2);                     %��num�еĵ�һ���ڵ����
    [d1,e]=ismember(num,index(c,:));    %������Ⱥ�����Ȼ�������ҵ������ڼ�����
    K=e-1                               %����Ӧ������Kֵ
    for i=1:N
        for z=1:K
            m=index(i,r+z);
            nb(m)=nb(m)+1;
        end
    end
    if nb~=0&K<30
        flag=1;
    else  r=r+1
    end
end
max_nb=max(nb)                          %��Ȼ�ھӵ������Ŀ
min_nb=min(nb)                          %��Ȼ�ھӵ���С��Ŀ
%ȥ�벿��
%   for i=1:N
%       if nb(i)==0
%           r=r+1;
%        end
%   end
%���������ͼ
%axis([1,7,1,7]);
for i=1:K
    for j=1:N
        k=index(j,i+1);
        plot([x(j);x(k)],[y(j);y(k)],'.-');
    end
end
hold off
title(strcat('k�������ͼ,k=',num2str(K)));
end