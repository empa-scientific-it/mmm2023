# Docker container for Molecular and Materials Modelling 2023

With Docker installed, open a terminal (Bash on Linux/macOS or PowerShell on Windows) and run

```
docker container run -p 8888:8888 empascientificit/mmm2023
```

If you want to have the content of your folder `mmm2023` **shared** between your local machine and the Docker container, first create a folder where to store your personal data.

For example:

```
mkdir -p ${HOME}/mmm2023
cd ${HOME}/mmm2023
```

Then, add the following option to the `docker container run` command above: `-v ${pwd}:/home/jovyan/mmm2023`.

### Clone the extra repositories

To clone the extra repositories, run the utility script `clone-repo.sh` from a terminal **inside the container**.
