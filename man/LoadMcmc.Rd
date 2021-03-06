% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mcmc.R
\name{LoadMcmc}
\alias{LoadMcmc}
\title{Load samples from a file-backed MCMC run}
\usage{
LoadMcmc(backing.path)
}
\arguments{
\item{backing.path}{directory path where MCMC samples were saved}
}
\value{
list of \code{\link{big.matrix}} with the MCMC samples
}
\description{
\code{LoadMcmc} loads the samples from a file-backed MCMC run initiated by
\code{InitMcmc}.  The result is a list of \code{\link{big.matrix}} with all
of the parameters that were saved in the MCMC run.  Alternatively, the
samples for individual parameters can be loaded by using
\code{\link{attach.big.matrix}} to load the corresponding \code{descriptor}
file, "ParameterName.desc," in the MCMC's \code{backing.path} directory.
}
\examples{
# Run a file-backed MCMC
backing.path <- tempfile()
dir.create(backing.path)
Mcmc <- InitMcmc(1000, backing.path=backing.path)
samples <- Mcmc({
    x <- rnorm(1)
})
rm(samples)

# Load the saved samples
loaded.samples <- LoadMcmc(backing.path)
hist(loaded.samples$x[,], main="Samples", xlab="x")
}
\seealso{
\code{\link{ToMemory}}, \code{\link{Peek}},
  \code{\link{attach.big.matrix}}
}
