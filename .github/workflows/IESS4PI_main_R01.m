%% PARAMETERS
sampling_time = 0.1; % [s]
Fs = 1/sampling_time; % sampling frequency [Hz]

%% IMPORT DATA
DataImportISS;

UTCtime = datetime(data.Datetime,'ConvertFrom','epochtime','TicksPerSecond',1,'Format','dd-MMM-yyyy HH:mm:ss.SSS');
UTCtime.TimeZone = 'UTC';
%LocalTime = datetime(UTCtime,'TimeZone',TimeZone);

%UTCtime = data.Date + timeofday(data.time);
%UTCtime.Format = 'dd/MM/yy HH:mm:ss.SSS';

%% Analysis on sampling time
diff_time = diff(data.Datetime);
figure
plot(UTCtime(2:end),diff_time);
xlabel('time')
ylabel('sampling time [s]')
title('Sampling time')
grid on;
ha = gca;
set(ha,'FontSize',24)

mean_time = mean(diff_time);
std_time = std(diff_time);

%% RESAMPLING AND DERIVATIVE

time_initial = data.Datetime(1);
time_end = data.Datetime(end);
new_time = time_initial : sampling_time : time_end;

UTC_new_time = datetime(new_time,'ConvertFrom','epochtime','TicksPerSecond',1,'Format','dd-MMM-yyyy HH:mm:ss.SSS');
UTC_new_time.TimeZone = 'UTC';

roll_resampled = interp1(UTCtime, data.roll,UTC_new_time) * pi / 180; % [radians]
pitch_resampled = interp1(UTCtime, data.pitch,UTC_new_time) * pi / 180; % [radians]
yaw_resampled = interp1(UTCtime, data.yaw,UTC_new_time) * pi / 180; % [radians]

roll_resampled_der = diff(roll_resampled) / sampling_time;
pitch_resampled_der = diff(pitch_resampled) / sampling_time;
yaw_resampled_der = diff(yaw_resampled) / sampling_time;

data.roll_der = interp1(UTC_new_time(2:end), roll_resampled_der,UTCtime);
data.pitch_der = interp1(UTC_new_time(2:end), pitch_resampled_der,UTCtime);
data.yaw_der = interp1(UTC_new_time(2:end), yaw_resampled_der,UTCtime);

%% ROLL DERIVATIVE, YAW DERIVATIVE, PITCH DERIVATIVE
figure
tiledlayout(3,1)
ax1 = nexttile;
plot(UTC_new_time(2:end), roll_resampled_der,LineWidth=2);
xlabel('time')
ylabel('[rad / s]')
title('Pitch derivative')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax2 = nexttile;
plot(UTC_new_time(2:end), pitch_resampled_der,LineWidth=2);
xlabel('time')
ylabel('[rad / s]')
title('Roll derivative')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax3 = nexttile;
plot(UTC_new_time(2:end), yaw_resampled_der,LineWidth=2);
xlabel('time')
ylabel('[rad / s]')
title('Yaw derivative')
grid on;
ha = gca;
set(ha,'FontSize',18)
linkaxes([ax1 ax2 ax3],'x')

%% ROLL, YAW, PITCH
figure
tiledlayout(3,1)
ax1 = nexttile;
plot(UTCtime, data.roll,LineWidth=2);
xlabel('time')
ylabel('[°]')
title('Pitch')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax2 = nexttile;
plot(UTCtime, data.pitch,LineWidth=2);
xlabel('time')
ylabel('[°]')
title('Roll')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax3 = nexttile;
plot(UTCtime, data.yaw,LineWidth=2);
xlabel('time')
ylabel('[°]')
title('Yaw')
grid on;
ha = gca;
set(ha,'FontSize',18)
linkaxes([ax1 ax2 ax3],'x')

%% ACC_X, ACC_Y, ACCC_Z
figure
tiledlayout(3,1)
ax1 = nexttile;
plot(UTCtime, data.acc_x,LineWidth=2);
xlabel('time')
ylabel('[Gs]')
title('Accel x')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax2 = nexttile;
plot(UTCtime, data.acc_y,LineWidth=2);
xlabel('time')
ylabel('[Gs]')
title('Accel y')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax3 = nexttile;
plot(UTCtime, data.acc_z,LineWidth=2);
xlabel('time')
ylabel('[Gs]')
title('Accel z')
grid on;
linkaxes([ax1 ax2 ax3],'x')
ha = gca;
set(ha,'FontSize',18)

%% MAG_X, MAG_Y, MAG_Z
figure
tiledlayout(3,1)
ax1 = nexttile;
plot(UTCtime, data.comp_x,LineWidth=2);
xlabel('time')
ylabel('[µT]')
title('Magnet x')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax2 = nexttile;
plot(UTCtime, data.comp_y,LineWidth=2);
xlabel('time')
ylabel('[µT]')
title('Magnet y')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax3 = nexttile;
plot(UTCtime, data.comp_z,LineWidth=2);
xlabel('time')
ylabel('[µT]')
title('Magnet z')
grid on;
linkaxes([ax1 ax2 ax3],'x')
ha = gca;
set(ha,'FontSize',18)

%% SUNLIT
figure
plot(UTCtime, data.Sunlit,LineWidth=2);
xlabel('time')
title('Sunlit')
ylabel('[0 = dark, 1 = light]')
grid on;
ha = gca;
set(ha,'FontSize',24)

%% ELEVATION
plot(UTCtime, data.Elevation,LineWidth=12);
xlabel('time')
ylabel('[Km]')
title('Elevation')
ha = gca;
set(ha,'FontSize',24)
grid on;

%% COLORS
figure
subplot(311)
plot(UTCtime, data.blue,LineWidth=2);
xlabel('time')
title('Blue')
grid on;
ylim([0 25])
ha = gca;
set(ha,'FontSize',18)
subplot(312)
plot(UTCtime, data.red,LineWidth=2,Color = [0.8500 0.3250 0.0980]);
xlabel('time')
title('Red')
grid on;
ylim([0 25])
ha = gca;
set(ha,'FontSize',18)
subplot(313)
plot(UTCtime, data.green,LineWidth=2, Color = [0.4660 0.6740 0.1880]);
xlabel('time')
title('Green')
grid on;
ha = gca;
set(ha,'FontSize',18)
ylim([0 25])

%% COLORS
figure
plot(UTCtime, data.blue,LineWidth=2);
hold on;
plot(UTCtime, data.red,LineWidth=2,Color = [0.8500 0.3250 0.0980]);
plot(UTCtime, data.green,LineWidth=2, Color = [0.4660 0.6740 0.1880]);
xlabel('time')
title('Colors on ISS')
legend('Blue','Red','Green')
grid on;
ha = gca;
set(ha,'FontSize',18)
ylim([0 25])


%% PLOTS IN MAPS
% 'darkwater', 'grayland', 'bluegreen', 'grayterrain', 'colorterrain',
% 'landcover', 'streets', 'streets-light', 'streets-dark', 'satellite',
% 'topographic', 'none'
figure
geoplot(data.Latitude,data.Longitude,'color',[0.8500 0.3250 0.0980],'Marker','.','LineStyle','none')
geobasemap('darkwater')

%
figure
geoplot(data.Latitude,data.Longitude,'color',[0.8500 0.3250 0.0980],'Marker','.','LineStyle','none')
geobasemap('darkwater')
hold on;
roll_der_threshold = 0.1;
I = find(data.roll_der > roll_der_threshold);
geoscatter(data.Latitude(I),data.Longitude(I),'filled','MarkerFaceColor',[0 0.4470 0.7410]);

figure
I1 = find(data.Elevation <= 420);
I2 = find(data.Elevation > 420 & data.Elevation <= 430);
I3 = find(data.Elevation > 430);
geoscatter(data.Latitude(I1),data.Longitude(I1),'filled','MarkerFaceColor',[0 0.4470 0.7410],'LineWidth',40);
hold on;
geoscatter(data.Latitude(I2),data.Longitude(I2),'filled','MarkerFaceColor',[0.9290 0.6940 0.1250],'LineWidth',40);
geoscatter(data.Latitude(I3),data.Longitude(I3),'filled','MarkerFaceColor',[0.8500 0.3250 0.0980],'LineWidth',40);
legend('410 km < Elevation <= 420 km','420 km < Elevation <= 430 km','430 km < Elevation <= 440 km')
title('ISS Elevation on the map')
ha = gca;
set(ha,'FontSize',24)

%% FREQUENCY ANALYSIS

[f_x, FFT_x] = FFT(data.acc_x,Fs);
[f_y, FFT_y] = FFT(data.acc_y,Fs);
[f_z, FFT_z] = FFT(data.acc_z,Fs);

figure
tiledlayout(3,1)
ax1 = nexttile;
plot(f_x,FFT_x,'LineWidth',2)
xlabel('frequency')
title('FFT accel x')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax2 = nexttile;
plot(f_y,FFT_y,'LineWidth',2);
xlabel('frequency')
title('FFT accel y')
grid on;
ha = gca;
set(ha,'FontSize',18)
ax3 = nexttile;
plot(f_z,FFT_z,'LineWidth',2);
xlabel('frequency')
title('FFT accel z')
grid on;
linkaxes([ax1 ax2 ax3],'x')
ha = gca;
set(ha,'FontSize',18)


[f_e, FFT_e] = FFT(detrend(data.Elevation),Fs);
figure
plot(f_e,FFT_e,'LineWidth',2)
xlabel('frequency')
title('FFT elevation')
ha = gca;
set(ha,'FontSize',18)