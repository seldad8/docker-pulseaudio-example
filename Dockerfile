FROM centos:7

ENV UNAME pacat

RUN yum install -y pulseaudio-utils sudo
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} $UNAME && \
    useradd -d /home/$UNAME -g ${GID} -u ${UID} -m $UNAME && \
    echo "$UNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    gpasswd -a $UNAME audio


COPY pulse-client.conf /etc/pulse/client.conf

USER $UNAME
ENV HOME /home/pacat

# run
CMD ["pacat", "-vvvv", "/dev/urandom"]
