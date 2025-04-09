figure(1);
data = load("SPPO_deltae_to_theta.mat");
t = tiledlayout(2,1,'TileSpacing','none');

% dele=Elevator-mean(Elevator(Time<0.4688));
% q=Ptchrt-mean(Ptchrt(Time<0.4688));
dele=Elevator-mean(Elevator(Time<1.8));
q=Ptchrt-mean(Ptchrt(Time<1.8));
uniform_Time = linspace(min(Time), max(Time), length(Time));

[omega,xfeq] = xfer_1(uniform_Time,dele,q);
%nexttile;
%semilogy(omega,abs(xfeq));   
%ylabel('amplitude');
% title('frequency response');
% grid on;

% nexttile;
% rad_xfeq = angle(xfeq);
% deg_xfeq = rad2deg(rad_xfeq);
% plot(omega, rad_xfeq);    
% ylabel('phase');
% grid on;

wn_spo = 1.836;
zeta_spo = 0.441;

wn_phugoid = 0.123;
zeta_phugoid = 0.066;
roots_vec = [-0.007011+0.123i, -0.007011-0.123i, -0.903+1.897i, -0.903-1.897i];
% Compute the poles
% poles = [-zeta_spo*wn_spo + 1i*wn_spo*sqrt(1 - zeta_spo^2), ...
%          -zeta_spo*wn_spo - 1i*wn_spo*sqrt(1 - zeta_spo^2), ...
%          -zeta_phugoid*wn_phugoid + 1i*wn_phugoid*sqrt(1 - zeta_phugoid^2), ...
%          -zeta_phugoid*wn_phugoid - 1i*wn_phugoid*sqrt(1 - zeta_phugoid^2)];
den = poly(roots_vec);
den = real(den);
[num,xfeqf] = fitxf_1(omega,xfeq,den,20,3);
display(num);
display(den);

n=60;
omegaFiltered = omega(1:n, :);
xfeqFiltered = xfeq(1:n, :);
xfeqfFiltered = xfeqf(1:n, :);


nexttile;
semilogy(omegaFiltered, abs(xfeqFiltered), omegaFiltered, abs(xfeqfFiltered));
% semilogy(omegaFiltered, abs(xfeqFiltered)); 
ylabel('amplitude');
grid on;

nexttile;
plot(omegaFiltered, angle(xfeqFiltered), omegaFiltered, angle(xfeqfFiltered));
% plot(omegaFiltered, angle(xfeqFiltered));
xlabel('omega(rad/s)');     
ylabel('phase');
grid on;