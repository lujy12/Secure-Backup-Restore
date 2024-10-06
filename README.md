# Secure backup/restore
#### This code enables backing up and restoring of directories to ensure secure storage.

## Backup:
### Running the backup file:
 ```bash
./backup.sh <Source> <Destination> <EncryptionKey>
```
- **Source** = Path to source directory
- **Destination** = Path to destination directory
- **EncriptionKey** = Passphrase for encryption

## Backup Process:
- Creates a new directory with the date
- Backs up each directory under the specified directory into a separate compressed tar file
- Encrypts each tar file using the provided encryption key
- Deletes the unencrypted files

## Restore:
### Running the restore file:
 ```bash
./backup.sh <Source> <Destination> <DecryptionKey>
```
- **Source** = Path to source directory
- **Destination** = Path to destination directory
- **DecriptionKey** = Passphrase for decryption

## Restore Process:
- Decrypts each file and restores them to a temporary directory
- Extracts the decrypted files back to the target directory
 
