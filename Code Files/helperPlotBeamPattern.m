function helperPlotBeamPattern(azimuthGrid, unoptimizedPattern, steeringAngle, varargin)

defaultOptimizedPattern = [];
defaultLeftSidelobeAngles = [];
defaultRightSidelobeAngles = [];
defaultLeftSidelobeValues = [];
defaultRightSidelobeValues = [];
defaultNullDirections = [];

p = inputParser;
addParameter(p, 'OptimizedPattern', defaultOptimizedPattern);
addParameter(p, 'LeftSidelobeAngles', defaultLeftSidelobeAngles);
addParameter(p, 'RightSidelobeAngles', defaultRightSidelobeAngles);
addParameter(p, 'LeftSidelobeValues', defaultLeftSidelobeValues);
addParameter(p, 'RightSidelobeValues', defaultRightSidelobeValues);
addParameter(p, 'NullDirections', defaultNullDirections);

parse(p, varargin{:});

optimizedPattern = p.Results.OptimizedPattern;
leftSidelobeAngles = p.Results.LeftSidelobeAngles;
rightSidelobeAngles = p.Results.RightSidelobeAngles;
leftSidelobeValues = p.Results.LeftSidelobeValues;
rightSidelobeValues = p.Results.RightSidelobeValues;
nullDirections = p.Results.NullDirections;

figure;
hold on;
plot(azimuthGrid, unoptimizedPattern, LineWidth=2, LineStyle='-.', DisplayName="Unoptimized beam pattern");

if ~isempty(optimizedPattern)
    plot(azimuthGrid, optimizedPattern, LineWidth=2, DisplayName="Optimized beam pattern");
end

xline(steeringAngle, '--', {'Steering', 'Direction'}, HandleVisibility='off',...
    LabelVerticalAlignment='bottom', LabelHorizontalAlignment='center');
legend(Location="southoutside", Orientation="horizontal", NumColumns=2);
title('Beam Pattern');
xlabel('Azimuth Angle (deg)');
ylabel('(dB)')
grid on;
ylim([-50 1])

hold on;
colors = gca().ColorOrder;
if ~isempty(leftSidelobeAngles) && ~isempty(leftSidelobeValues)
    plot(leftSidelobeAngles, leftSidelobeValues, Color=colors(3, :), LineWidth=2, DisplayName="Desired sidelobe level");
end

if ~isempty(rightSidelobeAngles) && ~isempty(rightSidelobeValues)
    plot(rightSidelobeAngles, rightSidelobeValues, Color=colors(3, :), LineWidth=2, HandleVisibility="off");
end

if ~isempty(nullDirections)
    xline(nullDirections(1), LineWidth=1.0, Color=colors(4,:), DisplayName="Null directions");
    xline(nullDirections(2:end), LineWidth=1.0, Color=colors(4,:), HandleVisibility='off');
end