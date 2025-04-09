% Define the open-loop transfer function
servo = tf(4, [1, 4]);
r_yawr = tf([-2.0959, -6.0649, -3.5650, 1.1943],[1, 4.2, 3.926, 8.6, -0.2042]);
%lowpass = tf(1, [1, 0.5]);  % Example: 1st-order low-pass filter

% Try differentiator 
Kd = 0.5;
Kd_s = tf([Kd,0],[1]);

% Plain system
sys = Kd_s * servo*r_yawr;

K = -1; %25
a = 5; %40
wash_out = tf([1, 0], [1, a]);

feed = K*wash_out;
sys_washout = sys * wash_out;
sys_locus = K*wash_out*sys;
sys_clean = K * servo * r_yawr * wash_out;

sys_cl = feedback(sys, feed);
sys_cl_nowash = feedback(sys, K);
 
 
% Plot the root locus
%figure;
%rlocus(sys_locus);
%hold on;
%closed_loop_poles = rlocus(sys_cl,-K);
%% Plot the closed-loop poles on the root locus
%plot(real(closed_loop_poles), imag(closed_loop_poles), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
%title('Root Locus for Yaw Damper');
%hold off;
 
% Plot the impulse response for all systems in one figure
figure;
impulse(sys_locus, 'r', sys_cl, 'b');
%  sys_cl_nowash, 'g'
grid on;
xlim([0 25]);
 % ylim([-4 8]);
legend('Open-loop System', 'Closed-loop System (with washout)');
title('Impulse Response for Open-loop system (servo*Aircraft)');
 
% % Plot the impulse response for all systems in one figure
% figure;
% step(sys_locus, 'r', sys_cl, 'b');
% grid on;
% xlim([0 25]);
% % legend('Open-loop System', 'Closed-loop System (with washout)');
% title('Step Response for Open-loop and Closed-loop Systems');
 
 
[wn_open, zeta_open, poles_open] = damp(sys);
[wn_closed, zeta_closed, poles_closed] = damp(sys_cl);
% disp('===== OPEN-LOOP SYSTEM =====');
% disp('Open-Loop Damping Ratio: Spiral/Dutch/Dutch/Roll/Roll');
% disp(zeta_open);
% disp('Natural Frequency');
% disp('Poles of the Open-Loop System:');
% disp(poles_open);
disp('===== CLOSED-LOOP SYSTEM (With Yaw Damper) =====');
disp('Closed-Loop Damping Ratio: Spiral/Dutch/Dutch/Roll/Roll');
disp(zeta_closed);
disp('Natural Frequency');
disp(wn_closed);
disp('Poles of the Closed-Loop System:');
disp(poles_closed);
poles = pole(sys_cl);
% Find the dominant unstable pole (largest real part)
sigma = max(real(poles));  
% Compute the time to double
if sigma > 0
    Td = log(2) / sigma;
    fprintf('Time to double: %.4f seconds\n', Td);
else
    fprintf('System is stable, no doubling time.\n');
end
% Mode assignment (based on given ordering)
spiral_idx = 1;            % Spiral mode
dutch_idx  = [3, 4];        % Dutch roll modes
roll_idx   = [5, 6];        % Roll subsidence modes
% Use the minimum damping ratio among the modes for Dutch roll and roll subsidence
zeta_dutch = min(zeta_closed(dutch_idx));
disp(zeta_dutch);
zeta_roll  = min(zeta_closed(roll_idx));
disp(zeta_roll);
% Compute the spiral mode time to double if the mode is unstable
sigma_spiral = max(real(poles_closed(spiral_idx)));
if sigma_spiral > 0
    Td_spiral = log(2) / sigma_spiral;
else
    Td_spiral = Inf; % If spiral mode is stable, set to Inf (no growth)
end
disp(Td_spiral);
figure;
bode(sys_cl);
margin(sys_cl);
 

% Plot the root locus
figure;
rlocus(sys_locus);
hold on;
% Plot the closed-loop poles on the root locus
plot(real(poles_closed), imag(poles_closed), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
title('Root Locus for Yaw Damper');
hold off;

pole_4 = poles_closed(4);
tau_4 = -1 / real(pole_4);
fprintf('Time Constant for roll subsidence: %.4f seconds\n', tau_4);