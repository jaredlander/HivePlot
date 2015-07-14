#' @title nodeSize
#' @description Computes size of vertices
#' @details Computes size of vertices based on some importance algorithm such as \code{\link[igraph]{page.rank}}
#' @aliases nodeSize
#' @export nodeSize
#' @author Jared P. Lander
#' @importFrom igraph page.rank "V<-" V
#' @param graph An igraph object
#' @param func A function that returns a cluster membership for each node
#' @param \dots Further arguments for \code{func}
#' @return A graph with a new Vertex slot 'axis' that stores the cluster membership
#' @examples 
#' data(flights)
#' library(igraph)
#' g <- graph.data.frame(flights, directed=TRUE)
#' g2 <- nodeSize(g)
#' V(g2)$nodeSize
#' 
nodeSize <- function(graph, func=page.rank, ...)
{
    size <- func(graph, ...)
    
    if(class(size) == 'list')
    {
        size <- size$vector
    }
    
    V(graph)$nodeSize <- size
    
    return(graph)
}
