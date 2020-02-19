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
RUN mkdir -p mmm2020

# Create a container volume to make data persistent
VOLUME /home/${NB_USER}/mmm2020

# Install Python requirements with Conda
RUN conda install --quiet --yes \
  'numpy' \
  'scipy=1.4*' \
  'seaborn=0.9.*' \
  'pandas=0.25.*' \
  'matplotlib-base=3.1.*' \
  'scikit-learn=0.22.*' && \
conda install -c conda-forge \
  'ase' \
  'nglview' \
  'spglib' \
&& \
conda clean --all -f -y && \
jupyter-nbextension enable nglview --py --sys-prefix && \
rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
rm -rf /home/$NB_USER/.cache/yarn && \
rm -rf /home/$NB_USER/.node-gyp && \
fix-permissions $CONDA_DIR && \
fix-permissions /home/$NB_USER

# Download and compile librascal
RUN git clone https://github.com/cosmo-epfl/librascal .librascal

RUN mkdir -p .librascal/build && \
cd .librascal/build && \
cmake -DUSER=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=ON -DBUILD_BINDINGS=ON .. && \
make install

USER $NB_UID
