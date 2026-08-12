# archived file

- combining multiple files together as a single file
- archived file is different than compressed file
- command: tar (tape archive)
  - tar <arguments> <file_name> <files>
  - -c: create a archived file
  - -t: check the contents of an archived file
  - -x: extract the files from the archived file
  - -f: archived file name
  - -v: verbose (print everything on console)

```bash

# create a temp directory
> mkdir /tmp/temp-files

# create 100 files in temp directory
> cd /tmp/temp-files
> touch file{1..100}

# archive all the files into a single file named files.tar
# -c: create an archived file
# -v: verbose
# -f: file name
# this command will create a file named files.tar with all files in the current directory
> tar -cvf myfiles.tar *

# remove all the files except the myfiles.tar
> rm file*

# check the contents of the archived file
# -t: check contents of the file
> tar -tvf myfiles.tar

# extract all the files from the archived file
# -x: extract the files
> tar -xvf myfiles.tar

```

# compressed file

- compressed file is a file with reduced size using algorithms
  - lossy algorithm
    - when the file gets compressed, the data/information gets lost
    - e.g.
      - wav is original file format of audio and mp3 is compressed format of wav file
      - raw photo vs jpg format
      - 4K BDVD vs avi or flv format
  - lossless algorithm
    - when the data/information is not lost
    - e.g.
      - gzip: GNU zip
      - bzip
      - xzip: modern and latest utility used to compress the file

```bash

# compress a myfiles.tar file
# this command will create a new compressed file named myfiles.tar.gz and will remove the original file myfiles.tar
> gzip myfiles.tar

# compress a file without loosing the original file
# -k: keep the original file
> gzip -k myfiles.tar

# decompress a compressed file
# this command will decompress the myfiles.tar.gz into the original file myfiles.tar and will remove file myfiles.tar.gz
> gunzip myfiles.tar.gz

# decompress a compressed file without loosing the compressed one
# -k: keep the compressed file
> gunzip -k myfiles.tar.gz

```

# archived and compressed together

```bash

# archive and compress all files together
# -j: use gzip to compress the file
> tar -cjvf myfile.tar.gz *

```
