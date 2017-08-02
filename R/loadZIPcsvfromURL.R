#' @importFrom stats setNames
#' @importFrom utils read.csv unzip
#' @export
loadZIPcsvfromURL <- function(urlAddress = NULL,
                              txt = FALSE ,
                              encoding = "Latin-1",
                              stringsAsFactors = FALSE,
                              header = TRUE,
                              quote = "\"",
                              fill = TRUE,
                              comment.char = ""){
  temp <- tempfile()
  if(is.null(urlAddress)){
  stop("Please supply a valid URL containing a .zip file")
  }
  urlend = base::substr(urlAddress,base::nchar(urlAddress)-3, base::nchar(urlAddress))
  if(urlend != ".zip"){
    stop("Please supply a valid URL containing a .zip file")
  }else{
    utils::download.file(urlAddress,
                  destfile = temp,
                  method = "libcurl")
    tempzip <- utils::unzip(zipfile = temp)

    base::list2env(stats::setNames(object = base::lapply(tempzip,
                                                         utils::read.csv,
                                                         encoding = encoding,
                                                         stringsAsFactors = stringsAsFactors,
                                                         header = header,
                                                         quote = quote,
                                                         dec = ".",
                                                         fill = fill,
                                                         comment.char = comment.char),
                                   nm = base::make.names(
                                     base::paste0("",
                                                  base::substr(
                                                    base::gsub(
                                                      base::ifelse(txt == TRUE,
                                                                   "*.txt$",
                                                                   "*.csv$"),
                                                      "",
                                                      tempzip),
                                                    3, 40))))
                   , base::globalenv())

    base::unlink(temp, recursive = TRUE)
  }


}
