function Archive = MOGWO(CostFunction, nVar, VarMin, VarMax, MaxIt, nPop, nArchive)

    % KHỞI TẠO
    GreyWolves = CreateWolves(nPop, nVar, VarMin, VarMax);
    
    % Đánh giá ban đầu
    GreyWolves = EvaluateWolves(GreyWolves, CostFunction);
    
    % Khởi tạo Archive
    Archive = GetNonDominatedParticles(GreyWolves);
    
    % VÒNG LẶP CHÍNH
    for it = 1:MaxIt
        a = 2 - it * ((2) / MaxIt); % Giảm a từ 2 về 0
        
        for i = 1:nPop
            % Chọn Leader từ Archive
            if numel(Archive) < 3
                Alpha = SelectLeader(Archive);
                Beta  = SelectLeader(Archive);
                Delta = SelectLeader(Archive);
            else
                indices = randperm(numel(Archive), 3);
                Alpha = Archive(indices(1));
                Beta  = Archive(indices(2));
                Delta = Archive(indices(3));
            end
            
            % Cập nhật vị trí
            GreyWolves(i).Position = UpdatePosition(GreyWolves(i).Position, ...
                Alpha.Position, Beta.Position, Delta.Position, a, VarMin, VarMax);
        end
        
        % Đánh giá lại
        GreyWolves = EvaluateWolves(GreyWolves, CostFunction);
        
        % Cập nhật Archive
        Archive = [Archive; GreyWolves]; 
        Archive = GetNonDominatedParticles(Archive);
        
        % Xử lý tràn Archive (Xóa ngẫu nhiên đơn giản)
        if numel(Archive) > nArchive
            nRemove = numel(Archive) - nArchive;
            toRemove = randperm(numel(Archive), nRemove);
            Archive(toRemove) = [];
        end
        
        % Hiển thị tiến độ (Optional)
        if mod(it, 50) == 0
            disp(['MOGWO Iteration ' num2str(it) ': Archive Size = ' num2str(numel(Archive))]);
        end
    end
end

% CÁC HÀM PHỤ TRỢ BÊN TRONG MOGWO
function wolves = CreateWolves(nPop, nVar, Min, Max)
    empty_wolf.Position = [];
    empty_wolf.Cost = [];
    wolves = repmat(empty_wolf, nPop, 1);
    for i = 1:nPop
        wolves(i).Position = unifrnd(Min, Max, [1 nVar]);
    end
end

function wolves = EvaluateWolves(wolves, CostFunc)
    for i = 1:numel(wolves)
        wolves(i).Cost = CostFunc(wolves(i).Position);
    end
end

function x_new = UpdatePosition(current, alpha, beta, delta, a, Min, Max)
    r1 = rand(size(current)); r2 = rand(size(current));
    A1 = 2*a*r1 - a; C1 = 2*r2;
    D_alpha = abs(C1 .* alpha - current);
    X1 = alpha - A1 .* D_alpha;
    
    r1 = rand(size(current)); r2 = rand(size(current));
    A2 = 2*a*r1 - a; C2 = 2*r2;
    D_beta = abs(C2 .* beta - current);
    X2 = beta - A2 .* D_beta;
    
    r1 = rand(size(current)); r2 = rand(size(current));
    A3 = 2*a*r1 - a; C3 = 2*r2;
    D_delta = abs(C3 .* delta - current);
    X3 = delta - A3 .* D_delta;
    
    x_new = (X1 + X2 + X3) / 3;
    x_new = max(x_new, Min);
    x_new = min(x_new, Max);
end

function nd_pop = GetNonDominatedParticles(pop)
    n = numel(pop);
    costs = vertcat(pop.Cost);
    domination = false(n, 1);
    for i = 1:n
        for j = i+1:n
            if all(costs(i,:) <= costs(j,:)) && any(costs(i,:) < costs(j,:))
                domination(j) = true;
            elseif all(costs(j,:) <= costs(i,:)) && any(costs(j,:) < costs(i,:))
                domination(i) = true;
            end
        end
    end
    nd_pop = pop(~domination);
end

function leader = SelectLeader(archive)
    idx = randi(numel(archive));
    leader = archive(idx);
end
