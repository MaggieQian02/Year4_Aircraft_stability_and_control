% Create a tiled layout with 3 rows and 1 column
t = tiledlayout(3,1,'TileSpacing','none');

nexttile;
plot(Time, Rudder);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Rudder Deflection (deg)');
title('Rudder Deflection Time History');
grid on;

nexttile;
plot(Time, Sideslip);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Sideslip (deg)');
title('Sideslip Time History');
grid on;

nexttile;
plot(Time, Yawrt);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Yaw Rate (deg)');
title('Yaw Rate Time History');
grid on;