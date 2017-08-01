loadcsv_multi <- function(directory = NULL,
                          txt = FALSE,
                          encoding = NULL,
                          stringsAsFactors = FALSE,
                          header = TRUE,
                          quote = "\"",
                          fill = TRUE,
                          comment.char = ""){
  if(is.null(directory)){
    directory <- choose.dir()
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
               encoding = ifelse(base::is.null(encoding),
                                 NULL,
                                 encoding),
               stringsAsFactors = stringsAsFactors,
               header = header,
               quote = quote,
               fill = fill,
               comment.char = comment.char),
        envir = .GlobalEnv)


}
