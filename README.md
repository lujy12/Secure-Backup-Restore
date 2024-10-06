# Secure backup/restore
#### This code enables backing up and restoring of directories to ensure secure storage.

## Backup
### Running the backup file:
#### ./backup.sh <Source> <Destination> <EncryptionKey>
- **Source** = Path to source directory
- **Destination** = Path to destination directory
- **EncriptionKey** = Passphrase for encryption

## Restore
### Running the restore file:
#### ./backup.sh <Source> <Destination> <DecryptionKey>
- **Source** = Path to source directory
- **Destination** = Path to destination directory
- **DecriptionKey** = Passphrase for decryption
