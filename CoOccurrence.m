
function [tabResultat] = CoOccurrence(image)

Y = imread(image);
% figure(1); imshow (Y); title ('image originale');

% Construction des matrice distance = 1 et les angles = 
% angle = 0
% disp ('Matrice degré 0')
glcm1 = graycomatrix(Y,'Offset',[0 1]);
% disp (glcm1);

% angle = 45
% disp ('Matrice degré 45')
glcm2 = graycomatrix(Y,'Offset',[-1 1]);
% disp (glcm2);

% angle = 90
% disp ('Matrice degré 90')
glcm3 = graycomatrix(Y,'Offset',[-1 0]);
% disp (glcm3);

% angle = 135
% disp ('Matrice degré 135')
glcm4 = graycomatrix(Y,'Offset',[-1 -1]);
% disp (glcm4);

for i = 1 : 4
        if i == 1
            glcm = glcm1;
        else if i == 2                
            glcm = glcm2;
            else if i == 3
                    glcm = glcm3;
                else glcm = glcm4;
                end
            end
        end
        % calculates the statistics specified in properties from the gray-level co-occurence matrix glcm.
         % glcm is an m-by-n-by-p array of valid gray-level co-occurrence matrices. 
        % If glcm is an array of GLCMs, stats is an array of statistics for each glcm.
        % cette fonction retourne une structure contenant le paramètres
        % suivante dans l'ordre : contrast correlation energy homogeneity
        stats = graycoprops(glcm);
        % convertir la structure en un vecteur
        x = struct2array(stats);
        
    % on construit une matrice 4x4 : 
    % 4 lignes représentant les 4 matrices de degré : 0 45 90 et 135
    % et 4 colonnes représentant les 4 paramètres " contrast correlation
    % energy homogeneity "
    for j = 1 : 4
        matriceRes(i, j) = x(j);
    end
end

% 
% disp ('matrice resulta');
% disp( matriceRes);

% on parcourt les lignes ; en fixant la colonne de telle sorte à calculer la
% moyenne de chaque paramètre " contrast correlation energy homogeneity "
for j = 1 : 4
    som = 0;
    for i = 1 : 4
        som = som + matriceRes(i, j);
    end
    % on aura en sortie un tableau des moyennes des 4 paramètres " contrast
    % correlation energy homogeneity "
    tabResultat(j) = som / 4;
end

end

