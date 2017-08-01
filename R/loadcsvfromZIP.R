#' @importFrom stats setNames
#' @importFrom utils choose.dir read.csv unzip
loadcsvfromZIP <- function(filezip = NULL,
                           encoding = NULL,
                           txt = FALSE ,
                           stringsAsFactors = FALSE,
                           header = TRUE,
                           quote = "\"",
                           fill = TRUE,
                           comment.char = ""){
  if(is.null(filezip)){
    filezip <- unzip(zipfile = file.choose())
  }else{
    filezip <- unzip(zipfile = filezip)
  }
  if(base::substr(filezip,
                  base::nchar(filezip)-3,
                  base::nchar(filezip)) != ".zip"){
    message("Please supply a valid .zip file")

  }
  else{
    ending = ifelse(txt == TRUE,
                    "*.txt$",
                    "*.csv$")
    list2env(setNames(object = lapply(filezip,
                                      read.csv,
                                      stringsAsFactors = stringsAsFactors,
                                      encoding = ifelse(base::is.null(encoding),
                                                        NULL,
                                                        encoding),
                                      header = header,
                                      quote = quote,
                                      fill = fill,
                                      comment.char = comment.char),
                      nm = make.names(
                        paste0("", substr(
                          gsub(ending,"", filezip)
                          ,3, 40 )))), globalenv())
  }


}
