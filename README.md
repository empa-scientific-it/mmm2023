# Fix `nglview` in Jupyter Lab

### NOTE: Start a container with Jupyter Lab

This fix is required to make **nglview** work with Jupyter Lab. If you **did not** run the container with the option `-e JUPYTER_ENABLE_LAB=yes`, you should first stop and remove the container we used during the introductory lecture. To do so:

1. Retrieve the name of the running (or stopped) container with `docker container ls -a`.

2. Remove the container with `docker container rm -f <NAME>`

3. **Be sure** to be in your MMM2020 directory. And remember that the shortcut `$(pwd)` used in the command below only works on Linux, macOS or in the Docker Quickstart Terminal. If you are using Windows PowerShell, replace `$(pwd)` with `${pwd}`.

4. Run a new container with `docker container run -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v $(pwd):/home/jovyan/mmm2020 baldone/mmm2020`

---

The script `fix-nglview.sh` contains a few commands to make sure that the Jupyter extension [nglview](https://github.com/arose/nglview/releases) works also within a notebook opened in Jupyter Lab. Follow the steps to run the script:

1. Make sure that the Docker container we set up during the first lecture is running. To do so, run in a terminal `docker container ls`. You should see at least a line saying that a container from the image `baldone/mmm2020` is up (check the `STATUS` column).

2. Restart the container

    1. If you started the container **without** `JUPYTER_ENABLE_LAB=yes` by following the pre-course setup PDF, then refer to the [previous section](https://github.com/edoardob90/mmm2020/blob/master/README.md#note-start-a-container-with-jupyter-lab)

    2. If you stopped the container, you can restart the one we used in the first lecture with `docker container start <NAME>`. To get the name of the container even if it's stopped, use `docker container ls -a` (notice the `-a` which means **all** the containers, stopped or running) and take note of the container's name under the `NAME` column.

3. With a running container, issue the following command: `docker container exec -it <NAME> bash -c 'wget https://raw.githubusercontent.com/edoardob90/mmm2020/master/fix-nglview.sh && chmod +x fix-nglview.sh && ./fix-nglview.sh'`. Again, `NAME` is the container's name you discovered in the previous step.

The last step will take some time, and a new prompt returns when its done. You can now return to Jupyter Lab in your browser and check with the notebook `ASE.ipynb` that everything works as expected.


#### HELP: I don't know where to find the address or the token to access Jupyter Lab!

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


# Prepare and run the Docker container

### NOTE

The following is needed **only** if:

1. You never started the container as explained in the pre-course setup

2. You removed by mistake or on purpose the container we used during the first lecture.

---

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
