length=1;
coarseGridPoints=3;
gsIterNum=3;  % number of iterations for GS smoother
numLevels=4;
useFMG=false;

x=vcycle_iter(length, coarseGridPoints, numLevels, gsIterNum, useFMG);