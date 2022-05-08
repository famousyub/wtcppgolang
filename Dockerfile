# configure l'image de base
FROM debian:stretch-slim
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    ca-cacert \
    cmake \
    build-essential \
    libboost-all-dev \
    libssl-dev \
    wget \
    zlib1g-dev

# installe Wt4
WORKDIR /root
RUN wget https://github.com/emweb/wt/archive/4.0.4.tar.gz
RUN tar zxf 4.0.4.tar.gz
WORKDIR /root/wt-4.0.4/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DBUILD_EXAMPLES=OFF ..
RUN make -j2 install
RUN ldconfig

# compile notre application puis configure la commande de lancement
WORKDIR /root/myrepeat
ADD . /root/myrepeat
RUN g++ -O2 -o myrepeat myrepeat.cpp -lwthttp -lwt
CMD /root/myrepeat/myrepeat --docroot . --http-address 0.0.0.0 --http-port $PORT