#' @importFrom utils installed.packages
#' @importFrom data.table fread
#' @export
fread_folder = function(directory = NULL,
                        extension = "CSV",
                        sep="auto",
                        nrows=-1L,
                        header="auto",
                        na.strings="NA",
                        stringsAsFactors=FALSE,
                        verbose=getOption("datatable.verbose"),
                        skip=0L,
                        drop=NULL,
                        colClasses=NULL,
                        integer64=getOption("datatable.integer64"),         # default: "integer64"
                        dec=if (sep!=".") "." else ",",
                        check.names=FALSE,
                        encoding="unknown",
                        quote="\"",
                        strip.white=TRUE,
                        fill=FALSE,
                        blank.lines.skip=FALSE,
                        key=NULL,
                        Names=NULL,
                        prefix=NULL,
                        showProgress = interactive(),   # default: TRUE
                        data.table=TRUE,   # default: TRUE
                        combine = c("global", "data.frame", "list")
){


  if ("data.table" %in% rownames(installed.packages()) == FALSE) {
    stop("data.table needed for this function to work. Please install it.",
         call. = FALSE)
  }

  combine <- match.arg(combine)

  if(is.null(directory)){
    os = Identify.OS()
    if(tolower(os) == "windows"){
      directory <- utils::choose.dir()
      if(tolower(os) == "linux" | tolower(os) == "macosx"){
        directory <- choose_dir()
      }
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
  tempdf_list = list()
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

      count = 0
      for(tbl in temppath){
        count = count+1
        DTname1 = paste0(gsub(directory, "", tbl))
        DTname2 = paste0(gsub("/", "", DTname1))
        if(!is.null(Names)){
          if((length(Names) != length(temppath))| (class(Names) != "character")){
            stop("Names must a character vector of same length as the files to be read.")
          }else{
            DTname3 = Names[count]
          }

        }else{
          DTname3 = paste0(gsub(i, "", DTname2))
        }
        if(!is.null(prefix) && is.character(prefix)){
          DTname4 = paste(prefix,DTname3, sep = "")
        }else{
          DTname4 = DTname3
        }

        DTable <- data.table::fread(input = tbl,
                                    sep=sep,
                                    nrows=nrows,
                                    header=header,
                                    na.strings=na.strings,
                                    stringsAsFactors=stringsAsFactors,
                                    verbose = verbose,
                                    skip=skip,
                                    drop=drop,
                                    colClasses=colClasses,
                                    dec=if (sep!=".") "." else ",",
                                    check.names=check.names,
                                    encoding=encoding,
                                    quote=quote,
                                    strip.white=strip.white,
                                    fill=fill,
                                    blank.lines.skip=blank.lines.skip,
                                    key=key,
                                    showProgress=showProgress,
                                    data.table=data.table
        )

        if (combine == "global") {

          assign_to_global <- function(pos=1){
            assign(x = DTname4,value = DTable, envir=as.environment(pos) )
          }
          assign_to_global()
        } else {
                    tempdf_list <- append(tempdf_list, setNames(list(DTable), DTname4))

        }

        rm(DTable)
      }
    }
  }



  if (combine != "global") {

    if (combine == "data.frame") {
      tempdf = data.table::rbindlist(tempdf_list)

      if(!data.table) {
        tempdf = as.data.frame(tempdf)
      }
      return(tempdf)
    } else {
      return(tempdf_list)
    }


  }

}
