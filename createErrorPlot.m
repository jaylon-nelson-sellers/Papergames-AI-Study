%This metehod creates a plot based on the MSE
function output = createErrorPlot(outputMSE, type)
%plots data

filename = type + ".png";
figure()
plot(outputMSE);
ax = gca;
exportgraphics(ax,filename);
output = filename;
end