function [ray_2,beta1,betad,points,direction] = ray_2_parameters(n ...
    ,n1,alpha1,delta,sample_size,c,B,C,D)

% úhel lomu druhého paprsku
beta1 = asind(n1*sind(alpha1)./n);
betad = delta/2;

% rozsah x-ových hodnot pro druhý paprsek
t_2 = linspace(0,3*c/4,100);

% Vytvoření matice pro uložení hodnot druhého paprsku
ray_2 = zeros(length(t_2), 2);

% Vypočet hodnot druhého paprsku v závislosti na jeho úhlu lomu
for i = 1:sample_size
    beta_r = (beta1(i) - betad);
    betar_radian = beta_r * pi / 180;
    direction = [cos(betar_radian), sin(betar_radian)];
    ray_2(:,:,i) = repmat(D, length(t_2), 1) + t_2' * direction;
end

% Výpočet souřadnic bodů, ve kterých druhý paprsek opouští hranol, jsou to
% zároveň počáteční body třetího paprsku
[intersection_point_1_x,intersection_point_1_y] = lineIntersect(B(1), B(2), C(1), C(2), D(1), D(2), ...
            ray_2(100, 1, 1), ray_2(100, 2, 1));

P1 = [intersection_point_1_x,intersection_point_1_y];

[intersection_point_2_x,intersection_point_2_y] = lineIntersect(B(1), B(2), C(1), C(2), D(1), D(2), ...
            ray_2(100, 1, sample_size), ray_2(100, 2, sample_size));

P2 = [intersection_point_2_x,intersection_point_2_y];

intersection_points_x = linspace(P1(1),P2(1),sample_size);
intersection_points_y = linspace(P1(2),P2(2),sample_size);

points = [intersection_points_x', intersection_points_y'];
end