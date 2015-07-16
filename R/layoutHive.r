getAxisAngles <- function(graph)
{
    # first axis at 0 radians
    
    # find number of axes
    numAxes <- V(graph)$axis %>% unique %>% length
    # calculate angle between them
    radBetween <- 2*pi/numAxes
    
    # convert axis number to angle from x-axis
    (V(graph)$axis - 1)*radBetween
}

layout.hive <- function()
{
    ## convert polar coordinates to cartesian
    ## theta is the angle and V(graph)$nodePosition is r, the magnitude
    pol2cart(r=V(graph)$nodePosition, theta=theta) %>% select(x, y)   
}