# select the base image
FROM python

# set the working directory 
WORKDIR /src

# COPY server.py file to image
# second parameter . represents ths working directory of image (/src)
COPY server.py .

# install dependencies for the application
RUN pip install flask

# expose the required port
EXPOSE 5500

# start the server
CMD python server.py