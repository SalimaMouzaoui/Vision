
% une fonction qui vérifie si l'image en entree est en NVG ou couleur
function [] = verifNVG(image1)
s = size(image1,3);
if (s == 3) 
    % si l'image est en couleur , on la couvertit en NVG
    X = rgb2gray(image1);
%    figure(2); imshow (X);  title ('image niveau de gris');
end
end