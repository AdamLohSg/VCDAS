FROM nvcr.io/nvidia/tensorrt:20.03-py3

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get update && apt-get install -y \
	build-essential \
	libopencv-dev \
	autoconf \
	automake \
	wget\
	python3.6 \
	python3-pip \
	python3-dev \
	libtool \
	curl \
	dos2unix\
	unzip





# install these pip packages
RUN pip install Cython
RUN pip install tensorboard==1.15.0 \
    tensorboardX \
    jupyter-console \
    jupyterlab \
    ipywidgets \
    kubeflow-fairing \
    awscli \
    opencv-python==4.2.0.32\
    matplotlib \
    pycocotools \
    tqdm \
    pillow \
    jupyter-tensorboard

# install mlflow and mysql dependencies
RUN apt-get update --fix-missing && apt-get install -y default-libmysqlclient-dev 
RUN pip3 install --upgrade setuptools
RUN pip3 install mlflow==1.8.0 mysql-connector-python mysqlclient



RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g npm && \
    jupyter labextension install jupyterlab_tensorboard

WORKDIR /home




# include the following lines in your Dockerfile
EXPOSE 8888
ENV NB_PREFIX /
CMD ["sh", "-c", "jupyter lab --notebook-dir=/home --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
