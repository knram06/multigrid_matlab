function ef = simple_prolong_correct(ec, ef)

% prolongates and corrects error
[IC, JC, KC] = size(ec);

% copy over corresponding grid point values only
for k = 1:KC
    for j = 1:JC
        for i = 1:IC
            i_f = 2*i-1; j_f = 2*j-1; k_f = 2*k-1;
            
            % do correction
            ef(i_f, j_f, k_f) = ef(i_f, j_f, k_f) + ec(i, j, k);
        end
    end
end

end

