function [ray_3] = ray_3_parameters(n,n1,omega,beta1,betad,points ...
    ,c,sample_size,normalBC)

% Úhel pod kterým dopadá druhý paprsek na vnitřní stranu hranolu
beta2 = omega - beta1;

% Úhel pod kterým dopadá druhý paprsek láme a vzniká tak tŘetí paprsek
alpha2 = asind(n.*sind(beta2)/n1);
gammad = omega/2;

t_3 = linspace(0,2*c,100); % rozsah x-ových hodnot pro třetí paprsek

% Vytvoření matice pro uložení hodnot třetího paprsku
ray_3 = zeros(length(t_3), 2);

% Vypočet hodnot druhého paprsku v závislosti na jeho úhlu lomu
    for i = 1:sample_size
        beta_r = (beta1(i) - betad);
        betar_radian = beta_r * pi / 180;
        direction = [cos(betar_radian), sin(betar_radian)];
        dot_product = dot(direction, normalBC);
        direction2 = direction - 2 * dot_product * normalBC;
       
        gamma_r = 180 - gammad -(90-alpha2(i))-90;
        gamma_radian = gamma_r * pi / 180;
        direction3 = [cos(gamma_radian), -sin(gamma_radian)];
        
        if alpha2(:,i) >= 90
            ray_3(:,:,i) = repmat(points(i,:), length(t_3),1) + t_3' .* direction2(:,:);
        else
            ray_3(:,:,i) = repmat(points(i,:), length(t_3),1) + t_3' .* direction3(:,:);
        end
    end
end