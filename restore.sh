#!bin/bash
source ./backup_restore_lib.sh

read Source Destination DecriptionKey
validate_restore_params $Source $Destination $DecriptionKey

read Source Destination DecriptionKey
restore $Source $Destination $DecriptionKey
