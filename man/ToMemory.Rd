% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mcmc.R
\name{ToMemory}
\alias{ToMemory}
\title{Converts matrices in a file-backed MCMC to R matrix objects}
\usage{
ToMemory(samples)
}
\arguments{
\item{samples}{list of \code{\link{big.matrix}} objects, typically coming
from \code{\link{InitMcmc}}}
}
\value{
list of R \code{\link{matrix}} objects
}
\description{
\code{ToMemory} is a convenience method to load the samples from a
file-backed MCMC run into memory.  Given a list of \code{\link{big.matrix}}
objects, it will convert them to standard R matrix objects.
}
\examples{
# Run a file-backed MCMC
backing.path <- tempfile()
dir.create(backing.path)
Mcmc <- InitMcmc(1000, backing.path=backing.path)
samples <- Mcmc({
    x <- rnorm(1)
    y <- rnorm(2)
})

# Convert to standard in-memory R matrices
samples.in.memory <- ToMemory(samples)

is.matrix(samples.in.memory$x)
is.matrix(samples.in.memory$y)
bigmemory::is.big.matrix(samples.in.memory$x)
bigmemory::is.big.matrix(samples.in.memory$y)
}
\seealso{
\code{\link{InitMcmc}}, \code{\link{big.matrix}}
}
