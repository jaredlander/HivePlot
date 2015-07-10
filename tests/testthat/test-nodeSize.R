context("nodeSize processes node size")

library(igraph)
data(flights)
g <- graph.data.frame(flights, directed=TRUE)

test_that("nodeSize returns a graph", {
    expect_is(nodeSize(g), 'igraph')
})

test_that('An axis attribute is added by findAxes', {
    expect_null(V(g)$nodeSize)
    expect_equal(length(V(nodeSize(g))$nodeSize), vcount(g))
})
