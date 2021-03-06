% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/strip.R
\name{strip_ctl}
\alias{strip_ctl}
\alias{strip_sgr}
\title{Strip ANSI Control Sequences}
\usage{
strip_ctl(x, ctl = "all", warn = getOption("fansi.warn"), strip)

strip_sgr(x, warn = getOption("fansi.warn"))
}
\arguments{
\item{x}{a character vector or object that can be coerced to character.}

\item{ctl}{character, any combination of the following values (see details):
\itemize{
\item "nl": strip newlines.
\item "c0": strip all other "C0" control characters (i.e. x01-x1f, x7F),
except for newlines and the actual ESC character.
\item "sgr": strip ANSI CSI SGR sequences.
\item "csi": strip all non-SGR csi sequences.
\item "esc": strip all other escape sequences.
\item "all": all of the above, except when used in combination with any of the
above, in which case it means "all but" (see details).
}}

\item{warn}{TRUE (default) or FALSE, whether to warn when potentially
problematic \emph{Control Sequences} are encountered.  These could cause the
assumptions \code{fansi} makes about how strings are rendered on your display
to be incorrect, for example by moving the cursor (see \link{fansi}).}

\item{strip}{character, deprecated in favor of \code{ctl}.}
}
\value{
character vector of same length as x with ANSI escape sequences
stripped
}
\description{
Removes \emph{Control Sequences} from strings.  By default it will
strip all known \emph{Control Sequences}, including ANSI CSI
sequences, two character sequences starting with ESC, and all C0 control
characters, including newlines.  You can fine tune this behavior with the
\code{ctl} parameter.  \code{strip_sgr} only strips ANSI CSI SGR sequences.
}
\details{
The \code{ctl} value contains the names of \strong{non-overlapping} subsets of the
known \emph{Control Sequences} (e.g. "csi" does not contain "sgr", and "c0" does
not contain newlines).  The one exception is "all" which means strip every
known sequence.  If you combine "all" with any other option then everything
\strong{but} that option will be stripped.
}
\note{
Non-ASCII strings are converted to and returned in UTF-8 encoding.
}
\section{_ctl vs. _sgr}{


The \code{*_ctl} versions of the functions treat all \emph{Control Sequences} specially
by default.  Special treatment is context dependent, and may include
detecting them and/or computing their display/character width as zero.  For
the SGR subset of the ANSI CSI sequences, \code{fansi} will also parse, interpret,
and reapply the text styles they encode if needed.  You can modify whether a
\emph{Control Sequence} is treated specially with the \code{ctl} parameter.  You can
exclude a type of \emph{Control Sequence} from special treatment by combining
"all" with that type of sequence (e.g. \code{ctl=c("all", "nl")} for special
treatment of all \emph{Control Sequences} \strong{but} newlines).  The \code{*_sgr} versions
only treat ANSI CSI SGR sequences specially, and are equivalent to the
\code{*_ctl} versions with the \code{ctl} parameter set to "sgr".
}

\examples{
string <- "hello\\033k\\033[45p world\\n\\033[31mgoodbye\\a moon"
strip_ctl(string)
strip_ctl(string, c("nl", "c0", "sgr", "csi", "esc")) # equivalently
strip_ctl(string, "sgr")
strip_ctl(string, c("c0", "esc"))

## everything but C0 controls, we need to specify "nl"
## in addition to "c0" since "nl" is not part of "c0"
## as far as the `strip` argument is concerned
strip_ctl(string, c("all", "nl", "c0"))

## convenience function, same as `strip_ctl(ctl='sgr')`
strip_sgr(string)
}
\seealso{
\link{fansi} for details on how \emph{Control Sequences} are
interpreted, particularly if you are getting unexpected results.
}
