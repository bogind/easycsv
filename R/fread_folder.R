#' @importFrom stats setNames
#' @importFrom utils installed.packages
#' @export
fread_folder = function(directory = NULL,
                        extension = "CSV",
                        sep="auto",
                        nrows=-1L,
                        header="auto",
                        na.strings="NA",
                        stringsAsFactors=FALSE,
                        verbose=getOption("datatable.verbose"),
                        autostart=1L,
                        skip=0L,
                        drop=NULL,
                        colClasses=NULL,
                        integer64=getOption("datatable.integer64"),         # default: "integer64"
                        dec=if (sep!=".") "." else ",",
                        col.names,
                        check.names=FALSE,
                        encoding="unknown",
                        quote="\"",
                        strip.white=TRUE,
                        fill=FALSE,
                        blank.lines.skip=FALSE,
                        key=NULL,
                        showProgress=getOption("datatable.showProgress"),   # default: TRUE
                        data.table=getOption("datatable.fread.datatable")   # default: TRUE
){
  if ("data.table" %in% rownames(installed.packages()) == FALSE) {
    stop("data.table needed for this function to work. Please install it.",
         call. = FALSE)
  }

  if(is.null(directory)){
    os <- .Platform

    if(os$OS.type == "windows"){
      directory <- utils::choose.dir()
    }else{
      stop("Please supply a valid local directory")
    }

  }

  directory = paste(gsub(pattern = "\\", "/", directory,
                         fixed = TRUE))



  endings = list()

  if(tolower(extension) == "txt"){
    endings[1] =  "*\\.txt$"
  }
  if(tolower(extension) == "csv"){
    endings[1] =  "*\\.csv$"

  }
  if(tolower(extension) == "both"){
    endings[1] =  "*\\.txt$"
    endings[2] =  "*\\.csv$"
  }
  if((tolower(extension) %in% c("txt","csv","both")) == FALSE){
    stop("Pleas supply a valid value for 'extension',\n
         allowed values are: 'TXT','CSV','BOTH'.")
  }
  tempfiles = list()
  temppath = list()
  num = 1
  for(i in endings){
    temppath = paste(directory,list.files(path = directory, pattern=i), sep = "/")
    tempfiles = list.files(path = directory, pattern=i)
    num = num +1
    if(length(temppath) < 1 | length(tempfiles) < 1){
      num = num+1
    }
    else{
    temppath = unlist(temppath)
    tempfiles = unlist(tempfiles)
    for(tbl in temppath){
      DTname1 = paste0(gsub(directory, "", tbl))
      DTname2 = paste0(gsub("/", "", DTname1))
      DTname3 = paste0(gsub(i, "", DTname2))
      DTable <- data.table::fread(input = tbl,
                                  sep=sep,
                                  nrows=nrows,
                                  header=header,
                                  na.strings=na.strings,
                                  stringsAsFactors=stringsAsFactors,
                                  verbose = verbose,
                                  autostart=autostart,
                                  skip=skip,
                                  drop=drop,
                                  colClasses=colClasses,
                                  dec=if (sep!=".") "." else ",",
                                  col.names,
                                  check.names=check.names,
                                  encoding=encoding,
                                  quote=quote,
                                  strip.white=strip.white,
                                  fill=fill,
                                  blank.lines.skip=blank.lines.skip,
                                  key=key,
                                  showProgress=getOption("datatable.showProgress"),
                                  data.table=getOption("datatable.fread.datatable")
      )
      assign_to_global <- function(pos=1){
        assign(x = DTname3,value = DTable, envir=as.environment(pos) )
      }
      assign_to_global()

      rm(DTable)
      }
    }
  }
}
