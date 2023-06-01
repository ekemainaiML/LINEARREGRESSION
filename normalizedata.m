function N = normalizedata(X)
 m = mean(X);
 s = std(X);
 N = abs((X - m) ./ s);
end
