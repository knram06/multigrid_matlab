function ef = prolong_correct_error(ec, ef)

% get sizes
[NNN, ~] = size(ef);
Nf = uint32(NNN^(1/3));

% reshape for now
ef = reshape(ef, [Nf, Nf, Nf]);

[NNN, ~] = size(ec);
Nc = uint32(NNN^(1/3));

ec = reshape(ec, [Nc, Nc, Nc]);

for k = 1:Nf
    for j = 1:Nf
        for i = 1:Nf
            
            % changes from C code due to 1-indexing
            isOnCoarseEdge = [rem(i,2), rem(j,2), rem(k,2)];
            val = sum(isOnCoarseEdge);
            
            retVal = 0;
            % the fine grid point is NOT on any of
            % the coarse edges - so take the 8 neighbours
            % and average the value
            if(val == 0)
                lowCoarseCorner = [i/2, j/2, k/2];
                
                relevantCorners = [
                    [lowCoarseCorner(1),   lowCoarseCorner(2),   lowCoarseCorner(3)];
                    [lowCoarseCorner(1),   lowCoarseCorner(2),   lowCoarseCorner(3)+1];
                    [lowCoarseCorner(1),   lowCoarseCorner(2)+1, lowCoarseCorner(3)];
                    [lowCoarseCorner(1),   lowCoarseCorner(2)+1, lowCoarseCorner(3)+1];

                    [lowCoarseCorner(1)+1, lowCoarseCorner(2),   lowCoarseCorner(3)];
                    [lowCoarseCorner(1)+1, lowCoarseCorner(2),   lowCoarseCorner(3)+1];
                    [lowCoarseCorner(1)+1, lowCoarseCorner(2)+1, lowCoarseCorner(3)];
                    [lowCoarseCorner(1)+1, lowCoarseCorner(2)+1, lowCoarseCorner(3)+1];
                    ];
                
                for c=1:8
                    retVal = retVal + ec(relevantCorners(c,1), relevantCorners(c,2), relevantCorners(c,3));
                end
                retVal = retVal/8;
            
            elseif (val == 1)
                coarseFaceCorners = zeros(4,3);
                
                % if on X Coarse face
                if (isOnCoarseEdge(1) == 1)
                    lowCornerFace = [(i+1)/2, j/2, k/2];
                    
                    coarseFaceCorners(1,:) = lowCornerFace;
                    coarseFaceCorners(2,:) = [lowCornerFace(1), lowCornerFace(2)+1, lowCornerFace(3)];
                    coarseFaceCorners(3,:) = [lowCornerFace(1), lowCornerFace(2),   lowCornerFace(3)+1];
                    coarseFaceCorners(4,:) = [lowCornerFace(1), lowCornerFace(2)+1, lowCornerFace(3)+1];
                
                % if on Y Face
                elseif (isOnCoarseEdge(2) == 1)
                    lowCornerFace = [i/2, (j+1)/2, k/2];
                    
                    coarseFaceCorners(1,:) = lowCornerFace;
                    coarseFaceCorners(2,:) = [lowCornerFace(1)+1, lowCornerFace(2), lowCornerFace(3)];
                    coarseFaceCorners(3,:) = [lowCornerFace(1),   lowCornerFace(2), lowCornerFace(3)+1];
                    coarseFaceCorners(4,:) = [lowCornerFace(1)+1, lowCornerFace(2), lowCornerFace(3)+1];
                
                % if on Z Face
                else
                    lowCornerFace = [i/2, j/2, (k+1)/2];
                    
                    coarseFaceCorners(1,:) = lowCornerFace;
                    coarseFaceCorners(2,:) = [lowCornerFace(1),   lowCornerFace(2)+1, lowCornerFace(3)];
                    coarseFaceCorners(3,:) = [lowCornerFace(1)+1, lowCornerFace(2),   lowCornerFace(3)];
                    coarseFaceCorners(4,:) = [lowCornerFace(1)+1, lowCornerFace(2)+1, lowCornerFace(3)];
                end
                
                for c=1:4
                    retVal = retVal + ec(coarseFaceCorners(c,1), coarseFaceCorners(c,2), coarseFaceCorners(c,3));
                end
                
                retVal = retVal * 0.25;
                
            elseif (val == 2)
                coarseEdgeCorners = zeros(2, 3);
                
                if (isOnCoarseEdge(1) == 0)
                    lowCornerEdge = [i/2, (j+1)/2, (k+1)/2];
                    
                    coarseEdgeCorners(1,:) = [lowCornerEdge(1),   lowCornerEdge(2), lowCornerEdge(3)];
                    coarseEdgeCorners(2,:) = [lowCornerEdge(1)+1, lowCornerEdge(2), lowCornerEdge(3)];
                    
                elseif (isOnCoarseEdge(2) == 0)
                    lowCornerEdge = [(i+1)/2, j/2, (k+1)/2];
                    
                    coarseEdgeCorners(1,:) = [lowCornerEdge(1),   lowCornerEdge(2),   lowCornerEdge(3)];
                    coarseEdgeCorners(2,:) = [lowCornerEdge(1),   lowCornerEdge(2)+1, lowCornerEdge(3)];
                    
                elseif(isOnCoarseEdge(3) == 0)
                    lowCornerEdge = [(i+1)/2, (j+1)/2, k/2];
                    
                    coarseEdgeCorners(1,:) = [lowCornerEdge(1), lowCornerEdge(2), lowCornerEdge(3)];
                    coarseEdgeCorners(2,:) = [lowCornerEdge(1), lowCornerEdge(2), lowCornerEdge(3)+1];
                end
                
                for c=1:2
                    retVal = retVal + ec(coarseEdgeCorners(c,1), coarseEdgeCorners(c,2), coarseEdgeCorners(c,3));
                end
                
                retVal = retVal * 0.5;
                
            else
                ic = (i+1)/2; jc = (j+1)/2; kc = (k+1)/2;
                retVal = ec(ic, jc,kc);
            % end of if checks for val
            end
            
            ef(i, j, k) = ef(i, j, k) + retVal;
        end
    end
end

% reshape ef
ef = reshape(ef, [Nf*Nf*Nf, 1]);

end

