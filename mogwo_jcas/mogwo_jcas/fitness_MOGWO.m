function F = fitness_MOGWO(phi, A, PM, PdM, alpha)

    w = exp(1j * phi(:));
    AF = abs(w' * A);

    % Objective 1: Communication beam error
    f1 = sum((AF(alpha) - PM(alpha).*PdM(alpha)).^2);

    % Objective 2: Sidelobe level
    f2 = mean(AF(~ismember(1:length(AF), alpha)).^2);

    % Objective vector
    F = [f1, f2];
end
