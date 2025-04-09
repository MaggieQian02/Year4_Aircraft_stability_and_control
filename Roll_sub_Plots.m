
figure(1);
% Create a tiled layout with 3 rows and 1 column
t = tiledlayout(3,1,'TileSpacing','none');

nexttile;
plot(Time, Aileron);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Aileron Deflection (deg)');
title('Aileron Deflection Time History');
grid on;

nexttile;
plot(Time, Rollang);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Roll Angle (deg)');
title('Roll Angle Time History');
grid on;

nexttile;
plot(Time, Rollrt);  % Example for pitch rate in SPPO
hold on;
% Time_fit = Time(62:131);
% Rollang_fit = Roll_sub(0.3,5.5,2,0.2,Time_fit);
% plot(Time_fit, Rollang_fit);
hold off;
xlabel('Time (s)');
ylabel('Roll Rate (deg)');
title('Roll Rate Time History');
grid on;

% nexttile;
% plot(Time, EAS);  % Example for pitch rate in SPPO
% xlabel('Time (s)');
% ylabel('Equivalent Air Speed (knot)');
% title('Equivalent Air Speed Time History');
% grid on;

figure(2);
Time_fit = Time(64:180);
TimeFiltered = Time(55:180);
RollrtFiltered = Rollrt(55:180);
plot(TimeFiltered, RollrtFiltered);  % Example for pitch rate in SPPO
Rollrt_fit = Roll_sub(0.3,5.5,2,0.2,Time_fit);
hold on;
plot(Time_fit, Rollrt_fit);
hold off;
xlabel('Time (s)');
ylabel('Roll Rate (deg)');
title('Roll Rate Time History');
grid on;