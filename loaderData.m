function [matDocIdStr, matDocRanks, matQueries, modelCharacteristics] = loaderData(matDocRanks,trecs)
disp('start loading data...');


matFileQueries  = fopen(['data/queries',num2str(trecs),'.txt']);
matQueries      = textscan(matFileQueries, '%d%s', 'delimiter', '#'); 



for jj=1:length(matQueries{1})
    [matMetaData{jj}, matDocIdStr{jj}, matDocRanksNew{jj}, matTermDocVars{jj}, vecDelim{jj}] = loaderCode(matDocRanks, matQueries{1}(jj),jj,trecs); 
    
    tempDocVars = matTermDocVars{jj};
    tempMatMetaData = matMetaData{jj};
    tempVecDelim = vecDelim{jj};
    tempDocRanks = matDocRanksNew{jj};
    
    vecMetaValue = tempMatMetaData{2};

    AvDocLen         = vecMetaValue(find(strcmp('AverageDocumentLength',tempMatMetaData{1})));
    NumbDocs         = vecMetaValue(find(strcmp('NumberOfDocuments',tempMatMetaData{1})));

    
    [ulable, ~,uindex] = unique(tempDocVars(:,1));
    modelCharacteristics{jj}{1} = ulable;
    modelCharacteristics{jj}{2} = uindex;
    
    xvars = double(tempDocVars(:,2)).*log10((double(AvDocLen)+double(tempDocVars(:,3)))./double(tempDocVars(:,3)));
    yvars = double(tempVecDelim)/double(NumbDocs);
    yvarsExt_ed = ones(sum(tempVecDelim),1);
    start = 1;
    for ii = 1:length(tempVecDelim)
        temp = yvars(ii)*ones(1,tempVecDelim(ii));
        yvarsExt_ed(start:start+tempVecDelim(ii)-1) = temp;
        start = start + tempVecDelim(ii);
    end
    modelCharacteristics{jj}{3} = [xvars, yvarsExt_ed];
    

    vecDocNamesEv  = tempDocRanks{3};
    vecDocRanksEv  = tempDocRanks{4};
    tempDocRanks{3}  = vecDocNamesEv(find(vecDocRanksEv==1));
    matDocRanksNew{jj} = rankRewriter(tempDocRanks,matDocIdStr{jj});
end
matDocRanks = matDocRanksNew;
disp('...done');
end