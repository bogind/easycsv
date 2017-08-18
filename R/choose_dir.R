#' @export
#' @importFrom utils choose.dir
choose_dir = function(){
  Identify.OS = function(){
    pl <- .Platform$OS.type
    if(tolower(pl) == "windows"){
      os = structure("windows", class = "character")
    }
    else{
      si <- as.list(Sys.info())
      if(tolower(si$sysname) == "linux"){
        os = structure("Linux", class = "character")
      }
      if(tolower(si$sysname) == "darwin"){
        os = structure("MacOSX", class = "character")
      }
    }
    return(os)
  }
  os = Identify.OS()
  if(tolower(os) == "windows"){
    directory <- choose.dir()
  }
    if(tolower(os) == "linux"){
      directory <- system("zenity --file-selection --directory")
    }
    if(tolower(os) == "macosx"){
      system("osascript -e 'tell app \"R\" to POSIX path of (choose folder with prompt \"Choose Folder:\")' > /tmp/R_folder",
             intern = FALSE, ignore.stderr = TRUE)
      directory <- system("cat /tmp/R_folder && rm -f /tmp/R_folder", intern = TRUE)
    }
  else{
    message("Your Operating System does not support this functiona t this time")
    stop("Please contact us at: 'https://github.com/bogind/easycsv/issues', so that we may implement it on your system with the next version")}
  return(directory)
}
