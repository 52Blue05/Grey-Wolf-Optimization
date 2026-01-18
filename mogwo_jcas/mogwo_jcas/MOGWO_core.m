function Archive = MOGWO_core(N, MaxIter, lb, ub, dim, fobj)

    Positions = rand(N,dim).*(ub-lb)+lb;
    Archive = struct('pos',{},'cost',{});

    for t = 1:MaxIter
        for i = 1:N
            Positions(i,:) = max(min(Positions(i,:),ub),lb);
            cost = fobj(Positions(i,:));

            Archive = updateArchive(Archive, Positions(i,:), cost);
        end

        a = 2 - 2*t/MaxIter;
        leader = Archive(randi(numel(Archive))).pos;

        for i = 1:N
            r1 = rand(1,dim); r2 = rand(1,dim);
            A = 2*a*r1 - a;
            C = 2*r2;
            D = abs(C.*leader - Positions(i,:));
            Positions(i,:) = leader - A.*D;
        end
    end
end
