FROM centos

# The developer's username
ENV LOGIN vbremond
# Where to store the code in the container
ENV WORKDIR /code/
# Softwares versions
ENV JAVA_VERSION 1.8.0
ENV MAVEN_MAJOR_VERSION 3
ENV MAVEN_FULL_VERSION 3.3.3



RUN curl -sL http://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo > /etc/yum.repos.d/fish-shell.repo

RUN yum install -y \
    fish \
    tar \
    git \
    gzip \
    vim-enhanced \
    java-${JAVA_VERSION}-openjdk-devel.x86_64 \
    java-${JAVA_VERSION}-openjdk-headless.x86_64

RUN mkdir /usr/local/apache-maven
RUN curl -sL http://mirror.netcologne.de/apache.org/maven/maven-${MAVEN_MAJOR_VERSION}/${MAVEN_FULL_VERSION}/binaries/apache-maven-${MAVEN_FULL_VERSION}-bin.tar.gz > /usr/local/apache-maven/apache-maven-${MAVEN_FULL_VERSION}-bin.tar.gz
RUN tar -xzf /usr/local/apache-maven/apache-maven-${MAVEN_FULL_VERSION}-bin.tar.gz -C /usr/local/apache-maven/

ENV PATH $PATH:/usr/local/apache-maven/apache-maven-${MAVEN_FULL_VERSION}/bin

RUN adduser --user-group --uid 1000 --home /home/$LOGIN $LOGIN

COPY fish/ /home/$LOGIN/.config/fish/
COPY vim/ /home/$LOGIN/.vim/
COPY vim/vimrc /home/$LOGIN/.vimrc

RUN chown -R $LOGIN:$LOGIN /home/$LOGIN/

USER $LOGIN
WORKDIR $WORKDIR

CMD fish
