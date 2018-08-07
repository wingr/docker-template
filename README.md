## Overview
A base project setup template for using Docker for a Python project.

## Possible changes needed
The changes below assume that you are dockerizing an entire repository. However, if you only want to dockerize a single directory within the repository, all the directions stay the same, but the "_repo name_" would be replaced by the name of the directory in which the `Dockerfile` lives.

#### Dockerfile
* Check the version of Python at the top
* In the Dockerfile, change `src/` to top-level project directory

#### script/app-env
* Change `DOCKER_IMAGE` name to match your repo name, or the name of the containing directory (line 10)
* Change `appdir:/src` to `appdir:/your-top-dir` (line 12)

#### script/bootstrap
* Change the final name to your repo name - make sure to leave a space between the repo name and the final period (line 7)

#### script/cibuild-verify-image
No changes needed

#### script/run
* Change the structure of this file to call your actual application.
* The path insertion on line 7 allows you to import your modules from the `src/` directory (or whatever you end up calling it).

#### script/test
* Change the `/src` to your top-level project directory (line 8)

#### script/view-docker-logs
* No changes needed
* This script prints logs for the latest running docker container, or stopped container if none are currently running, or for a given container id.

#### src/ files
* This directory is where your application goes. It can be named differently and you should change the example stub file in this directory.

#### Other
* Load `requirements.txt` with what you need
* Don't forget to copy over the `.gitignore` and `.dockerignore` file

## Setup
1. Clone repository
2. To create the Docker container, run `script/bootstrap`
3. Test that the container is setup correctly by running , `script/app-env pytest tests/test_docker_setup.py`

## Running applications
* The design of this setup is to allow for CLI by using the `script/run` file as the entry point into the application. Given this setup, to run you call,
    * `script/app-env script/run` plus any command line arguments.
    * The `script/app-env` part puts you into the Docker container's environment, and the `script/run` part is the entry point into the application as mentioned above.

* You can also run other commands inside Docker, e.g.
    * `$ script/app-env python some_other_module.py --infile "myfile.txt"` (to run a different Python module)
    * `$ script/app-env python` (to get into the Python shell within the container)

* There is an issue with passing multiple word command line arguments to Docker with this setup even if they are in quotes, just FYI.
