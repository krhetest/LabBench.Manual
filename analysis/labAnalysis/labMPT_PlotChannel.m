function labMPT_PlotChannel(R, chan)
% labMPT_PlotChannel Plot a single channel from a multiple perception threshold test
R
d = R.ch{chan};
d
N = 1:length(d.T);
I1 = find(d.P == 1);
I0 = find(d.P == 0);

figure(1);
clf;
set(gcf, 'Color', [1 1 1]);

plot(I0, d.I(I0), 'r*',...
     I1, d.I(I1), 'b*',...
     [1 length(d.P)],R.THR(chan) * [1 1],'k');
text(length(d.P), R.THR(chan), sprintf('%.2fmA', R.THR(chan)));
legend('Not Felt','Felt','Threshold', 'Location','southeast','Orientation','horizontal');
title(sprintf('%s (%d)', R.id, chan));
set(gca,'Box','off');
set(gca,'TickDir','out');
xlabel('Trials []');
ylabel('Intensity [mA]');

