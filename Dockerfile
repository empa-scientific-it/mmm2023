# Docker image file
# Pulling from jupyter/scipy-notebook
FROM jupyter/base-notebook

USER root

# Install Ubuntu packages
RUN apt-get update && apt-get install -yq --no-install-recommends --fix-missing \
  apt-utils \
  build-essential \
  git \
  nano \
  vim \
  clang \
  cmake \
  libboost-test-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Swtich back to normal user
USER $NB_UID

WORKDIR /home/${NB_USER}

# Create a directory for the course material
RUN mkdir -p mmm2023

# Clone additional repositories
WORKDIR /home/${NB_USER}/mmm2023

RUN git clone https://github.com/lab-cosmo/kernel-tutorials.git && \ 
  git clone https://github.com/ramador09/Molecular-and-Materials-Modelling-FS2023.git

# Create a container volume to make data persistent
VOLUME /home/${NB_USER}/mmm2023

# Download and compile librascal
RUN git clone https://github.com/cosmo-epfl/librascal .librascal

RUN mkdir -p .librascal/build && \
  cd .librascal/build && \
  cmake -DUSER=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -DBUILD_BINDINGS=ON .. && \
  make install

# Install Python requirements with Conda
RUN conda install --quiet --yes \
  'numpy' \
  'scipy' \
  'seaborn' \
  'matplotlib-base' \
  'scikit-learn'

RUN conda install -y -c conda-forge \
  'skmatter' \
  'ipywidgets' \
  'ase' \
  'nglview' \
  'spglib'

# conda clean --all -f -y && \
# jupyter nbextension enable --py --sys-prefix nglview && \
# jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
# jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
# jupyter labextension install nglview-js-widgets@2.7.1 && \
# rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
# rm -rf /home/$NB_USER/.cache/yarn && \
# rm -rf /home/$NB_USER/.node-gyp && \
# fix-permissions $CONDA_DIR && \
# fix-permissions /home/$NB_USER

# Switch to normal user
WORKDIR /home/${NB_USER}
USER $NB_UID
