# Quick README

Create a folder where to store your personal data. This folder will be visible from within the container.

```
mkdir -p ${HOME}/courses/mmm2020
cd ${HOME}/courses/mmm2020
```

With Docker installed, open a terminal (Bash on Linux/macOS or Quickstart Terminal on Windows) and run

```
docker container run --rm -p 80:8888 -v $(pwd):/home/jovyan/work baldone/mmm2020
```

**A note for Windows user:** if you are using Docker Toolbox for Windows, you can issue the above commands from Docker Quickstart Terminal which emulates a Bash shell. If you are using Docker for Windows (only Windows 10 Pro/Enteprise), then you might want to use Windows PowerShell. Create your working drectory and use its path accordingly.
