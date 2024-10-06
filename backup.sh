#!bin/bash
source ./backup_restore_lib.sh

read Source Destination EncriptionKey
validate_backup_params $Source $Destination $EncriptionKey

read Source Destination EncriptionKey
backup $Source $Destination $EncriptionKey
