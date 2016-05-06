function [handle, params, paramNum] = AdjParams(handle, Tokens)
    %{
    fileName  = 'modelling.txt';
    inputfile = fopen(fileName);
    handle = textscan(inputfile, '%s', 'delimiter', ' ');
    handle = num2str(cell2mat(handle{1}));
    [~, Tokens] = CreateMatByString(handle);
    %}
    %celldisp(Tokens);
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    vecParams = matValues{2};
    fclose('all'); 
    vEncode = arrayfun(@(x) find(strcmp(Tokens{x},vecDates)),1:length(Tokens));
    vecPremParams = vecParams(vEncode);
    params = cell(length(Tokens), 1);
    for ii=1:length(vecPremParams)
        params{ii} = ones(1,vecPremParams(ii));
    end
    vecNonZPar = vecPremParams(find(vecPremParams~=0));
    
    paramNum = vecPremParams';
    start = 1;
    pos = 5;
    vecNonZPar
    for ii = 1:length(vecNonZPar)
        pos = pos + regexp(handle(pos:length(handle)),'w[\(_]','once') - 1;
        fprintf('pos: %d\nhandle: %s\n',pos,handle);
        handle = [handle(1:pos-1),regexprep(handle(pos:length(handle)),'(w\(\d*:\d*\)|w_)',['w(',sprintf('%.0f',start),':',sprintf('%.0f',start+vecNonZPar(ii)-1),')'],'once')];
        start = start + vecNonZPar(ii);
        pos = pos + 2;
        
    end
end