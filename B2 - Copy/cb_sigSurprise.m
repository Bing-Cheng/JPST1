function matrixS = cb_sigSurprise1(matrix,xHist,yHist,NumTrials);
%

%
% ----------------------------------------------------------
%C
%        real function surpjp(n,nx,ny,nxy,IERR)
%C
% NOTE that original i,j loop was outside the function. Here it is inside.
% matrix contains raw JPST, not normalized by trial number
% n = IND3 = number of aligns
% nx = a PSTX bin
% ny = a PSTY bin
% nxy = the corresponding matrix bin
% IERR is a returned error value:
% ------------------------------------------------------

eExcite = zeros(size(matrix));
eInhib =  zeros(size(matrix));
IERR = zeros(size(matrix));
matrixS = zeros(size(matrix));

%
%major i,j loop through matrices
for i = 1:length(yHist)
   for j = 1:length(xHist)


        ERR1 = 0; ERR2 = 0;
        NX = xHist(j);
        NY = yHist(i);
        NNXY = matrix(i,j);
        NN = NumTrials;

        if (max([NX NY]) > NN)
            IERR(i,j) = IERR(i,j) +1;
            ERR1 = ERR1 + IERR(i,j);    %summing up the type 1 errors
            NN = max([NX NY]);
        end
        if (NNXY > min([NX NY]))
            IERR(i,j) = IERR(i,j) + 2;
            ERR2 = ERR2 + IERR(i,j);    % summing up the type 2 errors
            NNXY = min([NX NY]);
        end


        NP = NX;
        NQ = NY;
        X = double(0);

        if (NP > NQ)
            NP = NY;
            NQ = NX;
        end

        NK = NN - NQ;

        if NK<NP
            tmp1=1
        end
        MINKP = min([NK NP]);
        MAXKP = max([NK NP]);
        LMIN = max([0 NP+NQ-NN]);
        if NP+NQ-NN>0
            tmp1=1
        end
        B = double(1);
        for L=0:MINKP-1
            TA = double(MAXKP - L);
            TB = double(NN - L);
            B = double(B*TA/TB);
        end
        Y = B;

        if (NNXY ~= 0)
            X = B;
            if (LMIN <= NNXY-2)
                for L = LMIN:NNXY-2
                    TC = double(NQ-L);
                    TD = double(NP-L);
                    TE = double(L+1);
                    TF = double(NK+L+1-NP);
                    B = double(B*TC*TD/(TE*TF));
                    X = X + B;
                end
            end
            if (LMIN <= NNXY-1)
               TG = double((NQ-NNXY)+1);
               TH = double((NP-NNXY)+1);
               TI = double(NNXY);
               TK = double(NK+NNXY-NP);
               B = B*TG*TH/(TI*TK);
            end
            %X = X + B;
            Y = X + B;

        end

        if (X > double(0.99999999999999)) 
            X = double(0.99999999999999);
        end
        eExcite=-log(double(1.)-X);
        if (Y < double(0.00000000000001)) 
            Y = double(0.00000000000001);
        end
        eInhib=-log(Y);
        matrixS(i,j) = eExcite - eInhib;
%        matrix is the output surpjp plane of Palm's original routine
   end      %closing the i,j major loop
end
% Note that IERR matrix is available to examine error distributions
[m,n] = find(IERR > 0);
NUMERR = max(size([m,n]));
fprintf('number of errors is %d\n',NUMERR);






