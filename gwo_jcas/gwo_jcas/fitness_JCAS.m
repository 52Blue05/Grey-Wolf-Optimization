function cost = fitness_JCAS(phi, A, PM, PdM, alpha)
% Fitness function matching JCAS mask approximation

    w = exp(1j * phi(:));
    AF = abs(w' * A);

    % Only approximate selected directions (alpha)
    err = AF(alpha) - PM(alpha) .* PdM(alpha);

    cost = sum(err.^2);
end
