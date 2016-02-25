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
dist = L2_distance(B,B,1); %求距离矩阵
toc
[sdist,index]=sort(dist,2);
%自适应K的算法部分
sdist2=sort(sdist(:,2));                %对一近邻又小到大进行排序
%---加入去噪部分内容---%
flag=0;
r=1;
nb=zeros(1,N);                          %自然邻居个数
%NNN=zeros(N,N);                        %各点的自然邻居集
while flag==0
    mdist=sdist2(end-(r-1));            %求出一近邻中距离最大的边
    [d,num]=ismember(mdist,sdist(:,2)); %查找最大距离在距离矩阵中的行数num
    c=index(num,2);                     %第num行的第一近邻的序号
    [d1,e]=ismember(num,index(c,:));    %在最离群点的自然近邻中找到其属于几近邻
    K=e-1                               %自适应出来的K值
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
max_nb=max(nb)                          %自然邻居的最大数目
min_nb=min(nb)                          %自然邻居的最小数目
%去噪部分
%   for i=1:N
%       if nb(i)==0
%           r=r+1;
%        end
%   end
%画最近领域图
%axis([1,7,1,7]);
for i=1:K
    for j=1:N
        k=index(j,i+1);
        plot([x(j);x(k)],[y(j);y(k)],'.-');
    end
end
hold off
title(strcat('k最近邻域图,k=',num2str(K)));
end