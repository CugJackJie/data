function [k,C] = DBSCAN(iris)
%D = rand(2, 30);                       %样本集

eps = 0.2;                            %邻域参数
MinPts = 5;                            %领域参数
O = zeros(1, size(iris, 2));              %核心对象集
C = cell(size(iris,2));

d = zeros(size(iris, 2), size(iris, 2));     %样本之间的距离大于eps元素值为1，反之0
for i = 1:size(iris, 2)
    for j = size(iris, 2):-1:i
        if pdist(iris(:, [i j])') <= eps
            d(i, j) = 1;
        end
        d(j, i) = d(i, j);
    end
    %d(i,i) = 0;
    if sum(d(i, :)) >= MinPts
            O(i) = i;
    end
end

k =  0;                                %初始化聚类簇数
Tau = 1:size(iris, 2);                    %初始化未访问样本集合
while sum(O) ~= 0
    Tau_old = Tau;                     %记录当前未访问样本集合

    %随机选取一个核心对象j,找出其密度可达点
    j = 1;
    while O(j) == 0
        j = j+1;
    end

    %ob = O(j);
    Q = zeros(1, size(Tau, 2));
    Q(j) = j;                          %将核心对象j加入队列Q
    Tau(j) = 0;                        %将核心对象j移出Tau

    while sum(Q) ~= 0

        %取出Q中首个样本m
        m = 1;
        while Q(m) == 0
            m = m+1;
        end
        Q(m) = 0;

        if sum(d(m,:)) >= MinPts
            for l = 1:size(d, 2)
                if d(m, l) == 1 && Tau(l) ~= 0
                    Q(l) = l;
                    Tau(l) = 0;
                end
            end
        end

    end
    k = k+1;
    for i = 1:size(Tau, 2)
        if Tau(i) ~= 0
            Tau_old(i) = 0;
        end
        if Tau_old(i) ~= 0
            O(i) =0;
        end
    end
    C{k} = Tau_old;
end

for i = 1:k
    C{i} = find(C{i}~=0);
    C{i}
    D1 = iris(:,C{i});
    scatter(D1(1,:),D1(2,:));
    hold on
end