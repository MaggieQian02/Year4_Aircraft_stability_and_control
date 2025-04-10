% Transfer function
Aileron_Rollang = tf([-4.748, -2.957, -11.16],[1, 4.2, 3.926, 8.6, -0.2042]);
servo = tf(20, [1, 20]);
K = -0.7; % negative value 0.84

% Dynamic compensator (Phase lead needed)
a = 16;
b = 15;
DynComp = tf([b,a*b],[a,a*b]);

% system and feedback
sys = K * servo * Aileron_Rollang;
sys_clean = (-0.05) * servo * Aileron_Rollang;
sys_open = K * servo * Aileron_Rollang;
sys_cl = feedback(sys, 1);
sys_cl_clean = feedback(sys_clean, 1);
% sys_cl_comp = feedback(sys_comp, 1);

% % Plot the root locus
% figure;
% rlocus(sys);
% % grid on;
% hold on;
% closed_loop_poles = rlocus(sys,-K);
% % Plot the closed-loop poles on the root locus
% plot(real(closed_loop_poles), imag(closed_loop_poles), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
% title(sprintf('Root Locus for Roll Angle Autopilot with K = %.3f', K));

% figure;
% rlocus(sys_comp);
% % grid on;
% title('Root Locus with Open-Loop System (with compensator)');

% Step response
figure;
[step_y, step_t] = step(sys_cl); % Get step response data
plot(step_t, step_y, 'b-'); 
hold on;
yline(1, 'r--', 'Reference = 1'); % Dashed red line at y = 1
yline(1.1, 'k--'); 
yline(0.95, 'k--'); 
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title(sprintf('Closed-Loop Step Response with K = %.3f', K));
hold off;


figure;
[impulse_y_cl, impulse_t_cl] = impulse(sys_cl); % Get step response data
plot(impulse_t_cl, impulse_y_cl, 'b-'); 
hold on;
[impulse_y, impulse_t] = impulse(sys); % Get step response data
plot(impulse_t, impulse_y, 'k-'); 
hold on;
hold on;
yline(0, 'r-', 'Reference = 0'); % Dashed red line at y = 1
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
% ylim([0 1.2]); % Set y-axis limits from 0 to 1.2
xlim([0 25]);
title(sprintf('Impulse Response with K = %.3f', K));
legend('Closed-loop','Open-loop');
hold off;

% figure;
% [impulse_y_cl, impulse_t_cl] = impulse(sys_cl); % Get step response data
% plot(impulse_t_cl, impulse_y_cl, 'b-'); 
% hold on;
% [impulse_y_comp, impulse_t_comp] = impulse(sys_cl_comp);
% plot(impulse_t_comp, impulse_y_comp, 'r-');
% legend ('base', 'with compensator');
% grid on;
% xlabel('Time (s)');
% ylabel('Amplitude');
% % ylim([0 1.2]); % Set y-axis limits from 0 to 1.2
% title(sprintf('Impulse Response with K = %.3f', K));
% hold off;

figure;
[step_y, step_t] = step(sys_cl); % Get step response data
plot(step_t, step_y, 'b-'); 
hold on;
[step_y_open, step_t_open] = step(sys_cl_clean); % Get step response data,sys_cl_clean
plot(step_t_open, step_y_open, 'k-'); 
hold on;
yline(1, 'r-', 'Reference = 1'); % Dashed red line at y = 1
hold on;
yline(1.1, 'k--'); % Dashed red line at y = 1
yline(0.95, 'k--'); % Dashed red line at y = 1
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0 20]); % Set y-axis limits from 0 to 1.2
title(sprintf('Step Response for Roll Angle Autopilot with K = %.3f', K));
legend('with Compensator', 'without Compensator');
hold off;

% === Steady-State Error Calculation ===
steady_state_value = step_y(end); % Last value of the response
steady_state_error = abs(1 - steady_state_value) * 100; % Percentage error
fprintf('Steady-State Error: %.2f%% (Final Value: %.4f)\n', steady_state_error, steady_state_value);



[wn_closed, zeta_closed, poles_closed] = damp(sys_cl);


disp('===== CLOSED-LOOP SYSTEM (with compensator) =====');
disp('Closed-Loop Damping Ratio:');
disp(zeta_closed);
disp('Natural Frequency');
disp(wn_closed);
disp('Poles of the Closed-Loop System:');
disp(poles_closed);

figure;
bode(sys_cl);
margin(sys_cl);
grid on;

% figure;
% bode(sys_cl_clean);
% margin(sys_cl_clean);
% grid on;

% Find the dominant unstable pole (largest real part)
sigma = max(real(poles_closed));  

% Compute the time to double
if sigma > 0
    Td = log(2) / sigma;
    fprintf('Time to double for spiral: %.4f seconds\n', Td);
else
    fprintf('System is stable, no doubling time.\n');
end


pole_5 = poles_closed(5);
tau_5 = -1 / real(pole_5);
fprintf('Time Constant for roll subsidence: %.4f seconds\n', tau_5);

% Plot the root locus
figure;
rlocus(sys);
% grid on;
hold on;
closed_loop_poles = poles_closed;
% Plot the closed-loop poles on the root locus
plot(real(closed_loop_poles), imag(closed_loop_poles), 'r+', 'MarkerSize', 5, 'LineWidth', 0.5);
title(sprintf('Root Locus for Roll Angle Autopilot with K = %.3f', K));