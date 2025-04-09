figure(1);
data = load("SPPO_deltae_to_theta.mat");

Time_1 = data.Time;
Elevator_1 = data.Elevator;
% Alpha_1 = data.Alpha;
Ptchrt_1 = data.Ptchrt;

TimeFiltered_1 = Time_1(32:202,:);
TimeFiltered = Time_1(43:202,:);
ElevatorFiltered = Elevator_1(43:202,:);
% AlphaFiltered = Alpha_1(43:202,:);
PtchrtFiltered = Ptchrt_1(32:202,:);

% Create a tiled layout with 3 rows and 1 column
t = tiledlayout(3,1,'TileSpacing','none');

nexttile;
plot(Time, Elevator);
%plot(TimeFiltered, ElevatorFiltered);  % Example for pitch rate in SPPO
xlabel('Time (s)');     
ylabel('Elevator Deflection (deg)');
title('Elevator Deflection Time History');
grid on;

% nexttile;
% %plot(TimeFiltered, AlphaFiltered);  % Example for pitch rate in SPPO
% plot(Time, Alpha);
% Alpha_Fit = secondOrd(6.7,3.2,0.43,3.3,0.7813,TimeFiltered);
% hold on;
% plot(TimeFiltered, Alpha_Fit);
% hold off;
% xlabel('Time (s)');
% ylabel('Angle of Attack (deg)');
% title('Angle of Attack Time History');
% grid on;

nexttile;
%plot(TimeFiltered, PtchrtFiltered);% Example for pitch rate in SPPO
plot(Time, Ptchrt); 
hold on;
% Ptchrt_Fit = secondOrd(38,-1,0.5,2.6,0.5313,TimeFiltered);

% plot(TimeFiltered, Ptchrt_Fit);
hold off;
xlabel('Time (s)');
ylabel('Pitch Rate (deg)');
title('Pitch Rate Time History');
grid on;


% figure(2);
% %plot(TimeFiltered, AlphaFiltered);  % Example for pitch rate in SPPO
% plot(TimeFiltered, AlphaFiltered);
% Alpha_Fit = secondOrd(6.7,3.2,0.43,3.3,0.7813,TimeFiltered);
% hold on;
% plot(TimeFiltered, Alpha_Fit); 
% hold off;
% xlabel('Time (s)');
% ylabel('Angle of Attack (deg)');
% title('Angle of Attack Time History');
% grid on;

figure(3);
%plot(TimeFiltered, AlphaFiltered);  % Example for pitch rate in SPPO
plot(TimeFiltered_1, PtchrtFiltered);
hold on;
% Ptchrt_Fit = secondOrd(38,-1,0.5,2.6,0.5313,TimeFiltered_1);
Ptchrt_Fit = secondOrd(23,-1,0.43,3.3,0.3,TimeFiltered_1);
plot(TimeFiltered_1, Ptchrt_Fit);
hold off;
xlabel('Time (s)');
ylabel('Pitch Rate (deg)');
title('Pitch Rate Time History');
grid on;


