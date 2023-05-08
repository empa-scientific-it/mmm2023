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

# Create a container volume to make data persistent
VOLUME /home/${NB_USER}/mmm2023

# Download librascal & install Python bindings
RUN mkdir -p /home/${NB_USER}/librascal && \
  cd /home/${NB_USER}/librascal && \
  git clone https://github.com/lab-cosmo/librascal .

# Compile C++ library
RUN cd /home/${NB_USER}/librascal && \
  pip install -r requirements.txt && \
  mkdir -p build && \
  cd build && \
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
  'nglview==3.0.4' \
  'ipywidgets==7.7.5' \
  'skmatter' \
  'ase' \
  'spglib'

# Switch to normal user
WORKDIR /home/${NB_USER}
USER $NB_UID
