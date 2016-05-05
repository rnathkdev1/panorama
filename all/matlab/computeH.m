function H2to1=computeH(p1,p2)
    
n = size(p1, 2);
x = p2(1, :); y = p2(2,:); X = p1(1,:); Y = p1(2,:);
rows0 = zeros(3, n);
rowsXY = -[X; Y; ones(1,n)];
hx = [rowsXY; rows0; x.*X; x.*Y; x];
hy = [rows0; rowsXY; y.*X; y.*Y; y];
h = [hx hy];
if n == 4
    [U, ~, ~] = svd(h);
else
    [U, ~, ~] = svd(h, 'econ');
end

H2to1 = (reshape(U(:,end), 3, 3)).';
end

