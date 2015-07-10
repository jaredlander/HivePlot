context("nodePosition calculates node position")

library(igraph)
data(flights)
g <- graph.data.frame(flights, directed=TRUE)

test_that("nodePosition returns a graph", {
    expect_is(nodePosition(g), 'igraph')
})

test_that('An axis attribute is added by findAxes', {
    expect_null(V(g)$nodePosition)
    expect_equal(length(V(nodePosition(g))$nodePosition), vcount(g))
})
