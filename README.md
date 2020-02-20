# Quick README

Create a folder where to store your personal data. This folder will be visible from within the container.

```
mkdir -p ${HOME}/mmm2020
cd ${HOME}/mmm2020
```

With Docker installed, open a terminal (Bash on Linux/macOS or Quickstart Terminal on Windows) and run

```
docker container run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd):/home/jovyan/mmm2020 baldone/mmm2020
```

**A note for Windows user:** if you are using Docker Toolbox for Windows, you can issue the above commands from Docker Quickstart Terminal which emulates a Bash shell. If you are using Docker for Windows (only Windows 10 Pro/Enteprise), then you might want to use Windows PowerShell. Create your working drectory and use its path accordingly.


## Fix `nglview` in Jupyter Lab

The script `fix-nglview.sh` contains a few commands to make sure that the Jupyter extension [nglview](https://github.com/arose/nglview/releases) works also within a notebook opened in Jupyter Lab. Follow the steps to run the script:

1. Make sure that the Docker container we set up during the first lecture is running. To do so, run in a terminal `docker container ls`. You should see at least a line saying that a container from the image `baldone/mmm2020` is up (check the `STATUS` column).

2. If no container is running, you can restart the one we used in the first lecture with `docker container start <NAME>`. To get the name of the container even if it's stopped, use `docker container ls -a` (notice the `-a` which means **all** the containers, stopped or running) and take note of the container's name under the `NAME` column.

3. With a running container, issue the following command: `docker container exec -it <NAME> bash -c 'wget https://raw.githubusercontent.com/edoardob90/mmm2020/master/fix-nglview.sh && chmod +x fix-nglview.sh && ./fix-nglview.sh'`. Again, `NAME` is the container's name you discovered in the previous step.

The last step will take some time, and a new prompt returns when its done. You can now return to Jupyter Lab in your browser and check with the notebook `ASE.ipynb` that everything works as expected.


#### I don't know where to find the address or the token to access Jupyter Lab!

Remember that you can **always** go back to Jupyter Lab by opening the browser and going to `https://localhost:8888`. If you have Docker Toolbox for Windows, please refer to our setup guide to know which address to use.

If you are asked the token and you didn't copy it or you re-run a new container, you can use the command `docker logs <NAME>`: you should see an output similar to the one below:

```
Executing the command: jupyter lab
[I 12:46:10.617 LabApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[I 12:46:10.993 LabApp] JupyterLab extension loaded from /opt/conda/lib/python3.7/site-packages/jupyterlab
[I 12:46:10.994 LabApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 12:46:11.204 LabApp] Serving notebooks from local directory: /home/jovyan
[...]
[C 12:46:11.214 LabApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-6-open.html
    Or copy and paste one of these URLs:
        http://42d230575636:8888/?token=8c51b3ad24c06116b3bfb6fd5618b91e3730b7afb2be5e9c
     or http://127.0.0.1:8888/?token=8c51b3ad24c06116b3bfb6fd5618b91e3730b7afb2be5e9c
```

You can then easily retrieve the token or open directly the link from the output log.