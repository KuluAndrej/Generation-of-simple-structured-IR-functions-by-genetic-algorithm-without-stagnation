%function [handle] = templateSearch(model)
function [handle, tokSize] = templateSearch2(handle, Mat, Tokens)
    
    constVarNumb = 2;
    beginEncode  = 29;
   
    fileName  = 'modelling.txt';
    inputfile = fopen(fileName);
    handle = textscan(inputfile, '%s', 'delimiter', ' ');
    %get string from cell
    
    
    handle = num2str(cell2mat(handle{1}));
    handle = handle(7:length(handle));
    handle
    [Matr, Tokens] = CreateMatByString(handle);
    
    
    tokensOccur = [1 regexp(handle,',')+1];
    
    Matr = Matr - Matr';
    
    %{
    handle      = model.Handle;
    Matr        = model.Mat;
    Matr        = Matr - Matr';
    Tokens      = model.Tokens;
    %}
    
    nsizeMat    = size(Matr);
    %get matrix and tokens
    incidMatr = arrayfun(@(x) {find(Matr(x,:)==1)}, 1:nsizeMat);
    %do like in paramSimplify.m
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    vecParams = matValues{2};
    fclose('all'); 
    vEncode = arrayfun(@(x) find(strcmp(Tokens{x},vecDates)),1:length(Tokens));
    [CMatIsom, ~, ~] = equivsets(Matr, vEncode);
    vecCMLeav = arrayfun(@(x) length(CMatIsom{x}), 1:length(CMatIsom));
    vecCMLeav = find(vecCMLeav==0);
    
    data = sortrows([vEncode(vecCMLeav); vecCMLeav].',1); 
    arrayPieces = accumarray(data(:,1),data(:,2)',[],@(x){x.'});
    classElements = arrayPieces(vEncode(vecCMLeav)).';
    %arrayfun(@(x) CMatIsom{vecCMLeav(x)} = classElements(x),1:length(vecCMLeav));
    CMatIsom(vecCMLeav) = arrayfun(@(x) {classElements{x}}, 1:length(vecCMLeav));
    
    %{
    for ii=1:length(classElements)
        CMatIsom{vecCMLeav(ii)} = classElements(ii);
    end
    %}
% there I got the representation of main matrix
    inputfile = fopen('templ1.txt');
    matValues = textscan(inputfile, '%s', 'delimiter', ' ');
    fclose('all');
    NUMBFILES = length(matValues{1})/2;
for nfiles = 1:NUMBFILES
    tokensOccur = [1 regexp(handle(5:length(handle)),',[a-z]')+5];
    %tokensOccur = [1 regexp(handle(2:length(handle)),',[a-z]')+1]
    %[tEntry, tEntry2]  = fileGetString(['templ' num2str(nfiles*2-1) '.txt']);
    tEntry       = matValues{1}{nfiles*2-1};
    
    %tEntry  = num2str(cell2mat(tEntry));
    [tMat, tTokens]    = CreateMatByString(tEntry);
    
    %tEntry  = num2str(cell2mat(tEntry));
    tEntry       = matValues{1}{nfiles*2};
    tChToken     = num2str(cell2mat(regexp(tEntry,'\w*_','match')));
    if isempty(tChToken)
        tChToken = tEntry;
    end
    tMat = tMat - tMat';
    tnsizeMat = size(tMat);
    tVecLeaves = zeros(1,tnsizeMat);
    
    tvEncode = arrayfun(@(x) find(strcmp(tTokens{x},vecDates)),1:length(tTokens));
    tincidMatr = arrayfun(@(x) {find(tMat(x,:)==1)}, 1:tnsizeMat);
    
    entryReg = regexp(handle, tTokens{1}, 'once');
    newOcc = 1;
    chStep = 0;
    while ~isempty(entryReg{1})
        entryReg = entryReg{1};
        chStep = chStep + length(tokensOccur);
        tokensOccur = [1 regexp(handle(5:length(handle)),',[a-z]')+5];
        chStep = chStep - length(tokensOccur);
        %fprintf('NEW iteration\nbegin with = %s, EntryReg = %d\n',handle,entryReg);
        lasting = balancedBr(handle, entryReg);
        currOcc = entryReg;% - length(handle) + length(constHandle);
        %fprintf('part to change = %s\n',handle(currOcc:lasting));
        numbVer = find(tokensOccur(newOcc:length(tokensOccur))==currOcc,1);
        
        [b, tVecLeaves] = ifIsomTempl (chStep+numbVer, 1, tVecLeaves, incidMatr, tincidMatr, vEncode,tvEncode);
        if b
            for ii =1:constVarNumb
                
                currArray = find(tvEncode == beginEncode-1+ii);
                if isempty(currArray)
                    continue
                end
                currArray = sort(tVecLeaves(currArray));
                if length(CMatIsom{currArray(1)})<length(currArray)
                    b = false;
                else
                b = b&&isequal(currArray, CMatIsom{currArray(1)}(1:length(currArray)));
                end
            end
        else
            newOcc = newOcc+1;
        end
        if b
            %fprintf('simplif by rule\n');
            for ii = 1:constVarNumb
                
                ind = find(tvEncode == beginEncode-1+ii);
                if isempty(ind) 
                    continue 
                end
                ind = ind(1);
                %lenInd = length(ind);
                %fprintf('time to = %s\n', handle);
                
                
                
                indTokStart = tokensOccur(tVecLeaves(ind)-chStep);
                indTokEnd   = balancedBr (handle, indTokStart);
                
                repLength   = indTokStart - indTokEnd + 1; 
                handle(indTokStart:indTokEnd);
                tEntryCh = regexprep(tEntry, ['x',sprintf('%.0f',ii)], handle(indTokStart:indTokEnd));
                
            end
            
            initLength = lasting - entryReg + 1;
            start      = lasting + repLength - initLength;
            if vecParams(find(strcmp(tTokens{1},vecDates)))==0
                handle     = [handle(1:entryReg-1) tEntryCh handle(lasting+1:length(handle))];
            else
                tempLength = length(tChToken);%length(num2str(cell2mat(tTokens{1})));
                %fprintf('tChToken = %s',tChToken); 
                foundParams = regexp(handle(entryReg:length(handle)),'w\(\d*:\d*\)','match','once');
                %tEntryCh
                %tEntryCh(tempLength+1:length(tEntryCh))
                tempHandle = [tEntryCh(tempLength+2:length(tEntryCh)) handle(lasting+1:length(handle))];
                
                handle     = [handle(1:entryReg-1) tChToken '(' foundParams tempHandle];
            end            %fprintf('make a string = %s\n',handle);
        else 
            start = lasting;
        end
        %fprintf('we done a string = %s\n',handle);
        entryReg   = regexp(handle(max(start,2):length(handle)),tTokens{1},'once');
        entryReg{1}   = entryReg{1} + max(start,2)-1;
    
    end
    
end
tokensOccur = [1 regexp(handle(5:length(handle)),',[a-z]')+5];
tokensOccur2 = [regexp(handle(1:length(handle)),',[0-9]\*')];
tokSize = length([tokensOccur tokensOccur2]);
%fprintf('  end with = %s\n',handle);
handle = strcat('@(w,x)',handle);
end
%function for the second rule
function [handleNew] = plusEqual ()
global CMatIsom handle tokens incidMatr vEncode;
    %arrayApp is to replace entry of 'plus2_'
    arrayApp = regexp(handle, 'plus2_');
    indPlus2 = find(arrayfun(@(x) strcmp('plus2_',tokens{x}), 1:length(tokens))==1);
    handleCopy = handle;
    %for every tokens similar to 'plus2_' we check if it's possible to
    %simplify it
    for ii=1:length(indPlus2)
        tmp = indPlus2(ii);
        child1 = incidMatr{tmp}(1);
        child2 = incidMatr{tmp}(2);
        %there is two bool variables: fisrt is to check if virtice has two
        %equal childs, second - for isomorphic subtrees
        blExpr1 = (vEncode(child1)==vEncode(child2))&&(isempty(incidMatr{child1}));
        blExpr2 = any(CMatIsom{child1}==child2);
        if blExpr1 
            regexprep(handle(arrayApp:length(handle)),'plus2_\(\w+,\w+\)','$1','once');
        end
        
        if blExpr2 
            lastInd = balancedBr(handle, arrayApp+7);
            modelInd = balancedBr(handle, arrayApp);
            handleCopy = strcat('2*',handle(1:arrayApp-1),handle(arrayApp+7:lastInd),handle(modelInd:length(handle)-1));
        end
    end
    handleNew = handleCopy;
end

%{
function [handleNew] = cs2sin2t ()
global CMatIsom handle vecDates tokens incidMatr vEncode;
    %sense is similar to the function above
    arrayApp = regexp(handle, 'times2_');
    codeCos = find(strcmp('cos_',vecDates));
    codeSin = find(strcmp('sin_',vecDates));
    indTimes2 = find(arrayfun(@(x) strcmp('times2_',tokens{x}), 1:length(tokens))==1);
    handleCopy = handle;
    for ii=1:length(indTimes2)
        
        tmp = indTimes2(ii);
        
        tms1v = vEncode(incidMatr{tmp}(1));
        tms2v = vEncode(incidMatr{tmp}(2));
    if isequal(sort([tms1v tms2v]), sort([codeCos codeSin]))
        child1 = incidMatr{incidMatr{tmp}(1)}(1);
        child2 = incidMatr{incidMatr{tmp}(2)}(1);
        blExpr1 = (vEncode(child1)==vEncode(child2))&&(isempty(incidMatr{child1}));
        blExpr2 = any(CMatIsom{child1}==child2);
        if blExpr1||blExpr2
            
            sinInd1 = regexp(handle(arrayApp:length(handle)),'sin_\(','once');
            cosInd1 = regexp(handle(arrayApp:length(handle)),'cos_\(','once');
            
            sinInd1 = sinInd1+3+arrayApp;
            cosInd1 = cosInd1+3+arrayApp;
            cosInd2 = balancedBr(handle,cosInd1);
            sinInd2 = balancedBr(handle,sinInd1);
            inds = [sinInd1 cosInd1 sinInd2 cosInd2];
            inds = sort(inds);
            substrMod = handle(inds(1)+1:inds(2)-1);
            handleCopy = strcat(handle(1:arrayApp-1),'0.5*sin_(2*',substrMod,handle(inds(4)+1:length(handle)));
        end
    end
    end
    handleNew = handleCopy;
end
%}
function [indexStr] = balancedBr (handle, first)
    
%function gets such smallest index i that sequence from the first to i have
%all the brackets balanced 
    if strcmp(handle(first),'x')
        indexStr = first+5;
        return
    end
    summ = 0;
    b = true;
    %{
    if (strcmp(handle(first),'x'))
        b = false;
        first=first+2;
    end
    %}    
    while (summ>0)||b
        if (strcmp(handle(first),'('))
        summ = summ + 1;
        b = false;
        end
        if (strcmp(handle(first),')'))
        summ = summ - 1;
        end
        
        
        first = first + 1;
    end
    indexStr = first - 1;
end

function [str1, str2] = fileGetString (handle)
    inputfile = fopen(handle);
    matValues = textscan(inputfile, '%s', 'delimiter', ' ');
    str1       = matValues{1}{1};
    str2       = matValues{1}{2};
    fclose('all');
end

function [b, tVecLeaves] = ifIsomTempl (root, troot, tVecLeaves, incidMatr, tincidMatr, vEncode,tvEncode)
    b = true;
    size = length(tincidMatr{troot});
    if size==0
        tVecLeaves(troot) = root;
        return
    end
    if (vEncode(root)~=tvEncode(troot))
        b = false;
        return
    end
    for ii=1:size
        
        [b, tVecLeaves] = ifIsomTempl (incidMatr{root}(ii), tincidMatr{troot}(ii), tVecLeaves, incidMatr, tincidMatr, vEncode,tvEncode);
        if (b==0)
            return
        end
    end
end

