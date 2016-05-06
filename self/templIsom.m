function []  = templIsom()
handle = '@(w,x)linear_(w(1:2),parabola_(w(3:5),normal_(w(6:8),sin_([],times2_([],mult_(w(9:9),linear_(w(10:11),x(:,2))),parabola_(w(12:14),x(:,2)))))))';
[model, model.Handle]   = GetModel(handle);
model.Handle
[model.Handle, ~] = templateSearch(model.Handle, model.Mat, model.Tokens);
model.Handle


[model, model.Handle]   = GetModel(model.Handle);
end
function [model, handle]  = GetModel(handle)
    %handle = regexprep(handle,'w\(\d*:\d*\),','');  
    
    handle = regexprep(handle,'@\(w,x\)','');
    handle = regexprep(handle,'w\(\d*:\d*\),','w_,');
    constHandle = handle;
    
    handle = regexprep(handle,'\[\],','');
    handle = regexprep(handle,'w_,','');
    handle = regexprep(handle,'w\(\d*:\d*\),',''); 
    handle = regexprep(handle,'x\(:,1\)','x1');
    handle = regexprep(handle,'x\(:,2\)','x2');
    [model.Mat, model.Tokens] = CreateMatByString(handle);
    model.FoundParams = [];
    handle = ['@(w,x)',constHandle];
end
        