function [handle, vecW] = paramsSimplyf(model)
    %model.Handle
    vecW = [];
    vecInPar = cell2mat(model.InitParams'); %initial parameters
    handle = model.Handle;
    handleCopy = handle;
    tokens = model.Tokens; 
    Matr = model.Mat;
    Matr = Matr - Matr';
    %we need to know indices of appearances of parameters and variables
    str1 = regexp(handle,'[') ;
    mat1 = [str1; zeros(1,length(str1))];
    str2 = regexp(handle,'(w(');
    mat2 = [str2; ones(1,length(str2))];
    str3 = regexp(handle,'x(');
    mat3 = [str3; 2*ones(1,length(str3))];
    mat  = [mat1 mat2 mat3];
    [~,I] = sort(mat(1,:));
    mat = mat(:,I); %2xn matrix of indices mentioned above
    %I need presorted list of functions
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    fclose('all'); 
    %we code every function by its position in the file
    vEncode   = arrayfun(@(x) find(strcmp(tokens{x},vecDates)),1:length(tokens));
    %launch our function to detect isomorphic roots
    [CMatIsom, vecRepr, ~] = equivsets(Matr, vEncode);
    sizeVecRepr = length(vecRepr);
    arrayReprJJ = [];
    for jj=1:sizeVecRepr
        arrayReprJJ = [arrayReprJJ cell2mat(vecRepr{jj})];
    end
    %arrayRepr is an array of representatives of classes of equivalency
    arrayReprJJ = sort(arrayReprJJ);
    %string can change its size; shift helps to keep actual index
    shift = 0;
    %indexW maintain actual index of the first free element in formed array
    %of parameters
    indexW = 1;
    %we equate parameters for isomorphic vertices
    for jj=1:length(arrayReprJJ)
        tmp1 = arrayReprJJ(jj);
        %we consider only one case - vertices has parameters
        if mat(2,tmp1)==1 
            expr = regexp(handle(mat(1,tmp1)-shift:length(handle)),'\d+:\d+','match','once');
            arrayExpr = str2num(expr);
            %form vector of parameters for this vertice
            vecW(indexW:indexW+length(arrayExpr)-1) = vecInPar(arrayExpr);
            
            if indexW<arrayExpr(1)
            expr = strcat(num2str(indexW),':',num2str(indexW+length(arrayExpr)-1));
            end
            indexW = indexW + length(arrayExpr);
            %equate parameters for equal vertices
            for ii=1:length(CMatIsom{tmp1})
                tmp = CMatIsom{tmp1}(ii);
                handleCopy = strcat(handle(1:mat(1,tmp)-shift-1),regexprep(handle(mat(1,tmp)-shift:length(handle)),'\d+:\d+',expr,'once'));
                if length(handleCopy)~=length(handle)
                    shift = shift + length(handle) - length(handleCopy);
                end
                handle = handleCopy;
            end
        end
    end
end



