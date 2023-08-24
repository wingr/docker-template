FROM python:3.9.6
LABEL MAINTAINER="@wingr"

# send SIGQUIT to stop container
STOPSIGNAL SIGQUIT

RUN touch /etc/inside-container

# Setting to a non-empty string ensures python output sent straight to terminal and is not buffered
ENV PYTHONUNBUFFERED=0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      build-essential \
      vim

# Install all Python dependencies
COPY requirements.txt ./
RUN pip install -U pip
RUN pip install -r requirements.txt
#RUN pip install --no-cache-dir -r requirements.txt

# Copy all files to the container's `/src` directory and set working directory to that folder
COPY . /src
WORKDIR /src

