function ef = simple_prolong_correct(ec, ef)

% prolongates and corrects error
[IC, JC] = size(ec);

% copy over corresponding grid point values only
for j = 1:JC
    for i = 1:IC
        i_f = 2*i-1; j_f = 2*j-1;
        
        % do correction
        ef(i_f, j_f) = ef(i_f, j_f) + ec(i, j);
    end
end

end

