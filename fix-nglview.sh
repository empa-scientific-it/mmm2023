#!/bin/bash
conda install -y -c conda-forge nglview=2.7.1 && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install nglview-js-widgets@2.7.1 && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

