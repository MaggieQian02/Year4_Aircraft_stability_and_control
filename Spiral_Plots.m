
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
Rollang_ln = log(Rollang);
xlabel('Time (s)');
ylabel('Roll Angle (deg)');
title('Roll Angle Time History');
grid on;

nexttile;
plot(Time, Rollrt);  % Example for pitch rate in SPPO
hold on;
% plot();
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
Rollang_ln = log(Rollang);
plot(Time, Rollang_ln); 
xlabel('Time (s)');
ylabel('ln (Roll Angle)');
title('Roll Angle Time History');
grid on;

