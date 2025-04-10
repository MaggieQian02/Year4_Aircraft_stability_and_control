% Transfer function
theta_deltaE = tf([-2.637, -2.475, -0.0607],[1, 1.6366, 3.4115, 0.07937, 0.05112]);
servo = tf(10, [1, 10]);
% Integral control
Ki = 0.3;
Kd = 0.7;
ID = tf([Kd,1,Ki],[1,0]); 
% Proportional control
K = -1.2; % negative value

% system and feedback
sys = K * ID * servo *theta_deltaE;
sys_clean = (-1) * servo *theta_deltaE;
sys_cl = feedback(sys, 1);
sys_cl_clean = feedback(sys_clean, 1);

% % Plot the root locus
% figure;
% rlocus(sys);
% % grid on;
% title('Root Locus with Open-Loop System (theta-theta_C)');

figure;
rlocus(sys);
% grid on;
hold on;
closed_loop_poles = rlocus(sys,-K);
% Plot the closed-loop poles on the root locus
plot(real(closed_loop_poles), imag(closed_loop_poles), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
title('Root Locus for Pitch AutoPilot');

% Step response
% figure;
% [step_y, step_t] = step(sys); % Get step response data
% plot(step_t, step_y, 'b-'); 
% grid on;
% title(sprintf('Open-Loop Step Response with K = %.3f', K));

figure;
[step_y_cl, step_t_cl] = impulse(sys_cl); % Get step response data
plot(step_t_cl, step_y_cl, 'b-'); 
hold on;
[step_y_open, step_t_open] = impulse(sys); % Get step response data
plot(step_t_open, step_y_open, 'k-'); 
hold on;
yline(0, 'r-', 'Reference = 0'); % Dashed red line at y = 1
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
% ylim([0 1.2]); % Set y-axis limits from 0 to 1.2
xlim([0 6.5]);
title(sprintf('Impulse Response for Pitch Autopilot with K = %.3f', K));
legend('Closed-loop', 'Open-loop');
hold off;

figure;
[step_y_cl, step_t_cl] = step(sys_cl); % Get step response data
plot(step_t_cl, step_y_cl, 'b-'); 
hold on;
[step_y_open, step_t_open] = step(sys_cl_clean); % Get step response data
plot(step_t_open, step_y_open, 'k-'); 
hold on;
yline(1, 'r-', 'Reference = 1'); % Dashed red line at y = 1
yline(1.1, 'k--');
yline(0.95, 'k--');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
ylim([0 1.2]); % Set y-axis limits from 0 to 1.2
% xlim([0 50]);
title(sprintf('Step Response for Pitch Autopilot with K = %.3f', K));
legend('with PID controller', 'servo * Aircraft');
hold off;


figure;
[step_y_cl, step_t_cl] = step(sys_cl); % Get step response data
plot(step_t_cl, step_y_cl, 'b-'); 
hold on;
yline(1, 'r-', 'Reference = 1'); % Dashed red line at y = 1
yline(1.1, 'k--');
yline(0.95, 'k--');
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
ylim([0 1.2]); % Set y-axis limits from 0 to 1.2
% xlim([0 50]);
title(sprintf('Step Response for Pitch Autopilot with K = %.3f', K));
hold off;

% === Steady-State Error Calculation ===
steady_state_value = step_y_cl(end); % Last value of the response
steady_state_error = abs(1 - steady_state_value) * 100; % Percentage error
fprintf('Steady-State Error: %.2f%% (Final Value: %.4f)\n', steady_state_error, steady_state_value);

[wn_closed, zeta_closed, poles_closed] = damp(sys_cl);

disp(['===== CLOSED-LOOP SYSTEM (With Yaw Damper) =====']);
disp('CLosed-Loop Damping Ratio: Spiral/Dutch/Dutch/Roll/Roll');
disp(zeta_closed);
disp('Natural Frequency');
disp(wn_closed);
disp('Poles of the Closed-Loop System:');
disp(poles_closed);
