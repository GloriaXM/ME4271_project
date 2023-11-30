function [X,Y,Z] = GetXYZfromPixel(x,y,r)
    xt = 0.500; % width of table in meters
    yt = 0.500; % length of table in meters
    yd = 0.250; % horizontal distance from camera to table
    zt = 1.000; % vertical distance from camera to table

    ptl = [100 400]; % pixel coordinate of top left of table
    ptr = [400 400]; % pixel coordinate of top right of table
    pbl = [ 50 100]; % pixel coordinate of bottom left of table
    pbr = [450 100]; % pixel coordinate of bottom right of table
   
    Q = (y-pbr(2))/(ptr(2)-pbr(2));
    B = Q*(pbr(1)-ptr(0))+0.5*(ptr(0)-ptr(0));
    
    xr = (xt/(2*B))*(x-(ptr(0)+ptl(0))/2);
    yr = yt*Q + yd;

    X = xr*(1-r/zt);
    Y = yr*(1-r/zt);
    Z = r;
end
