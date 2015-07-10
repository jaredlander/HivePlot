context("findAxes processes axis membership")

library(igraph)
data(flights)
g <- graph.data.frame(flights, directed=TRUE)

test_that("findAxes returns a graph", {
    expect_is(findAxes(g), 'igraph')
})

test_that('An axis attribute is added by findAxes', {
    expect_null(V(g)$axis)
    expect_equal(length(V(findAxes(g))$axis), vcount(g))
})
