# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:lunar-desktop-xenial

#RUN apt-get u# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository universe
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    git \
    python2.7 \
    python-pip
RUN pip install --upgrade pip

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-lunar-desktop-full=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# install jupyter and configure
RUN pip2 install jupyter
RUN pip2 install matplotlib

RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

RUN mkdir notebooks

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/notebooks", "--ip=0.0.0.0", "--port=8888", "--no-browser"]
