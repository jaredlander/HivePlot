context("layout_with_hive provides proper coordinates")

library(igraph)
library(useful)
data(flights)
g <- graph.data.frame(flights, directed=FALSE)
g <- findAxes(g)


####
## getAxisAngles
####
test_that('getAxisAngles returns the proper class', {
    expect_is(getAxisAngles(g), 'numeric')
    expect_is(getAxisAngles(g, pi/2), 'numeric')
    expect_is(getAxisAngles(g, 90, degrees=TRUE), 'numeric')
})

test_that('getAxisAngles returns an angle for each vertex', {
    expect_equal(length(getAxisAngles(g)), vcount(g))
    expect_equal(length(getAxisAngles(g, pi/2)), vcount(g))
    expect_equal(length(getAxisAngles(g, 90, degrees=TRUE)), vcount(g))
})

test_that('getAxisAngles provides correct angles', {
    expect_equal(sort(unique(getAxisAngles(g))), c(0, 2*pi/5, 2*2*pi/5, 3*2*pi/5, 4*2*pi/5))
    expect_equal(sort(unique(getAxisAngles(g, pi/2))), c(0, 2*pi/5, 2*2*pi/5, 3*2*pi/5, 4*2*pi/5) + pi/2)
    expect_equal(sort(unique(getAxisAngles(g, 90, degrees=TRUE))), c(0, 2*pi/5, 2*2*pi/5, 3*2*pi/5, 4*2*pi/5) + pi/2)
})


####
## layout_with_hive
####
test_that('layout_with_hive returns a matrix', {
    expect_is(layout_with_hive(g), 'matrix')
})

test_that('layout_with_hive has the correct dimensions', {
    expect_equal(dim(layout_with_hive(g)), c(vcount(g), 2))
})

# test for values