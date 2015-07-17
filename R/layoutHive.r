#' @title getAxisAngles
#' @description Given a graph with vertice positions along axis, calculate the angles of the axes.
#' @details Given a graph with vertice positions along axis, calculate the angles of the axes.
#' @importFrom magrittr "%>%"
#' @importFrom igraph V
#' @aliases getAxisAngles
#' @author Jared P. Lander
#' @param graph An igraph object
#' @param firstAxis By defualt the first axis is positioned along the x-axis.  This arugment allows that to be adjusted, which would offset all the axes by that amount.
#' @param degrees Logical indicating of firstAxis is specified in degrees.  Default is \code{FALSE}.
#' @return A numerical vector giving the axis angle for each node in \code{graph}
#' @examples 
#' library(igraph)
#' data(flights)
#' g <- graph.data.frame(flights, directed=FALSE)
#' g <- findAxes(g)
#' getAxisAngles(g)
#' 
getAxisAngles <- function(graph, firstAxis=0, degrees=FALSE)
{
    # first axis at firstAxis radians
    # if firstAxis is in degrees convert it to radians
    if(degrees)
    {
        firstAxis <- firstAxis*pi/180
    }
    
    # find number of axes
    numAxes <- V(graph)$axis %>% unique %>% length
    # calculate angle between them
    radBetween <- 2*pi/numAxes
    
    # convert axis number to angle from x-axis
    (V(graph)$axis - 1)*radBetween + firstAxis
}

#' @title layout_with_hive
#' @description igraph layout function for hive plots
#' @details igraph layout function for hive plots
#' @export layout_with_hive
#' @aliases layout_with_hive
#' @importFrom magrittr "%<>%"
#' @importFrom igraph V
#' @importFrom dplyr select
#' @importFrom useful pol2cart
#' @author Jared P. Lander
#' @param graph An igraph object
#' @return A two-dimensional matrix with x- and y-coordinates
#' @examples 
#' library(igraph)
#' library(useful)
#' data(flights)
#' g <- graph.data.frame(flights, directed=FALSE)
#' l <- layout_with_hive(g)
#' plot(g, layout=l)
#' 
layout_with_hive <- function(graph)
{
    # if axis is missing, compute it
    if(is.null(V(graph)$axis))
    {
        graph %<>% findAxes
    }
    
    # if nodePosition is missing, compute it
    if(is.null(V(graph)$nodePosition))
    {
        graph %<>% nodePosition
    }
    
    # figure out the angles needs
    theta <- getAxisAngles(graph)
    
    ## convert polar coordinates to cartesian
    ## theta is the angle and V(graph)$nodePosition is r, the magnitude
    pol2cart(r=V(graph)$nodePosition, theta=theta) %>% select(x, y) %>% setNames(NULL) %>% as.matrix 
}