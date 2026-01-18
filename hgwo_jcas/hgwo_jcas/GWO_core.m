function [Best_score, Best_pos] = GWO_core(SearchAgents, MaxIter, lb, ub, dim, fobj)

    Positions = rand(SearchAgents,dim).*(ub-lb)+lb;

    Alpha_pos=zeros(1,dim); Alpha_score=inf;
    Beta_pos=zeros(1,dim);  Beta_score=inf;
    Delta_pos=zeros(1,dim); Delta_score=inf;

    for t = 1:MaxIter
        for i = 1:SearchAgents
            Positions(i,:) = max(min(Positions(i,:),ub),lb);
            fitness = fobj(Positions(i,:));

            if fitness < Alpha_score
                Alpha_score = fitness; Alpha_pos = Positions(i,:);
            elseif fitness < Beta_score
                Beta_score = fitness; Beta_pos = Positions(i,:);
            elseif fitness < Delta_score
                Delta_score = fitness; Delta_pos = Positions(i,:);
            end
        end

        a = 2 - 2*t/MaxIter;

        for i = 1:SearchAgents
            for j = 1:dim
                r1=rand(); r2=rand();
                A1=2*a*r1-a; C1=2*r2;
                D1=abs(C1*Alpha_pos(j)-Positions(i,j));
                X1=Alpha_pos(j)-A1*D1;

                r1=rand(); r2=rand();
                A2=2*a*r1-a; C2=2*r2;
                D2=abs(C2*Beta_pos(j)-Positions(i,j));
                X2=Beta_pos(j)-A2*D2;

                r1=rand(); r2=rand();
                A3=2*a*r1-a; C3=2*r2;
                D3=abs(C3*Delta_pos(j)-Positions(i,j));
                X3=Delta_pos(j)-A3*D3;

                Positions(i,j) = (X1+X2+X3)/3;
            end
        end
    end

    Best_score = Alpha_score;
    Best_pos = Alpha_pos;
end