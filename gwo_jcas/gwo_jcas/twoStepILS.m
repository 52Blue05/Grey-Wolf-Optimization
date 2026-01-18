function W = twoStepILS(maxIter, alpha, A, W0, PM, PdM)
% GWO-based replacement for Two-Step ILS
% Compatible with main.m (no modification needed)

    M = size(A,1);          % Number of antenna elements
    lb = -pi * ones(1,M);
    ub =  pi * ones(1,M);

    SearchAgents = 30;

    % Fitness function (same objective as LS but phase-only)
    fobj = @(phi) fitness_JCAS(phi, A, PM, PdM, alpha);

    % --- Run GWO ---
    [~, best_phi] = GWO_core(SearchAgents, maxIter, lb, ub, M, fobj);

    % Return beamforming vector (phase-only)
    W = exp(1j * best_phi(:));
end
