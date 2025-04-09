figure(1);
% data = load("data_2024/Phugoid.mat");
t = tiledlayout(2,1,'TileSpacing','none');

% dele=Elevator-mean(Elevator((46<Time)&(Time<100)));
dele=Elevator-mean(Elevator(Time<0.5));
nz= Nz - mean(Nz(Time<0.5));
% display(mean(Elevator((46<Time)&(Time<100))));
% q=Ptchrt-mean(Ptchrt(Time<0.3));
uniform_Time = linspace(min(Time), max(Time), length(Time));
[omega,xfeq] = xfer_1(uniform_Time,dele,nz);

roots_vec = [-0.007011+0.123i, -0.007011-0.123i, -0.903+1.897i, -0.903-1.897i];
den = poly(roots_vec);
den = real(den);
display(den);
[num,xfeqf] = fitxf_1(omega,xfeq,den,3,3);
display(num);

n=60;
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