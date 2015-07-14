#' @title findAxes
#' @description Places vertices into axes
#' @details Places vertices into axes based on a clustering algorithm
#' @aliases findAxes
#' @export findAxes
#' @author Jared P. Lander
#' @importFrom igraph walktrap.community "V<-" V
#' @param graph An igraph object
#' @param func A function that returns a cluster membership for each node
#' @param \dots Further arguments for \code{func}
#' @return A graph with a new Vertex slot 'axis' that stores the cluster membership
#' @examples 
#' library(igraph)
#' data(flights)
#' g <- graph.data.frame(flights, directed=TRUE)
#' g2 <- findAxes(g)
#' V(g2)$axis
#' 
findAxes <- function(graph, func=walktrap.community, ...)
{
    # compute axes membership
    axes <- func(graph, ...)
    
    # if it is a communities object grab the membership vector
    if(class(axes) == 'communities')
    {
        axes <- axes$membership
    }
    
    # assign the axes to the vertices
    V(graph)$axis <- axes
    
    return(graph)
}