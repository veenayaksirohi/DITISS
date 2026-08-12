FROM python:3.15-rc-alpine3.21
WORKDIR /src
COPY . .
EXPOSE 4000
RUN pip install -r requirements.txt
CMD python server.py
