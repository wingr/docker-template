## Overview
A base project setup template for using Docker for a Python project.

## Possible changes needed
The changes below assume that you are dockerizing an entire repository. However, if you only want to dockerize a single directory within the repository, all the directions stay the same, but the "_repo name_" would be replaced by the name of the directory in which the `Dockerfile` lives.

#### Dockerfile
* Check the version of Python at the top - this may need to be updated
* In the Dockerfile, change `src/` to top-level project directory
* To work with Tensorflow on a GPU instance, change the top line to `FROM tensorflow/tensorflow:latest-gpu-py3`

#### script/app-env
* (OPTIONAL) Change `DOCKER_IMAGE` name if you want (line 12). By default it is given the name of the directory containing the `Dockerfile`
* Change `appdir:/src` to `appdir:/your-top-dir` (lines 19 & 21)
* To run with GPU (see change to Dockerfile also), you will need to change the last line to use nvidia, like `exec docker run --runtime=nvidia -i -t -v "$appdir:/src" $image $cmd`
* You can also use environment variables for to create the `imagename` or other fields (assumes they are stored in the `script/` directory in a `.env` file),

#### script/bootstrap
* (OPTIONAL) Change the image name if you want (line 9). If you do, make sure to leave a space between the image name and the final period. By default the name of the directory containing the `Dockerfile` is used.

#### script/cibuild-verify-image
No changes needed

#### script/run
* Change the structure of this file to call your actual application.
* The path insertion on line 19 allows you to import your modules from the `src/` directory (or whatever you end up calling it).

#### script/server
This file is used to run a GPU-powered jupyter notebook on a GPU instance. It will not work unless you have nvidia installed.
* Change the directory structure for the volume mount, `-v`, to match your project. The first directory path is the path on the local (or instance) machine and the path after the colon is the directory in the container. I would recommend using the `$(pwd)` to get the full directory path to the directory that contains your project (e.g. the Dockerfile). Also, you will notice a double `/src/src/` in the second directory path. The first `/src` is the directory we mapped in the Dockerfile for our working directory and the second `src/` is a directory in this specific project setup which contains our files. This second `/src/` may change dependind on how you have the project set up.
* Change the last part of the last line to match your repository name or the containing directory for your project.

#### script/test
* Change the `/src` to your top-level project directory (line 8)

#### script/view-docker-logs
* No changes needed
* This script prints logs for the latest running docker container, or stopped container if none are currently running, or for a given container id passed as a command line argument.

#### src/ files
* This directory is where your application goes. It can be named differently, but then you should change the references in the scripts above.

#### Other
* Load `requirements.txt` with what you need
* Don't forget to copy over the `.gitignore` and `.dockerignore` file

## Setup
1. Clone repository
2. Create a `.env` file within the `script/` directory (can do `touch script/.env` for an empty file)
3. To create the Docker container, run `script/bootstrap`
4. Test that the container is setup correctly by running , `script/test`

## Running applications
* The design of this setup is to allow for CLI by using the `script/run` file as the entry point into the application. Given this setup, to run you call,
    * `script/app-env script/run` plus any command line arguments.
    * The `script/app-env` part puts you into the Docker container's environment, and the `script/run` part is the entry point into the application as mentioned above.

* You can also run other commands inside Docker, e.g.
    * `$ script/app-env python some_other_module.py --infile "myfile.txt"` (to run a different Python module)
    * `$ script/app-env python` (to get into the Python shell within the container)

* There is an issue with passing multiple-word command line arguments to Docker with this setup even if they are in quotes, just FYI.
