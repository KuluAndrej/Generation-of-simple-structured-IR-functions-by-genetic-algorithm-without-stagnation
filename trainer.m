matDocRel = [1,3;4,6;2,8];
matDocRanks = [1;4];
%Use map-containers to maintain relations in data
%mapNameIdRel: between doc id and its name
% mapIdNameRel = containers.Map(vecIdRelat, vecNameRelat);
%mapDocRanks: between doc name and its rank
% mapDocRanks = containers.Map(vecDocNamesEv,vecDocRanksEv);

[d1,d2] = sort(matDocRel(1,:));
indsWhichAppear = ismembc(d1,matDocRanks);

matDocRel = [matDocRel(:,d2); indsWhichAppear]

[~,d2] = sort(matDocRel(2,:),'descend');
matDocRel = matDocRel(:,d2);