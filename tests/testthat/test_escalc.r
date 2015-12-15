### library(metafor); library(testthat); Sys.setenv(NOT_CRAN="true")

context("Testing escalc()")

test_that("escalc() works correctly for measure='RR'", {

   data(dat.bcg, package="metafor")

   dat <- escalc(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)

   expect_equivalent(round(dat$yi[1],4), -0.8893)
   expect_equivalent(round(dat$vi[1],4),  0.3256)

   ### need to add lots of stuff here ...

})

test_that("escalc.formula() works correctly for measure='RR'", {

   data(dat.bcg, package="metafor")

   dat.long <- to.long(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg,
                       data=dat.bcg, append=FALSE, vlong=TRUE)

   dat <- escalc(measure="RR", outcome ~ group | study, weights=freq, data=dat.long)

   expect_equivalent(round(dat$yi[1],4), -0.8893)
   expect_equivalent(round(dat$vi[1],4),  0.3256)

})
