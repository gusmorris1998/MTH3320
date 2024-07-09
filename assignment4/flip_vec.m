function x = flip_vec(x, ref)
% x = flip_vec(x)
%
% Flip the vector x such that it will has a positive dot product with the 
% vector ref

x = sign(x'*ref)*x;

end
