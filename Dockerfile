FROM centos

# The developer's username
ENV LOGIN vbremond
# The language this container is about
ENV CONTAINER_LANGUAGE java
# Where to store the code in the container
ENV WORKDIR /code/
# Softwares versions
ENV JAVA_VERSION 1.8.0
ENV GRADLE_VERSION 2.7



RUN curl -sL http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo > /etc/yum.repos.d/fish-shell.repo

RUN yum install -y \
    fish \
    tar \
    git \
    gzip \
    unzip \
    vim-enhanced \
    java-${JAVA_VERSION}-openjdk-devel.x86_64 \
    java-${JAVA_VERSION}-openjdk-headless.x86_64

RUN mkdir /usr/local/gradle/
RUN curl -sL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip > /usr/local/gradle/gradle-${GRADLE_VERSION}-all.zip
RUN unzip -q /usr/local/gradle/gradle-${GRADLE_VERSION}-all.zip -d /usr/local/gradle/

ENV PATH $PATH:/usr/local/gradle/gradle-${GRADLE_VERSION}/bin/

RUN adduser --user-group --uid 1000 --home /home/$LOGIN $LOGIN

COPY fish/ /home/$LOGIN/.config/fish/
COPY vim/ /home/$LOGIN/.vim/
COPY vim/vimrc /home/$LOGIN/.vimrc

RUN chown -R $LOGIN:$LOGIN /home/$LOGIN/

RUN mkdir /$WORKDIR/
RUN chown -R $LOGIN:$LOGIN /$WORKDIR/

USER $LOGIN
WORKDIR $WORKDIR

CMD fish
