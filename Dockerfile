# Script to build Python 3 version of MalmoPython.so.

FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	cmake \
	cmake-qt-gui \
	libboost-all-dev \
	libpython2.7-dev \
	lua5.1 \
	liblua5.1-0-dev \
	openjdk-8-jdk \
	swig \
	xsdcxx \
	libxerces-c-dev \
	doxygen \
	xsltproc \
	ffmpeg \
	python-tk \
	python-imaging-tk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN update-ca-certificates -f

RUN apt-get update && apt-get install -y wget unzip libpython3.5-dev

WORKDIR /root
RUN git clone https://github.com/Microsoft/malmo.git Malmo
RUN wget https://raw.githubusercontent.com/bitfehler/xs3p/1b71310dd1e8b9e4087cf6120856c5f701bd336b/xs3p.xsl -P /root/Malmo/Schemas
ENV MALMO_XSD_PATH=/root/Malmo/Schemas

WORKDIR /usr/lib/x86_64-linux-gnu/
RUN ln -sf libboost_python-py35.so libboost_python.so
RUN ln -sf libboost_python-py35.a libboost_python.a

WORKDIR /root/Malmo
RUN mkdir build
WORKDIR /root/Malmo/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_PYTHON_VERSIONS="3.5" -DINCLUDE_CSHARP=no -DINCLUDE_LUA=no
RUN make -j4
RUN make package

# finally copy Malmo package from container to local machine:
# docker cp <containerID>:/root/Malmo/build/Malmo<something>.zip .
# unzip Malmo<something>.zip -d minecraft_py
# rename the directory to Malmo
# delete irrelevant subdirectories
# (TO BE AUTOMATED AT SOME POINT)
