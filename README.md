# dev-java
Docker development environment for Java

# Install
    cd whereverYouWant/
    git clone https://github.com/vbremond/dev-java.git .
    git submodule init
    git submodule update
    docker build -t dev/java .
    docker run -it --rm --name dev.java -v /path/to/my/java/code/:/code/ dev/java

# What is this?

This is a Java development environment based on Docker.
If you want to develop Java applications but you don't want to mess around with your machine, you simply have to docker run this environment and you're good to go.

# What is included?

- Java 1.8.0 (OpenJDK)
- Gradle 2.7
- git
- vim (with Pathogen and Syntastic)
- the wonderful Fish shell (you'd better have a look at [the documentation](http://fishshell.com/docs/current/) if you have no idea what I'm talking about, but trust me, it's worth the try!)
- all based on the official CentOS image

