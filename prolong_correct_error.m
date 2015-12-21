function ef = prolong_correct_error(ec, ef)

% prolongates and corrects error
[IF, JF] = size(ef);

for j = 2:JF-1
    for i = 2:IF-1
        % changes from C code due to 1-indexing
        isOnCoarseEdge = [rem(i,2), rem(j,2)];
        val = sum(isOnCoarseEdge);
        
        retVal = 0;
        % the fine grid point is NOT on any of
        % the coarse edges - so take the 4 neighbours
        % and average the value
        if(val == 0)
            lowCoarseCorner = [i/2, j/2];
            
            relevantCorners = [
                [lowCoarseCorner(1),   lowCoarseCorner(2)];
                [lowCoarseCorner(1)+1, lowCoarseCorner(2)];
                [lowCoarseCorner(1),   lowCoarseCorner(2)+1];
                [lowCoarseCorner(1)+1, lowCoarseCorner(2)+1];
                ];
            
            for c=1:4
                retVal = retVal + ec(relevantCorners(c,1), relevantCorners(c,2));
            end
            retVal = retVal*0.25;
            
        elseif (val == 1)
            coarseFaceCorners = zeros(2,2);
            
            % if on X Coarse face
            if (isOnCoarseEdge(1) == 1)
                lowCornerFace = [(i+1)/2, j/2];

                coarseFaceCorners(1,:) = lowCornerFace;
                coarseFaceCorners(2,:) = [lowCornerFace(1),   lowCornerFace(2)+1];
                
            % if on Y Face
            else
                lowCornerFace = [i/2, (j+1)/2];

                coarseFaceCorners(1,:) = lowCornerFace;
                coarseFaceCorners(2,:) = [lowCornerFace(1)+1, lowCornerFace(2)];
            end
            
            for c=1:2
                retVal = retVal + ec(coarseFaceCorners(c,1), coarseFaceCorners(c,2));
            end
            
            retVal = retVal*0.5;

        % coincides with coarse grid point
        else
            ic = (i+1)/2; jc = (j+1)/2;
            retVal = ec(ic, jc);
        end % end of if checks for val
        
        ef(i, j) = ef(i, j) + retVal;
    end
end

end

