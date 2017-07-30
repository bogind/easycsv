\name{loadcsvfromZIP}
\alias{loadcsvfromZIP}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
load multiple csv files to the environment
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Reads multiple files in table format and creates a data frame from them, with cases corresponding to lines and variables to fields in the file.
}
\usage{
loadcsv_multi(directory, txt = FALSE, encoding = NULL, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "")

loadcsvfromZIP(filezip, txt = FALSE, encoding = NULL, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "")

loadZIPcsvfromURL(urlAddress, txt = FALSE, encoding = NULL, header = TRUE, sep = ",", quote = "\"",
         dec = ".", fill = TRUE, comment.char = "")

}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{directory}{
%%     ~~Describe \code{x} here~~
a directory to load the files from, if NULL then a manual choice is provided
}
  \item{filezip}{
  a '.zip' file to load the files from, if NULL then a manual choice is provided.
  does not work with '.rar' files
  }
  \item{urlAddress}{
  a URL address of the zipped file, if NULL then Israeli GTFS will be downloaded and added to env.
  }
  \item{txt}{
  logical. if TRUE .txt files will be loaded as tables instead of .csv
  }
  \item{encoding}{
  character. files encoding. can be NULL
  }
  \item{header}{
  a logical value indicating whether the files contain the names of the variables as its first line. If missing, the value is determined from the file format: header is set to TRUE if and only if the first row contains one fewer field than the number of columns.
  }
  \item{sep}{
  the field separator character. Values on each line of the file are separated by this character. If sep = "" (the default for read.table) the separator is ‘white space’, that is one or more spaces, tabs, newlines or carriage returns.
  }
  \item{quote}{
  the set of quoting characters. To disable quoting altogether, use quote = "". See scan for the behaviour on quotes embedded in quotes. Quoting is only considered for columns read as character, which is all of them unless colClasses is specified.
  }
  \item{dec}{
  The character used in the file for decimal points.
  }
  \item{fill}{
  logical. If TRUE then in case the rows have unequal length, blank fields are implicitly added. See ‘Details’.
  }
  \item{comment.char}{
  character: a character vector of length one containing a single character or an empty string. Use "" to turn off the interpretation of comments altogether.
  }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
loadcsv_multi is used for uncompressed files in a single folder.
loadcsvfromZIP is used for comma seperated tables inside of a .zip file.
loadZIPcsvfromURL is used for comma seperated tables inside of a .zip file on the internet, no download needed.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
A data frame (http://127.0.0.1:10235/help/library/utils/help/data.frame) containing a representation of the data in the file.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
directory = "D:/Data/tables"
loadcsv_multi(directory)
#or:
loadcsv_multi()
#or if your tables are in .txt files with comma seperation:
lodacsv_multi(directory,txt = TRUE)

for tables compressed in a single .zip file:

filezip = "D:/Data/tables.zip"
loadcsvfromZIP(filezip)

url = "http://spatialkeydocs.s3.amazonaws.com/FL_insurance_sample.csv.zip"
loadZIPcsvfromURL(url)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
