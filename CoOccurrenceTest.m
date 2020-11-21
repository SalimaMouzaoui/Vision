
function [resultatMoy] = CoOccurrenceTest()

s = struct('name',{'test1.tif','test2.tif','test3.tif','test4.tif','test5.tif'});

for i = 1 : 5
% on calcule les 4 matries de co-occurrence puis on calcule les 4
% paramètres " contrast correlation energy homogeneity " de chaque image de
% Test 
    x2 = CoOccurrence(s(i).name);
% on construit une matrice 5x4 
% 5 lignes correspondant aux nombre d'image de test
% 4 colonnes représentant les 4 paramètres
    for j = 1 : 4
        Resultat(i, j) = x2(j);
    end
end

% on parcourt les lignes ; en fixant la colonne de telle sorte à calculer la
% moyenne de chaque paramètre " contrast correlation energy homogeneity "
% pour les 5 images de test
for j = 1 : 4
    som = 0;
    for i = 1 : 5
        som = som + Resultat(i, j);
    end
    resultatMoy(j) = som / 5;
end

end
