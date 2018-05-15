function [k,C] = DBSCAN(iris)
%D = rand(2, 30);                       %������

eps = 0.2;                            %�������
MinPts = 5;                            %�������
O = zeros(1, size(iris, 2));              %���Ķ���
C = cell(size(iris,2));

d = zeros(size(iris, 2), size(iris, 2));     %����֮��ľ������epsԪ��ֵΪ1����֮0
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

k =  0;                                %��ʼ���������
Tau = 1:size(iris, 2);                    %��ʼ��δ������������
while sum(O) ~= 0
    Tau_old = Tau;                     %��¼��ǰδ������������

    %���ѡȡһ�����Ķ���j,�ҳ����ܶȿɴ��
    j = 1;
    while O(j) == 0
        j = j+1;
    end

    %ob = O(j);
    Q = zeros(1, size(Tau, 2));
    Q(j) = j;                          %�����Ķ���j�������Q
    Tau(j) = 0;                        %�����Ķ���j�Ƴ�Tau

    while sum(Q) ~= 0

        %ȡ��Q���׸�����m
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