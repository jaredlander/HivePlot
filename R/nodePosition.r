#' @title nodePosition
#' @description Computes the position of vertices along axes
#' @details Computes the position of vertices along axes based on some centrality algorithm such as \code{\link[igraph]{closeness}}
#' @aliases nodePosition
#' @export nodePosition
#' @author Jared P. Lander
#' @importFrom igraph closeness V
#' @param graph An igraph object
#' @param func A function that returns a cluster membership for each node
#' @param \dots Further arguments for \code{func}
#' @return A graph with a new Vertex slot 'axis' that stores the cluster membership
#' @examples 
#' data(flights)
#' library(igraph)
#' g <- graph.data.frame(flights, directed=TRUE)
#' g2 <- nodePosition(g)
#' V(g2)$nodePosition
#' 
nodePosition <- function(graph, func=closeness, ...)
{
    V(graph)$nodePosition <- rank(func(graph, ...))
    
    return(graph)
}
