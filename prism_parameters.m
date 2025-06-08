function [b,c,v,A,B,C,D,normalBC,E,F] = prism_parameters(omega)

% délky stran AC a BC
b = sqrt(omega);

% délka strany AB
c = sqrt(b^2+b^2-2*b^2*cosd(omega));

 % výška hranolu
v = sqrt(b^2-(c/2)^2);

% souřadnice bodů
A = [0,0];
B = [c,0];
C = [c/2,v];
D = C./2;
E = [3*c/2,0];
F = [3*c/2,3*c/2];

% normálový vektor strany BC
normalBC = [-(B(1)-C(1)),(B(2)-C(2))];
end