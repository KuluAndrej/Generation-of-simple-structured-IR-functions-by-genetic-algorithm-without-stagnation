function [] = PrintPopulation(population)
NUMBMODELSTOPRINT = 20;
handles = cellfun(@(x)x.Handle, population,'UniformOutput', false);
disp('==================================================');
fprintf('\nThe best model for this iteration:\nHandle = %s;\nError = %.3f\n',population{1}.Handle,population{1}.Rank);
        
disp('==================================================');
disp('Top functions in population');
for ii = 1:min(NUMBMODELSTOPRINT,length(population))
    %Remember about that
    str = population{ii}.Handle;
    str = regexprep(str, '[],', '');
    str = regexprep(str, '\(:,1\)', '1');
    str = regexprep(str, '\(:,2\)', '2');
    
    fprintf(['%s,  rank = %.3f\n'], str, population{ii}.Rank);
end
disp('==================================================');

end