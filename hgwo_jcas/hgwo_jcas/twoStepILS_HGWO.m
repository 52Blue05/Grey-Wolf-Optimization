function W = twoStepILS_HGWO(maxIter, alpha, A, W0, PM, PdM)

    M = size(A,1);
    lb = -pi * ones(1,M);
    ub =  pi * ones(1,M);
    N = 30;

    fobj = @(phi) sum((abs(exp(1j*phi(:))'*A(alpha)) ...
            - PM(alpha).*PdM(alpha)).^2);

    % --- GWO global search ---
    [~, best_phi] = GWO_core(N, maxIter, lb, ub, M, fobj);

    % --- Local refinement (simple random local search) ---
    step = 0.05;
    for k = 1:50
        candidate = best_phi + step*randn(size(best_phi));
        if fobj(candidate) < fobj(best_phi)
            best_phi = candidate;
        end
    end

    W = exp(1j * best_phi(:));
end
