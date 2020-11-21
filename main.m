function [seuil,X] = main()
% disp ('Image Originale');
image1 = '�gale.tif';
% on verifie si c une image en NVG ou couleur
verifNVG(image1);

% on calcule les 4 matries de co-occurrence puis on calcule les 4
% param�tres " contrast correlation energy homogeneity " de l'image Egal
x1 = CoOccurrence(image1);

image2 = 'diff�rente.tif';
verifNVG(image2);

% on calcule les 4 matries de co-occurrence puis on calcule les 4
% param�tres " contrast correlation energy homogeneity " de chaque image de
% Test 
X = CoOccurrenceTest();
% disp ('Distance entre test et �gale est : ');
% disp (X1);

% on fait appel � la fonction trainTest qui a comme param�tre
% le tableau de moyennes des 4 param�tres de l'image Egale
% et le tableau de moyennes des 4 param�tres de la base de test
seuil1 = trainTest(x1, X);
%disp ('Distance entre test et egale est : ');
%disp (seuil1);
x2 = CoOccurrence(image2);

% X2 = CoOccurrenceTest();
% disp ('Distance entre test et diff�rente est : ');
% disp (X2);

% on fait appel � la fonction trainTest qui a comme param�tre
% le tableau de moyennes des 4 param�tres de l'image Diff�rente
% et le tableau de moyennes des 4 param�tres de la base de test 
seuil2 = trainTest(x2, X);
%disp ('Distance entre test et diff�rente est : ');
%disp (seuil2);

% seuil est un param�tre empirique conclut a partir de la base des tests
% apres calcul de distance = ( seuil1 + seuil2 ) / 2
seuil = (seuil1 + seuil2) / 2;
end