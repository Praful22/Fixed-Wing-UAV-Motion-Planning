% Praful Sigdel
% Three Dimensional Occupancy Map Generation in Matlab
% Tools Used: Navigation Toolbox.
% July, 2023


% Three Dimensional Occupancy Map with Navigation Toolbox
rng(7, 'twister');

% Create an empty 3D occupancy Map. The maximum width and length of map
% is 450m and 450m respectively.
omap3D = occupancyMap3D;
Widthm = 450;
Lengthm = 450;

% Number of obstacles in the occupancy map.
numberOfObstacles = 15;

% Generate Obstacles one after another using a while loop.
obstacleNumber = 1;


while obstacleNumber <= numberOfObstacles
    width = randi([1 100],1); %random integer value between 1 to 50
    length = randi([1 100], 1);
    height = randi([1 150], 1);
    xPosition = randi([0 Widthm - width], 1);
    yPosition = randi([0 Lengthm - length], 1);

    % Obtain the 3D grid coordinates of the 
    % obstacle using the meshgrid function.

    [xObstacle,yObstacle,zObstacle] = meshgrid(xPosition:xPosition+width, ...
        yPosition:yPosition+length,0:height);
    xyzObstacles = [xObstacle(:) yObstacle(:) zObstacle(:)];

    checkIntersection = false;

    % checkOccupancy (Navigation Toolbox) function
    % checks if the obstacle intersects any other previously added obstacle. 
    % If it does, go to step 1. If it does not, move on to the next step.
    for i = 1:size(xyzObstacles,1)
         if checkOccupancy(omap3D,xyzObstacles(i,:)) == 1
            checkIntersection = true;
            break
        end
    end
    if checkIntersection
        continue
    end
    % setOccupancy (Navigation Toolbox) function sets the occupancy values
    % of the obstacle's location as 1.

    setOccupancy(omap3D,xyzObstacles,1)

    obstacleNumber = obstacleNumber + 1;
end

[xGround,yGround,zGround] = meshgrid(0:Widthm,0:Lengthm,0);
xyzGround = [xGround(:) yGround(:) zGround(:)];
setOccupancy(omap3D,xyzGround,1)
save("omap3D.mat","omap3D")



