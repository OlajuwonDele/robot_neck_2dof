clear variables

r_b = 45;
L_mount = 0;
L_pam = 190; %length PAM 
L_joint = 20;
L_support = 170; 
L_connector = 3+12;
L_permissible =  L_pam + 2*L_mount + 2*L_connector;
L_contract = L_permissible - 40;             
origin = [0;0;0;1];
r_t = 25;
lengthSim = 100;



contractionTot = 0;
for pit = -20:1:20
        pitch = pit;
    for rolli = -20:1:20
        roll = rolli;
        
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
        
        fail(pitch+21,roll+21) = 1;
        if (L_pam1 > L_permissible+1) || (L_pam2 > L_permissible+1) || (L_pam3 > L_permissible+1) || (L_pam1 < L_contract-1) || (L_pam2 < L_contract-1) || (L_pam3 < L_contract-1) 
        disp(['p1 = ', num2str(L_pam1-(2*L_mount + 2*L_connector)), ' p2 = ', num2str(L_pam2-(2*L_mount + 2*L_connector)), ' p3 = ', num2str(L_pam3-(2*L_mount + 2*L_connector)), ' r = ' , num2str(r_t),' L = ' , num2str(L_support),' pitch = ', num2str(pitch), ' roll = ', num2str(roll)]);
        fail(pitch+21,roll+21) = 0;
        end
    
        contractionTot(pitch+21,roll+21) = contraction_ratio1 + contraction_ratio2 + contraction_ratio3;
        
    end
end
contractionTotal = sum(contractionTot, "all");
 %%
pitch = -20:1:20;
roll = -20:1:20;
figure(5)
hold on
e = surf(pitch,roll,contractionTot);
grid on;
xlabel('\theta_p [\circ]'), ylabel('\theta_r [\circ]'), zlabel('Contraction Total [%]')
title('Existing Neck Mechanism Configuration')
hold off
%%  
figure(6)
hold on
surf(pitch,roll,fail);
grid on;
xlabel('\theta_p [\circ]'), ylabel('\theta_r [\circ]'), zlabel('Feasibility')
title('Existing Neck Mechanism Configuration Range of Motion')
hold off

%%

figure(7)
hold on
%{
th = linspace(0,2*pi,100);
circ = bsxfun(@plus,pc,r_t*[cos(th); sin(th); 0*th]);
h = plot3(circ(1,:),circ(2,:),circ(3,:), '');
normalVec = cross(pt1-pt2,pt1-pt3);
RotationAxis = cross([0 0 1], normalVec);
if any(RotationAxis)
RotationAngle = 180/pi*acos([0 0 1].*normalVec'/norm(normalVec));
rotate(h,RotationAxis,RotationAngle,pc);
end
%}

line1 = plot3([pb1(1) pt1(1)],[pb1(2) pt1(2)],[pb1(3) pt1(3)],'r-', 'LineWidth',3);
line11 = plot3([pb1(1) pb1(1)],[pb1(2) pb1(2)],[0 pb1(3)],'b-', 'LineWidth',3);
line12 = plot3([pt1(1) pt1(1)],[pt1(2) pt1(2)],[pt1(3) pt1(3)+L_mount],'b-', 'LineWidth',3);
line2 = plot3([pb2(1) pt2(1)],[pb2(2) pt2(2)],[pb2(3) pt2(3)],'r-', 'LineWidth',3);
line21 = plot3([pb2(1) pb2(1)],[pb2(2) pb2(2)],[0 pb2(3)],'b-', 'LineWidth',3);
line22 = plot3([pt2(1) pt2(1)],[pt2(2) pt2(2)],[pt2(3) pt2(3)+L_mount],'b-', 'LineWidth',3);
line3 = plot3([pb3(1) pt3(1)],[pb3(2) pt3(2)],[pb3(3) pt3(3)],'r-', 'LineWidth',3);
line31 = plot3([pb3(1) pb3(1)],[pb3(2) pb3(2)],[0 pb3(3)],'b-', 'LineWidth',3);
line32 = plot3([pt3(1) pt3(1)],[pt3(2) pt3(2)],[pt3(3) pt3(3)+L_mount],'b-', 'LineWidth',3);
line4 = plot3([origin(1) pujoint(1)],[origin(2) pujoint(2)],[origin(3) pujoint(3)],'k-', 'LineWidth',3);
line5 = plot3([pujoint(1) pc(1)],[pujoint(2) pc(2)],[pujoint(3) pc(3)],'k-', 'LineWidth',3);
daspect([1 1 1])
xlabel('x')
ylabel('y')
zlabel('z')
hold off       

function dh = DHConvention(a,alpha,d,theta)
ca = cosd(alpha);
sa = sind(alpha);

c0 = cosd(theta);
s0 = sind(theta);

dh = [c0 -s0*ca s0*sa a*c0; s0 c0*ca -c0*sa a*s0; 0 sa ca d; 0 0 0 1];
end