# consider python as base image as python is required to run the application
FROM python

# set the working directory
WORKDIR /src

# copy everything from current directory to /src
# first .: current working directory of local machine
# second .: working directory of image (/src)
# COPY . .
COPY . /src

# since the server is going to listen on port 5000
EXPOSE 5000

# install all the requirements while building the image
RUN pip3 install -r requirements.txt

# start the server when a container starts
CMD python3 server.py