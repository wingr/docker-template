## Overview
A base setup template for using Docker at GitHub.

## Possible changes needed
#### Dockerfile
* Check the version of Python at the top
* In the Dockerfile, change `src/` to top-level project directory

#### script/app-env
* Change `DOCKER_IMAGE` name to match your repo name (line 10)
* Change `appdir:/src` to `appdir:/your-top-dir` (line 12)

#### script/bootstrap-docker
* Change the final name to your repo name - make sure to leave a space between the repo name and the final period (line 7)

#### script/run
* Change the structure of this file to call your actual application.
* The path insertion on line 7 allows you to import your modules from the `src/` directory (or whatever you end up calling it).

#### script/test
* Change the `/src` to your top-level project directory (line 8)

#### src/ files
* This directory is where your application goes. It can be named differently and you should change the example stub file in this directory.

#### Other
* Load `requirements.txt` with what you need
* Don't forget to copy over the `.gitignore` and `.dockerignore` file

## Setup
To create the Docker container, run `$ script/bootstrap-docker`

## Running applications
* The design of this setup is to allow for CLI by using the `script/run` file as the entry point into the application. Given this setup, to run you call, `script/app-env script/run` plus any command line arguments. The `script/app-env` part puts you into the Docker container's environment, and the `script/run` part is the entry point into the application as mentioned above.
* There is an issue with passing multiple word command line arguments to Docker with this setup even if they are in quotes, just FYI.
