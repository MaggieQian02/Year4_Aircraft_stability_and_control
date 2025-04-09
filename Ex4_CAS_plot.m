% Constants
g = 9.81;
Lp = 1.65;
U = 92.7;

K = -0.13;
scale = 0.56;

K_feed = 1;
servo = tf(10, [1, 10]);

%Kd = 0.5;
%Kd_s = tf([Kd,0],[1]);

% Dynamic compensator (Phase lead needed)
a = 4;
b = 18;
DynComp = tf([b,a*b],[a,a*b]);

% C* transfer function
C_star = tf([-0.0014167, -32.7059, -30.7315, -0.7551, 0.], [1, 1.6360, 3.4115, 0.07937, 0.05112]);

[cst,cslo,csup] = csenv(scale);

% System and feedback
sys = K *DynComp * servo * C_star;
sys_cl = feedback(sys, K_feed);

% Compute poles
%poles_open = pole(sys);   % Open-loop poles
%poles_closed = pole(sys_cl); % Closed-loop poles

% Plot Root Locus for Open and Closed Loop Systems
figure;
rlocus(sys); % Open-loop root locus
hold on;
%rlocus(sys_cl); % Closed-loop root locus
closed_loop_poles = rlocus(sys_cl,-K);
% Plot the closed-loop poles on the root locus
plot(real(closed_loop_poles), imag(closed_loop_poles), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
title(sprintf('Root Locus for Roll Angle Autopilot with K = %.3f', K));
hold off;

figure;
plot(cst, cslo, 'r--', cst, csup, 'r--'); % Plot x vs. y1 and x vs. y2 with markers
xlabel('Time (s)');
ylabel('Amplitude');
hold on;
% Plot the step response of sys
[step_y_cl, step_t_cl] = step(sys_cl); % Get step response data
plot(step_t_cl, step_y_cl, 'b-'); 
grid on;
title(sprintf('Closed-Loop Step Response with K = %.3f', K));
% Set time limits from 0 to 3 seconds
xlim([0 3]);
% Auto-scale the y-axis
ylim auto;
hold off;

[wn_closed, zeta_closed, poles_closed] = damp(sys_cl);
disp(['===== CLOSED-LOOP SYSTEM =====']);
disp('CLosed-Loop Damping Ratio');
disp(zeta_closed);
disp('Natural Frequency');
disp(wn_closed);
disp('Poles of the Closed-Loop System:');
disp(poles_closed);