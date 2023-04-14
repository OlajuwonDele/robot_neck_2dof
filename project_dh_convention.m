clear variables

r_b = 45;
L_mount = 11.5;
L_pam = 190; %length PAM 
L_connector = 3+12;
L_permissible_max = L_pam + 2*L_mount + 2*L_connector; %treat PAM and universal joint from top and both as collinear
L_permissible_min = L_permissible_max - 40;          
origin = [0;0;0;1];
%r_t = 45;
lengthSim = 100;

%for L_mount = 1:1:100
    for L_jointi = 1:1:lengthSim
        L_joint = L_jointi;
        for L_supporti = 1:1:lengthSim
            L_support = L_supporti + 100;
            for irt = 1:1:lengthSim
                r_t = irt;
                %config_capab(L_mount, L_jointi, L_supporti, irt)  = true;
                %contractionTot(L_mount, L_jointi, L_supporti,irt) = 0;

                config_capab(L_jointi, L_supporti, irt)  = true;
                contractionTot(L_jointi, L_supporti,irt) = 0;
                
                for ipitch = -20:1:20
                    %if config_capab(L_mount, L_jointi, L_supporti,irt) == false
                    if config_capab(L_jointi, L_supporti,irt) == false
                        break
                    end
                   
                    pitch = ipitch;
                    
                    for iroll = -20:1:20
                        roll = iroll;
                        
                        b1_a = r_b;
                        b1_alpha = 0;
                        b1_d = L_mount;
                        b1_theta = 0;
                        
                        b2_a = r_b;
                        b2_alpha = 0;
                        b2_d = L_mount;
                        b2_theta = 120;
                        
                        b3_a = r_b;
                        b3_alpha = 0;
                        b3_d = L_mount;
                        b3_theta = 240;
                        
                        tb1 = DHConvention(b1_a, b1_alpha, b1_d, b1_theta);
                        tb2 = DHConvention(b2_a, b2_alpha, b2_d, b2_theta);
                        tb3 = DHConvention(b3_a, b3_alpha, b3_d, b3_theta);
                        
                        pb1 = tb1*origin;
                        pb2 = tb2*origin;
                        pb3 = tb3*origin;
                        
                        pb1 = pb1(1:3);
                        pb2 = pb2(1:3);
                        pb3 = pb3(1:3);
                        
                        ujoint_aP= 0;
                        ujoint_alphaP = pitch;
                        ujoint_dP = L_support;
                        ujoint_thetaP = 0;
                        
                        ujoint_aR= 0;
                        ujoint_alphaR = roll;
                        ujoint_dR = 0;
                        ujoint_thetaR = 90;
                        
                        tujoint = DHConvention(ujoint_aP, ujoint_alphaP, ujoint_dP, ujoint_thetaP) * DHConvention(ujoint_aR, ujoint_alphaR, ujoint_dR, ujoint_thetaR);
                        pujoint = tujoint * origin;
                        pujoint = pujoint(1:3);
                        
                        c_a = 0;
                        c_alpha = 90;
                        c_theta = -90;
                        c_d = L_joint;
                        
                        tc = DHConvention(c_a, c_alpha, c_d, c_theta);
                        talpha90 = DHConvention(0, -90, 0, 0);
                        pc = tujoint * tc * talpha90 * origin;
                        pc = pc(1:3);
                        
                        t1_a = r_t;
                        t1_alpha = 0;
                        t1_d = -L_mount;
                        t1_theta = 0;
                        
                        t2_a = r_t;
                        t2_alpha = 0;
                        t2_d = -L_mount;
                        t2_theta = 120;
                        
                        t3_a = r_t;
                        t3_alpha = 0;
                        t3_d = -L_mount;
                        t3_theta = 240;
                        
                        tt1 = DHConvention(t1_a, t1_alpha, t1_d, t1_theta);
                        tt2 = DHConvention(t2_a, t2_alpha, t2_d, t2_theta);
                        tt3 = DHConvention(t3_a, t3_alpha, t3_d, t3_theta);
                        
                        pt1 = tujoint * tc * talpha90 * tt1 * origin;
                        pt2 = tujoint * tc * talpha90 * tt2 * origin;
                        pt3 = tujoint * tc * talpha90 * tt3 * origin;
                        
                        pt1 = pt1(1:3);
                        pt2 = pt2(1:3);
                        pt3 = pt3(1:3);
                        
                        L_pam1 = sqrt((pt1(1)-pb1(1))^2 + (pt1(2)-pb1(2))^2 + (pt1(3)-pb1(3))^2);
                        L_pam2 = sqrt((pt2(1)-pb2(1))^2 + (pt2(2)-pb2(2))^2 + (pt2(3)-pb2(3))^2);
                        L_pam3 = sqrt((pt3(1)-pb3(1))^2 + (pt3(2)-pb3(2))^2 + (pt3(3)-pb3(3))^2);
    
                        contraction_ratio1 = abs(100 * (L_pam - L_pam1)/ L_pam);
                        contraction_ratio2 = abs(100 * (L_pam - L_pam2)/ L_pam);
                        contraction_ratio3 = abs(100 * (L_pam - L_pam3)/ L_pam);

                        %we want r_t big as possible incase pams clash
                        %joint must be capable of fitting 25mm
                        %potentiometer
                        if (L_pam1 > L_permissible_max+1) || (L_pam2 > L_permissible_max+1) || (L_pam3 > L_permissible_max+1) || (L_pam1 < L_permissible_min-1) || (L_pam2 < L_permissible_min-1) || (L_pam3 < L_permissible_min-1) % || (r_t < 45) || (L_joint < 35) %|| (L_mount < 30)
                            %disp(['p1 = ', num2str(L_pam1), ' p2 = ', num2str(L_pam2), ' p3 = ', num2str(L_pam3), ' r = ' , num2str(r_t),' L = ' , num2str(L_joint),' pitch = ', num2str(pitch), ' roll = ', num2str(roll)]);
                            config_capab(L_jointi, L_supporti, irt)  = false;
                            contractionTot(L_jointi, L_supporti, irt) = NaN;

                            %config_capab(L_mount, L_jointi, L_supporti, irt)  = false;
                            %contractionTot(L_mount, L_jointi, L_supporti, irt) = NaN;
                            break
                        end
                        
                        contractionTot(L_jointi, L_supporti, irt) = contraction_ratio1 + contraction_ratio2 + contraction_ratio3 + contractionTot(L_jointi, L_supporti, irt);
            
                        %contractionTot(L_mount, L_jointi, L_supporti, irt)
                        %= contraction_ratio1 + contraction_ratio2 + contraction_ratio3 + contractionTot(L_mount, L_jointi, L_supporti, irt);
                    end
                end
            end
        end
    end
%end

[M,I] = max(contractionTot,[],"all","linear");
[dim1, dim2, dim3, dim4] = ind2sub(size(contractionTot),I);
disp(['max = ', num2str(M), ' joint = ', num2str(dim1), ' support = ', num2str(100+dim2), ' r_t = ', num2str(dim3)]);

r_t = 1:1:lengthSim;
L_joint = 1:1:lengthSim;
L_support = (1:1:lengthSim)+100;

%%

figure(1)
hold on
a = scatter3(L_joint,L_support,contractionTot(:,:,dim3),50,"blue", 'filled');
grid on;
xlabel('L_{joint} [mm]'), ylabel('L_{support} [mm]'), zlabel('Contraction Total [%]')
title('Constant R_t = ', num2str(dim3))
hold off


figure(3)
hold on
b = surf(L_joint,L_support,contractionTot(:,:,25));
grid on;
xlabel('L_{joint} [mm]'), ylabel('L_{support} [mm]'), zlabel('Contraction Total [%]')
title('Constant R_t = ', num2str(25))
hold off
%%
function dh = DHConvention(a,alpha,d,theta)
ca = cosd(alpha);
sa = sind(alpha);

c0 = cosd(theta);
s0 = sind(theta);

dh = [c0 -s0*ca s0*sa a*c0; s0 c0*ca -c0*sa a*s0; 0 sa ca d; 0 0 0 1];
end