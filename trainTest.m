function [ seuil ] = trainTest( x1, X1 )

% on parcourt les 2 tableaux de r�sultats de la matrice de co-occurrence
% avec les 4 param�tres. On calcule la distance des param�tres entre les textures des 2
% images diff�rentes
% dist(param) = valeur absolue ((param1 - param2 ) / param1)
for j = 1 : 4
    X = (x1(j) - X1(j)) / x1(j);
    Res1(j) = abs(X);     
end

% on calcule la moyenne des 4 param�tres obtenenue (ses moyennes), 
% pour avoir une seule distance de texture
moy1 = 0;
for i = 1 : 4
    moy1 = moy1 + Res1(i);
end
seuil = moy1/4;

end

