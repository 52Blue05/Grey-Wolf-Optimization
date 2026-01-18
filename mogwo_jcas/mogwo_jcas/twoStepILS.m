function W = twoStepILS(maxIter, alpha, A, W0, PM, PdM)
% MOGWO-based beamforming (drop-in replacement)

    M = size(A,1);
    lb = -pi * ones(1,M);
    ub =  pi * ones(1,M);

    SearchAgents = 30;

    fobj = @(phi) fitness_MOGWO(phi, A, PM, PdM, alpha);

    ParetoSet = MOGWO_core(SearchAgents, maxIter, lb, ub, M, fobj);

    % Select knee solution (min sum of normalized objectives)
    costs = vertcat(ParetoSet.cost);
    costs = costs ./ max(costs,[],1);
    [~, idx] = min(sum(costs,2));

    best_phi = ParetoSet(idx).pos;
    W = exp(1j * best_phi(:));
end
