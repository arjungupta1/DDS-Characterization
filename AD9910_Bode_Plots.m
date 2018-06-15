% AD9910 Characterization, Frequency vs Amplitude
% @author: Arjun Gupta

clc;
close all;
clear;

frequency_range = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, ...
    70, 80, 90, 100, 200];

sma_100a_DC_Blocker = [-20.68, -20.86, -21.32, -21.30, -21.50, -21.30, ...
    -21.40, -21.18, -21.32, -21.24, -21.67, -21.52, -21.49, -21.37, ...
    -21.63, -21.62, -21.62, -22.10, -21.70, -23.09];
sma_100a_DC_Blocker_Vrms = sqrt((10.^(sma_100a_DC_Blocker/10))/1000*50);
sma_100a_No_DC_Blocker = [-20.99, -20.59, -21.11 ,-21.09, -21.36, -21.16,...
    -21.17, -20.92, -21.11, -21.06, -21.45, -21.40, -21.42, -21.22,...
    -21.55, -21.54, -21.72, -22.00, -21.72, -23.09];
sma_100a_No_DC_Blocker_Vrms = sqrt((10.^(sma_100a_No_DC_Blocker/10))/1000*50);

sma_100_normalized = sma_100a_DC_Blocker - sma_100a_No_DC_Blocker;
sma_100_normalized_Vrms = sma_100a_DC_Blocker_Vrms - sma_100a_No_DC_Blocker_Vrms;

ad9910_pos_no_sinc = [-16.80, -17.02, -17.51, -17.47, -17.71, -17.66,...
    -17.82, -17.56, -17.69, -17.79, -17.96, -17.82, -17.82, -17.86,...
    -18.13, -17.91, -18.20, -18.06, -18.09, -22.19];
ad9910_pos_no_sinc_Vrms = sqrt((10.^(ad9910_pos_no_sinc/10))/1000*50);
ad9910_pos_sinc = [-19.67, -19.77, -20.32, -20.42, -20.62, -20.55,...
    -20.78, -20.56, -20.68, -20.67, -20.85, -20.66, -20.66, -20.77,...
    -20.92, -20.66, -20.82, -20.45, -20.36, -23.08];
ad9910_pos_sinc_Vrms = sqrt((10.^(ad9910_pos_sinc/10))/1000*50);

ad9910_neg_no_sinc = [-16.97, -17.07, -17.56, -17.45, -17.71, -17.66,...
    -17.86, -17.62, -17.74, -17.78, -18.05, -17.92, -17.86, -17.96,...
    -18.17, -18.12, -18.30, -18.33, -18.20, -21.26];
ad9910_neg_no_sinc_Vrms = sqrt((10.^(ad9910_neg_no_sinc/10))/1000*50);

ad9910_neg_sinc = [-19.61, -19.96, -20.42, -20.36, -20.69, -20.55,...
    -20.78, -20.53, -20.67, -20.69, -20.97, -20.81, -20.77, -20.86,...
    -21.03, -20.77, -20.91, -20.92, -20.70, -22.22];
ad9910_neg_sinc_Vrms = sqrt((10.^(ad9910_neg_sinc/10))/1000*50);

ad9910_pos_no_sinc_norm = ad9910_pos_no_sinc + sma_100_normalized;
ad9910_pos_no_sinc_norm_Vrms = ad9910_pos_no_sinc_Vrms + sma_100_normalized_Vrms;

ad9910_pos_sinc_norm = ad9910_pos_sinc + sma_100_normalized;
ad9910_pos_sinc_norm_Vrms = ad9910_pos_sinc_Vrms + sma_100_normalized_Vrms;

ad9910_neg_no_sinc_norm = ad9910_neg_no_sinc + sma_100_normalized;
ad9910_neg_no_sinc_norm_Vrms = ad9910_neg_no_sinc_Vrms + sma_100_normalized_Vrms;

ad9910_neg_sinc_norm = ad9910_neg_sinc + sma_100_normalized;
ad9910_neg_sinc_norm_Vrms = ad9910_neg_sinc_Vrms + sma_100_normalized_Vrms;


sma_data = transpose([sma_100a_DC_Blocker; sma_100a_DC_Blocker_Vrms; ...
    sma_100a_No_DC_Blocker; sma_100a_No_DC_Blocker_Vrms]);

ad9910_pos_data = transpose([ad9910_pos_no_sinc_norm; ad9910_pos_no_sinc_norm_Vrms;...
    ad9910_pos_sinc_norm; ad9910_pos_sinc_norm_Vrms]);

ad9910_neg_data = transpose([ad9910_neg_no_sinc_norm; ad9910_neg_no_sinc_norm_Vrms;...
    ad9910_neg_sinc_norm; ad9910_neg_sinc_norm_Vrms]);

clear sma_100a_DC_Blocker sma_100a_No_DC_Blocker ad9910_pos_no_sinc ...
    ad9910_pos_sinc ad9910_neg_no_sinc ad9910_neg_sinc

data_fig = figure;
data_fig.Name = 'Data';
data_fig.NumberTitle = 'off';
set(data_fig, 'rend', 'painters', 'pos', [0 200 1600 600], 'Resize', 'off');

figure_pos = get(data_fig, 'Position');
width = figure_pos(3);
height = figure_pos(4);

sma_table_pos = [0 0 width / 3 height];
sma_table = uitable(data_fig, 'Data', sma_data, 'Position', sma_table_pos);
sma_table.ColumnName = {'SMA 100A |DC Blocker (dBm)', 'SMA 100A |DC Blocker (Vrms)' ...
    'SMA 100A |No DC Blocker (dBm)', 'SMA 100A |No DC Blocker (Vrms)'};
sma_table.RowName = strcat(string(frequency_range), ' MHz');
sma_table.FontName = 'Calibri';
sma_table.FontSize = 12;

ad9910_pos_table = [width / 3 0 width / 3 height];
ad9910_pos_table = uitable(data_fig, 'Data', ad9910_pos_data, 'Position', ad9910_pos_table);
ad9910_pos_table.ColumnName = {'AD9910 Positive Output| No Sinc (dBm)', ...
    'AD9910 Positive Output| No Sinc (Vrms)' 'AD9910 Positive Output |w/ Sinc(dBm)', ...
    'AD9910 Positive Output |w/ Sinc(Vrms)'};
ad9910_pos_table.RowName = strcat(string(frequency_range), ' MHz');
ad9910_pos_table.FontName = 'Calibri';
ad9910_pos_table.FontSize = 12;

ad9910_neg_table = [2 * width / 3 0 width / 3 height];
ad9910_neg_table = uitable(data_fig, 'Data', ad9910_neg_data, 'Position', ad9910_neg_table);
ad9910_neg_table.ColumnName = {'AD9910 Negative Output |No Sinc (dBm)', ...
    'AD9910 Negative Output |No Sinc (Vrms)' 'AD9910 Negative Output| w/ Sinc(dBm)', ...
    'AD9910 Negative Output| w/ Sinc (Vrms)'};
ad9910_neg_table.RowName = strcat(string(frequency_range), ' MHz');
ad9910_neg_table.FontName = 'Calibri';
ad9910_neg_table.FontSize = 12;

ad9910_fig = figure('Name', 'AD9910 Characterization Graphs', 'NumberTitle', 'off');
set(ad9910_fig, 'rend', 'painters', 'pos', [0 200 1600 600], 'Resize', 'off');

semilogx(frequency_range, [ad9910_pos_no_sinc_norm; ad9910_pos_sinc_norm; ad9910_neg_no_sinc_norm; ad9910_neg_sinc_norm]);
title('AD9910 Frequency vs Amplitude (dBm) 1-200 MHz Output');
xlabel('Frequency (Mhz)');
ylabel('Amplitude (dBm)');
xticks([frequency_range, 1000]);
xticklabels([frequency_range, 1000]);
xlim([0 1000]);
ax = gca;

ax.XGrid = 'on';
legend('AD9910 Positive Output Sinc Disabled', 'AD9910 Positive Output Sinc Enabled', ...
    'AD9910 Negative Output Sinc Disabled', 'AD9910 Negative Output Sinc Enabled')

saveas(ad9910_fig, 'AD9910 Characterization (dBm).fig');
saveas(ad9910_fig, 'AD9910 Characterization (dBm).png');

ad9910_fig_vrms = figure('Name', 'AD9910 Characterization Graphs (Vrms)', 'NumberTitle', 'off');
set(ad9910_fig_vrms, 'rend', 'painters', 'pos', [0 200 1600 600], 'Resize', 'off');

semilogx(frequency_range, [ad9910_pos_no_sinc_norm_Vrms; ad9910_pos_sinc_norm_Vrms; ad9910_neg_no_sinc_norm_Vrms; ad9910_neg_sinc_norm_Vrms]);
title('AD9910 Frequency vs Amplitude (Vrms) 1-200 MHz Output');
xlabel('Frequency (Mhz)');
ylabel('Amplitude (Vrms)');
xticks([frequency_range, 1000]);
xticklabels([frequency_range, 1000]);
xlim([0 1000]);
ax = gca;

ax.XGrid = 'on';
legend('AD9910 Positive Output Sinc Disabled', 'AD9910 Positive Output Sinc Enabled', ...
    'AD9910 Negative Output Sinc Disabled', 'AD9910 Negative Output Sinc Enabled')
saveas(ad9910_fig_vrms, 'AD9910 Characterization (Vrms).fig');
saveas(ad9910_fig_vrms, 'AD9910 Characterization (Vrms).png');


