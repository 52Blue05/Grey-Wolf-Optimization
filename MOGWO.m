function pareto = MOGWO(fh, nVar, VarMin, VarMax, nPop, MaxIt)

X = rand(nPop, nVar) * (VarMax - VarMin) + VarMin;
F = zeros(nPop, 2);

for i = 1:nPop
    F(i,:) = fh(X(i,:));
end

% Sắp xếp để chọn Alpha, Beta, Delta theo phương pháp Non-Dominated Sorting
Rank = NDSort(F);

Alpha = X(Rank==1,:); 
AlphaF = F(Rank==1,:);

if size(Alpha,1) > 3
    Alpha = Alpha(1:3,:);
    AlphaF = AlphaF(1:3,:);
end

a = 2; 

for it = 1:MaxIt
    for i = 1:nPop
        A = 2*a*rand(3,1) - a;
        C = 2*rand(3,1);

        for k = 1:3
            D = abs(C(k)*Alpha(k,:) - X(i,:));
            Xk(k,:) = Alpha(k,:) - A(k).*D;
        end

        X(i,:) = mean(Xk,1);

        X(i,:) = max(min(X(i,:), VarMax), VarMin);

        F(i,:) = fh(X(i,:));
    end

    Rank = NDSort(F);
    
    Alpha = X(Rank==1,:);
    AlphaF = F(Rank==1,:);

    if size(Alpha,1) > 3
        Alpha = Alpha(1:3,:);
        AlphaF = AlphaF(1:3,:);
    end
    
    a = a - 2/MaxIt;

end

pareto = F(Rank==1,:); 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Non-Dominated Sorting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Rank = NDSort(F)

n = size(F,1);
Rank = zeros(n,1);

for i = 1:n
    dominated = false;
    for j = 1:n
        if all(F(j,:) <= F(i,:)) && any(F(j,:) < F(i,:))
            dominated = true;
            break;
        end
    end
    if ~dominated
        Rank(i) = 1;
    else
        Rank(i) = 2;
    end
end
end
