% Create a tiled layout with 3 rows and 1 column
data = load("data_2024/Phugoid.mat");
t = tiledlayout(2,1,'TileSpacing','none');

nexttile;
plot(Time, Elevator);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Elevator Deflection (deg)');
title('Elevator Deflection Time History');
grid on;

nexttile;
plot(Time, Ptchang);  % Example for pitch rate in SPPO
xlabel('Time (s)');
ylabel('Pitch Angle (deg)');
title('Pitch Angle Time History');
grid on;