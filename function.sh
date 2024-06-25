#!/bin/bash

##----------------------------------------------------------steps------------------------------------------------------
#1.getting the filepath 
  #2. after getting the filepath:
  #   1. get the file extension .----> extract function
  ##       1.1. search if there is hidden file or not --->hidden_files function
  #   2. search if that extension exist to redirect the file.----> search_extension function
                                                                ## files with unknown extension & hidden files redirect to misc sub_directory.
  #    3. create sub_directories ----> create_directory function.
  #    4.print 



##function take the directory path as an argument and organize files withen the directory

function iteration () {
    declare filepath 
    filepath="$1"
    ##chech if the path exists
    
    if [ ! -e "$filepath" ]; then
       echo "Path $filepath  not exists"
       exit 1
    fi

    ##searching on hidden files in the current directory

    hidden_files "$1"

    # Searching in the current directory

    for file in "$filepath"/* ; do

    if [ -f "$file" ]; then
        echo "${file}"
        extract "${file}"    
     else 
      exit 1
     fi
    
    done

}

##search for the hidden files

function hidden_files () {
    
    hidden=$(find $1 -type f -name ".*" )
    ext="."
    search_extension "$ext" "$hidden"

 }

##get the file extension 

function extract () {
    declare path="$1"
    declare extension=${path##*.}     ##any thing before dot ---->remove 
    echo "${extension}"
    search_extension "${extension}" "$path" 

}

##search for extension to create the directory

function search_extension () {
    
    case "${extension}" in
        txt)
            ext="txt"
           create_directory "$ext" "$2"
        ;;
        jpg)
            ext="jpg"
            create_directory "$ext" "$2"
        ;;
        pdf)
            ext="pdf"
            create_directory "$ext" "$2"
        ;;
        
        *)
        
            echo "default (none of above)"
            ext="misc"
            create_directory "$ext" "$2"
        ;;
    esac
    
}

##create sub_directories

function create_directory () {
    
    mkdir -p $filepath/$1   
    mv   $2  $filepath/$1/
   
}

##print 
 #1. using tree command --->print all the files and their subdirectories in the current directory
 #2. using ls ---> print files depend on the extension 
 #3. using ls ---> print all files in the directory.


##Method #1:
function printallfiles () {
    
     tree -a -c "$1"   ##--->Print hidden files in the given path

}

##Method2:
#function print () {
    ## $1 ia an extension
 #   case "$1" in
  #      txt)
   #         ls $2
    #    ;;
     #   jpg)
     #        ls $2  
     #   ;;
     #   pdf)
     #        ls $2
     #   ;;
     #   *)
     #         ls $2
     # ;;
    #esac

#}

##Method 3:

#function printallfiles () {

     ##echo "Downloads /"
     #echo "| --txt/"
     #ls "$1/txt"
     #echo "| --jpg/"
     #ls "$1/jpg"
     #echo "| --pdf/"
     #ls "$1/pdf"
     #echo "| --misc/"
     #ls "$1/misc"
     ##hidden_files "$filepath"
     
#}

