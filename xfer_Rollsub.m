figure(1);
%data = load("data_2024/Spiral.mat");
t = tiledlayout(2,1,'TileSpacing','none');

Aileron_cut = Aileron;
Rollrt_cut = Rollrt;

dele=Aileron-mean(Aileron_cut(Time<2));
ran=Rollrt-mean(Rollrt_cut(Time<2));
uniform_Time = linspace(min(Time), max(Time), length(Time));

[omega,xfeq] = xfer_1(uniform_Time,dele,ran);

% roots_vec = [-0.228+1.502i, -0.228-1.502i, -0.147, -25.18];
T_rollsubs = 0.2495;

zeta_dutchroll = 0.15; % Dutch roll damping ratio
wn_dutchroll = 1.519; % Dutch roll natural frequency (rad/s)


T_spiral = 42.6;

% Compute the poles
poles = [-1/T_rollsubs, ...
         -zeta_dutchroll * wn_dutchroll + 1i * wn_dutchroll * sqrt(1 - zeta_dutchroll^2), ...
         -zeta_dutchroll * wn_dutchroll - 1i * wn_dutchroll * sqrt(1 - zeta_dutchroll^2), ...
         -1/T_spiral]; % Spiral mode pole
den = poly(poles);
den = real(den);
display(den);
[num,xfeqf] = fitxf_1(omega,xfeq,den,3,3);
display(num);

n=100;
omegaFiltered = omega(1:n, :);
xfeqFiltered = xfeq(1:n, :);
xfeqfFiltered = xfeqf(1:n, :);

nexttile;
semilogy(omegaFiltered, abs(xfeqFiltered), omegaFiltered, abs(xfeqfFiltered));    
ylabel('amplitude');
grid on;

nexttile;
plot(omegaFiltered, angle(xfeqFiltered), omegaFiltered, angle(xfeqfFiltered));
xlabel('omega(rad/s)');     
ylabel('phase');
grid on;