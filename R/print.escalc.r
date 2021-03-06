print.escalc <- function(x, digits=attr(x,"digits"), ...) {

   mstyle <- .get.mstyle("crayon" %in% .packages())

   if (!inherits(x, "escalc"))
      stop(mstyle$stop("Argument 'x' must be an object of class \"escalc\"."))

   attr(x, "class") <- NULL

   digits <- .get.digits(digits=digits, xdigits=attr(x, "digits"), dmiss=FALSE)

   ### get positions of the variable names in the object
   ### note: if the object no longer contains a particular variable, match() returns NA;
   ### use na.omit(), so that length() is then zero (as needed for if statements below)

   yi.pos    <- na.omit(match(attr(x, "yi.names"),    names(x)))
   vi.pos    <- na.omit(match(attr(x, "vi.names"),    names(x)))
   sei.pos   <- na.omit(match(attr(x, "sei.names"),   names(x)))
   zi.pos    <- na.omit(match(attr(x, "zi.names"),    names(x)))
   ci.lb.pos <- na.omit(match(attr(x, "ci.lb.names"), names(x)))
   ci.ub.pos <- na.omit(match(attr(x, "ci.ub.names"), names(x)))

   ### get rownames attribute so we can back-assign it

   rnames <- attr(x, "row.names")
   x <- data.frame(x)
   rownames(x) <- rnames

   ### round variables according to the digits argument

   if (length(yi.pos) > 0L)
      x[yi.pos] <- apply(x[yi.pos], 2, .fcf, digits[["est"]])

   if (length(vi.pos) > 0L)
      x[vi.pos] <- apply(x[vi.pos], 2, .fcf, digits[["var"]])

   if (length(sei.pos) > 0L)
      x[sei.pos] <- apply(x[sei.pos], 2, .fcf, digits[["se"]])

   if (length(zi.pos) > 0L)
      x[zi.pos] <- apply(x[zi.pos], 2, .fcf, digits[["test"]])

   if (length(ci.lb.pos) > 0L)
      x[ci.lb.pos] <- apply(x[ci.lb.pos], 2, .fcf, digits[["ci"]])

   if (length(ci.ub.pos) > 0L)
      x[ci.ub.pos] <- apply(x[ci.ub.pos], 2, .fcf, digits[["ci"]])

   tmp <- capture.output(print(x, ...))
   .print.table(tmp, mstyle)

}
