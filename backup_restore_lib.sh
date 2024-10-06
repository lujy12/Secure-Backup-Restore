#!bin/bash

function validate_backup_params(){
      Source=$1
      Destination=$2
      EncriptionKey=$3
      
      if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
            echo "Error! Missing parameters!"
            exit 1
      fi
      
      if [ ! -d "$1" ] || [ ! -d "$2" ]; then
            echo "Error! Invalid!"
            exit 1
      fi    
      
      if diff -r $Source $Destination > /dev/null; then
            valid=false
            echo "Directory paths cannot be the same"
      fi
            
}


function backup(){
      Source=$1
      Destination=$2
      EncriptionKey=$3
      
      #Date and Time
      DATE=$(date +"%Y-%m-%d_%H:%M:%S" | sed 's/[ :]/_/g')


      #Creating a new backup destination
      NewDestination="$Destination/$DATE"
      mkdir -p "$NewDestination"

      echo "Saving to: $NewDestination"

      #Looping over all directories under the backup directory
      for d in "$Source"/*; do
            if [ -d "$d" ]; then
                  dir=$(basename "$d")
                  TFile="$NewDestination/${dir}_${DATE}.tgz"
                  
                  #create a tar file 
                  tar -czf "$TFile" -C "$Source" "$dir"
                  
                  #encrypt the tar file
                  gpg --symmetric --batch --passphrase "$EncriptionKey" -o "$TFile.gpg" "$TFile"
                  
                  #delete the tar file
                  rm "$TFile"
            fi
      done
      
      updatedTarFile="$NewDestination/files_${DATE}.tgz"
      
      first=true
      for f in "$Destination"/*; do
            if [ -f "$f" ]; then
                  if [ "$first" = true ]; then
                        tar -cf "$updatedTarFile" -C "$Destination" "$(basename "$f")"
                  else
                        tar -uf "$updatedTarFile" -C "$Destination" "$(basename "$f")"
                  fi
            fi
      done
      
      #compressing the tar file using gzip
      tar -czf "$updatedTarFile" -C "$Source" "$dir"
      
      gpg --symmetric --batch --passphrase "$EncriptionKey" -o "$updatedTarFile.gpg" "$updatedTarFile"

      #removing the tar file
      rm "$updatedTarFile"
                        
      echo "Backup finished successfully!"
      
}


function validate_restore_params(){
      Source=$1
      Destination=$2
      DecriptionKey=$3
      
      if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
            echo "Error! Missing parameters!"
            exit 1
      fi
      
      if [ ! -d "$1" ] || [ ! -d "$2" ]; then
            echo "Error! Invalid Inputs!"
            exit 1

      fi
}     
      
function restore(){
      TempDir="$Destination/temp" 
      mkdir -p "$TempDir"

      #looping over encrypted files
      for EncryptedFile in "$Source"/*.gpg; do 
            if [ -f "$EncryptedFile" ]; then 
                  gpg --output "$TempDir/$(basename "${EncryptedFile%.gpg}")" --decrypt --batch --passphrase "$DecriptionKey" "$EncryptedFile" 
            fi 

      done  
      
      #looping over the decrypted files
      for DecriptedFile in "$TempDir"/*; do 
            if [ -f "$DecriptedFile" ]; then 
                  tar -xzf "$DecriptedFile" -C "$Destination" 
            fi 
      done 
      
      rm -rf "$TEMP_DIR" 
      
      echo "Restore finished successfully!"     
      
}
