function ef = prolong_correct_error(ec, ef)

% prolongates and corrects error
[IF, ~] = size(ef);

for i = 1:IF
    % changes from C code due to 1-indexing
    isOnCoarseEdge = rem(i,2);

    % the fine grid point is NOT on any of
    % the coarse edges - so take the 4 neighbours
    % and average the value
    if(isOnCoarseEdge == 0)
        ic = i/2;
        retVal = 0.5*(ec(ic) + ec(ic+1) );
        
    else
        ic = (i+1)/2;
        retVal = ec(ic);
    end % end of if checks for val
    
    ef(i) = ef(i) + retVal;
end

end

