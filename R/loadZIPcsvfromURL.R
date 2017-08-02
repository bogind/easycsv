#' @importFrom stats setNames
#' @importFrom utils read.csv unzip
loadZIPcsvfromURL <- function(urlAddress = NULL,
                              encoding = NULL,
                              txt = FALSE ,
                              stringsAsFactors = FALSE,
                            header = TRUE,
                            quote = "\"",
                            fill = TRUE,
                            comment.char = ""){
  temp <- tempfile()
  if(is.null(urlAddress)){
  message("Please supply a valid URL containing a .zip file")
  }
  if(base::substr(urlAddress,
                  base::nchar(urlAddress)-3,
                  base::nchar(urlAddress)) != ".zip"){
    message("Please supply a valid URL containing a .zip file")
  }else{
    utils::download.file(urlAddress,
                  destfile = temp,
                  encoding = base::ifelse(base::is.null(encoding), NULL, encoding),
                  method = "libcurl")
    tempzip <- utils::unzip(zipfile = temp)

    base::list2env(stats::setNames(object = base::lapply(tempzip,
                                                         utils::read.csv,
                                                         encoding = ifelse(base::is.null(encoding),
                                                                           NULL,
                                                                           encoding),
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

    base::unlink(temp)
  }


}
