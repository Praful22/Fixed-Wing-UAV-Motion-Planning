% Motion Planning with Rapidly Exploring Random Tree (RRT) Algorithm for 
% Fixed-Wing UAV.

% Generate Seed for Repeatable Results.

rng(7, "twister")

%% LOAD MAP
% Load the 3-D occupancy map uavMapCityBlock.mat, which contains a set of 
% pregenerated obstacles, into the workspace. 
% The occupancy map is in an ENU (East-North-Up) frame.

mapData = load("omap3D.mat","omap3D");
omap = mapData.omap3D;

% Consider unknown spaces to be unoccupied
omap.FreeThreshold = omap.OccupiedThreshold;

% Select an unoccupied start 
% position and goal position using the map as reference.
startPose = [12 22 25 pi/2];
goalPose = [150 180 35 pi/2];
figure("Name","StartAndGoal")
hMap = show(omap);
hold on
% Display circles to locate the start position and goal position.
scatter3(hMap,startPose(1),startPose(2),startPose(3),30,"red","filled")
scatter3(hMap,goalPose(1),goalPose(2),goalPose(3),30,"green","filled")
hold off
view([-31 63])

%% 