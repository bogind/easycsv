loadcsv_multi <- function(directory = choose.dir(), txt = FALSE, encoding = NULL,
                          stringsAsFactors = FALSE,
                          header = TRUE, quote = "\"",fill = TRUE, comment.char = ""){
  if(is.null(directory)){
    directory <- choose.dir()
  }
  placeholder = getwd()
  setwd(directory)
  ending = ifelse(txt == TRUE,"*.txt$","*.csv$")
    temp = list.files(pattern=ending)
      list2env(
        lapply(setNames(temp,
                        make.names(paste0(gsub(ending, "", temp)))),
               read.csv,
               encoding = encoding,
               stringsAsFactors = stringsAsFactors,
               header = header, quote = quote,fill = fill, comment.char = comment.char),
        envir = .GlobalEnv)
      setwd(placeholder)

}
