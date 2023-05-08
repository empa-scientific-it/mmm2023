# Docker container for Molecular and Materials Modelling 2023

Create a folder where to store your personal data. This folder will be visible from within the container.

For example:

```
mkdir -p ${HOME}/mmm2023
cd ${HOME}/mmm2023
```

With Docker installed, open a terminal (Bash on Linux/macOS or PowerShell on Windows) and run

```
docker container run -p 8888:8888 -v $(pwd):/home/jovyan/mmm2023 empascientificit/mmm2023
```
