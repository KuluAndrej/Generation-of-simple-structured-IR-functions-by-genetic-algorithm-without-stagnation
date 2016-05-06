function [value] = permutatt(vec1, vec2) 
    
    [~,d2] = sort(vec1);
    vec2ps = vec2(d2);
    value = mymexinversions(vec2ps);
end

