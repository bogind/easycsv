#' @importFrom stats setNames
#' @importFrom utils read.csv unzip choose.dir
#' @export
loadcsv_multi <- function(directory = NULL,
                          txt = FALSE,
                          encoding = "Latin-1",
                          stringsAsFactors = FALSE,
                          header = TRUE,
                          quote = "\"",
                          fill = TRUE,
                          comment.char = ""){

  if(is.null(directory)){
    os <- .Platform
    si <- as.list(Sys.info())
    if(os$OS.type == "windows" | tolower(si$sysname) == "linux"){
      directory <- choose.dir()
    }else{
      stop("Please supply a valid local directory")
    }

  }

  directory = paste(gsub(pattern = "\\", "/", directory,
                         fixed = TRUE))
  ending = ifelse(txt == TRUE,
                  "*.txt$",
                  "*.csv$")
    temppath = paste(directory,list.files(path = directory, pattern=ending), sep = "/")
    tempfiles = list.files(path = directory, pattern=ending)
    list2env(
        lapply(setNames(temppath,
                        make.names(paste0(gsub(ending, "", tempfiles)))),
               read.csv,
               encoding = encoding,
               stringsAsFactors = stringsAsFactors,
               header = header,
               quote = quote,
               fill = fill,
               comment.char = comment.char),
        envir = .GlobalEnv)


}
