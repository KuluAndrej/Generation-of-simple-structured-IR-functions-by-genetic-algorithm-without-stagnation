function [matDocRanks] = rankRewriter(matDocRanks, matDocIdStr)

vecNamesIdStr = matDocIdStr{1};
vecIdsIdStr = matDocIdStr{2};
vecNamesDocRanks = matDocRanks{3};

[~,indInNamesIdStr] = ismember(vecNamesDocRanks, vecNamesIdStr);

idsOfDocRanks = vecIdsIdStr(indInNamesIdStr(find(indInNamesIdStr)));

matDocRanks{5} = sort(idsOfDocRanks);


end