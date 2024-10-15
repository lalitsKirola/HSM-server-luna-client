FROM ubuntu:latest

# Install OpenJDK 8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Create directory for Luna client
RUN mkdir -p /usr/local/luna

# Copy Luna client files to the appropriate location
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64 /usr/local/luna

# Copy the Luna client configuration files
COPY /luna-docker/config /usr/local/luna/

# Set environment variable for Luna configuration path
ENV ChrystokiConfigurationPath=/usr/local/luna/

# Copy Luna binaries
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64/bin/64/lunacm /usr/local/bin/
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64/bin/64/vtl /usr/local/bin/
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64/bin/64/cmu /usr/local/bin/
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64/bin/64/ckdemo /usr/local/bin/

# Update the PATH environment variable to include Luna binaries
ENV PATH=/usr/local/luna/bin/64:${PATH}

# Create directory for the HSM interface app and copy the jar and the Luna library
RUN mkdir -p /usr/local/hsminterfaceapp
COPY /luna-docker/LunaClient-Minimal-10.7.1-125.x86_64/jsp/64/libLunaAPI.so /usr/local/hsminterfaceapp/
COPY target/*.jar /usr/local/hsminterfaceapp/hsminterfaceapp.jar

# Set the working directory
WORKDIR /usr/local/hsminterfaceapp

# Command to run the application
CMD ["java", "-Djava.library.path=/usr/local/hsminterfaceapp", "-jar", "hsminterfaceapp.jar"]
