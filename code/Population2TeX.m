function Population2TeX(Population, X, y, reportFolder, TeXFilename, pltopt)
% Population2TeX(Population,TeXfilename)
% 
% \usepackage{ecltree}
% \drawwith{\dottedline{1}}
% \setlength{\GapDepth}{1mm}
% \setlength{\GapWidth}{2mm}
% then insert the tex string

TeXfilename = fullfile(reportFolder, TeXFilename);

strbeg = [  '\\documentclass[12pt]{article}\n', ...
            '\\usepackage{a4wide}\n', ...
            '\\usepackage{multicol}\n', ...
            '\\usepackage[cp1251]{inputenc}\n',...
            '\\usepackage[russian]{babel}\n',...
            '\\usepackage{amsmath, amsfonts, amssymb, amsthm, amscd}\n',...
            '\\usepackage{graphicx, epsfig}\n',...
            '\\usepackage{epic}\n',...
            '\\usepackage{ecltree}\n',...
            '\\drawwith{\\dottedline{1}}\n',...
            '\\setlength{\\GapDepth}{4mm}\n',...
            '\\setlength{\\GapWidth}{8mm}\n',...
            '\n',...                      
            '\\begin{document}\n',...
            '\\section*{Multivariate Regression Composer}\n',...
            'Author: Mikhail Kuznetsov\\\\\n',...
            'Moscow Institute of Physics and Technology\\\\\n',...
            'Supervisor: V.V. Strijov\\\\\n',...
            'Course: Machine Learning and Data Analysis, Fall 2013\\\\\n',...
            'Date: 24.12.2013\\\\\n'];
strend =    '\\end{document}';

fid = fopen(TeXfilename,'w+');
fprintf(fid,strbeg);

for i = 1:length(Population)
    strMat = Model2Tree(Population{i}, '', 1);    
    %strName = Population{i}.Name;
    %%% FIXIT, remove all '_' from the function names to safisfy TeX requirements 
    strMat = regexprep(strMat, '_', '');
    %strName = regexprep(strName, '_', '');
    fprintf(fid,'\\hrule\n\\vspace{1cm}\n');
    tex = Model2Tex(Population{i}, 1);
    fprintf(fid, strcat('Model\\;', int2str(i), ': $f(w,\\mathbf{x})=', tex, '$\n\n'));
    %fprintf(fid,'%s\n\n', strName);
    fprintf(fid,'\\begin{multicols}{2}\n%s', strMat);
    h = PlotStruct(str2func(Population{i}.Handle), Population{i}.FoundParams, X, y, pltopt);
    figFname = strcat(num2str(i), '.eps');
    saveas(h, fullfile(reportFolder, figFname), 'eps');
    fprintf(fid, strcat('\n\n\\columnbreak\n\\includegraphics[width=8cm]{', figFname, '}\n\\end{multicols}'));
    fprintf(fid,'\n\n');
    
end

fprintf(fid,strend);
fclose(fid);
return


function str = Model2Tree(model, str, currIdx)
% str = Mat2TeX(Mat, str)
% creates TeX tree from the Tree structure
%
% Usage: 
% TeX file must contain the following header:
% \documentclass[12pt]{article}
% \usepackage[cp1251]{inputenc}
% \usepackage{epic}
% \usepackage{ecltree}
% \drawwith{\dottedline{1}}
% \setlength{\GapDepth}{4mm}
% \setlength{\GapWidth}{8mm}
% \begin{document}
% %%%-your string
% \end{document}
%
% http://strijov.com

currChildren = find(model.Mat(currIdx, :));
if ~isempty(currChildren)
    str = strcat(str, '\begin{bundle}{', char(model.Tokens{currIdx}), '}');
    for chIdx = 1 : length(currChildren)
        str = strcat(str, '\chunk{');
        str = Model2Tree(model, str, currChildren(chIdx));
        str = strcat(str, '}');
    end
    str = strcat(str,'\end{bundle}');
else
    str = strcat(str, char(model.Tokens{currIdx}));
end

return




    
    