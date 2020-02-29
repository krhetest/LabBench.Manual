function labTE_PlotChannel(R, chan)
% labTE_PlotChannel Plot a single channel from a threshold estimation test
d = R.ch{chan};
N = 1:length(d.response);
I1 = find(d.response == 1);
I0 = find(d.response == 0);

figure(1);
clf;
set(gcf, 'Color', [1 1 1]);

plot(I0, d.intensity(I0), 'r*',...
     I1, d.intensity(I1), 'b*',...
     [1 length(d.response)],d.threshold * d.Imax * [1 1],'k',...
     N, d.function.alpha .* d.Imax,'b-');
text(length(d.response), R.THR(chan), sprintf('%.2fmA', R.THR(chan)));
legend('Not Felt','Felt','Threshold', 'Alpha', 'Location','southeast','Orientation','horizontal');
title(sprintf('%s (%s)', R.id, d.ID));
set(gca,'Box','off');
set(gca,'TickDir','out');
xlabel('Trials []');
ylabel('Intensity [mA]');

