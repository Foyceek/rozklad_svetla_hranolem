function [x_intersect, y_intersect] = lineIntersect(x1, y1, x2, y2, x3, y3, x4, y4)

% Sklony čar
m1 = (y2 - y1) / (x2 - x1);
b1 = y1 - m1*x1;

m2 = (y4 - y3) / (x4 - x3);
b2 = y3 - m2*x3;

% Průsečík
x_intersect = (b2 - b1) / (m1 - m2);
y_intersect = m1*x_intersect + b1;
end