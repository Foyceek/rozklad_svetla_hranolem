function [x1,y1] = ray_1_parameters(alpha1,omega,c,D,n1,n2)

% Výpočet trajektorie dopadajícího paprsku na základě úhlu dopadu
% a bodu D, kde se setkává s hranolem

%úhel, který dopadající paprsek svírá s osou x
theta = 90-((90-alpha1)+omega/2);

%sklon dopadajícího paprsku
slope_alpha1 = tand(theta);

% Výpočet souřadnic bodů tvořících dopadající paprsek, pokud jsou
%  indexy lomu venkovního prostředí a hranolu stejné, projde nezlomen

if n1 == n2
    
% rozsah x-ových hodnot pro dopadající paprsek
x1 = linspace(0, 2*c, 2);

% Vypočet odpovídajících y-ových na základě bodu D a sklonu
y1 = D(2) + slope_alpha1*(x1 - D(1)); 
else
x1 = linspace(0, c/4, 2); 
y1 = D(2) + slope_alpha1*(x1 - D(1));
end