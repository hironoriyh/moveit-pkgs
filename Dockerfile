FROM jenniferbuehler/general-message-pkgs 

MAINTAINER Jennifer Buehler

# Install required ROS dependencies
RUN apt-get update && apt-get install -y \
    ros-indigo-moveit-core \
    ros-indigo-shape-tools \
    ros-indigo-eigen-conversions \
    ros-indigo-roslint \
    && rm -rf /var/lib/apt/lists/

# install git
RUN apt-get update && apt-get install -y git
    
COPY moveit_controller_multidof /catkin_ws/src/moveit_controller_multidof
COPY object_moveit /catkin_ws/src/object_moveit

# Get the repository tools-pkgs as well, for the convenience_* dependencies
RUN bin/bash -c "cd /catkin_ws/src \
    && git clone https://github.com/JenniferBuehler/tools-pkgs.git \
    && rm -rf src/tools-pkgs/inventor_viewer"

# Build
RUN bin/bash -c "source /.bashrc \
    && cd /catkin_ws \
    && catkin_make \
    && catkin_make install"

RUN bin/bash -c "source .bashrc"

CMD ["bash","-l"]
