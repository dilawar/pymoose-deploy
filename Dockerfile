FROM quay.io/pypa/manylinux1_x86_64
MAINTAINER Dilawar Singh <dilawar.s.rajput@gmail.com>

# If you are behind proxy,  uncomment the following lines with appropriate
# values. Otherwise comment them out.
# ENV http_proxy http://proxy.ncbs.res.in:3128
# ENV https_proxy http://proxy.ncbs.res.in:3128
ENV PATH=/usr/local/bin:$PATH

RUN yum update
RUN yum install -y cmake28 && ln -sf /usr/bin/cmake28 /usr/bin/cmake
RUN yum install -y wget  
RUN if [ ! -f /usr/local/lib/libgsl.a ]; then \
    wget --no-check-certificate ftp://ftp.gnu.org/gnu/gsl/gsl-2.4.tar.gz && \
    tar xvf gsl-2.4.tar.gz && cd gsl-2.4 && \
    CFLAGS=-fPIC ./configure --enable-static && make -j4 && \
    make install && cd ..; fi 

RUN git clone https://github.com/BhallaLab/pymoose-wheels 
RUN cd pymoose-wheels && ls && ./build_wheels.sh
