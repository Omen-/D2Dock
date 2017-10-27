FROM ubuntu:trusty

RUN apt-get update -y
RUN apt-get install -y wget

#VNC
RUN apt-get install -y x11vnc xvfb
RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd

#AIR
RUN mkdir /opt/air
WORKDIR /opt/air
RUN wget --no-check-certificate --progress=bar:force "http://airdownload.adobe.com/air/lin/download/latest/AdobeAIRSDK.tbz2" -O air.tar.gz
RUN tar -xjvf air.tar.gz
RUN rm air.tar.gz

#DOFUS
RUN mkdir /opt/dofus
WORKDIR /opt/dofus
RUN wget --no-check-certificate --progress=bar:force "http://download.dofus.com/zip/linux/" -O dofus.zip
RUN tar -zxvf dofus.zip
RUN rm dofus.zip
RUN chmod +x ./bin/Dofus

RUN dpkg --add-architecture i386 && \
  sudo apt-get update && \
  apt-get install -y -q \
  build-essential \
  psmisc \
  libc6-i386

RUN apt-get install -y -q libgtk2.0-0:i386 
RUN apt-get install -y -q lib32stdc++6
RUN apt-get install -y -q libxml2:i386
RUN apt-get install -y -q libnss3:i386
RUN locale-gen fr_FR
RUN locale-gen fr_FR.UTF-8
RUN locale-gen en_US
RUN locale-gen en_US.UTF-8
RUN update-locale

RUN apt-get install -y fluxbox

#INIT DOFUS CACHE
RUN  /bin/bash -c "Xvfb :99 -screen 0 480x360x16 &" && /bin/bash -c "export DISPLAY=:99; /opt/air/bin/adl -nodebug /opt/dofus/share/META-INF/AIR/application.xml /opt/dofus/share/ &" && sleep 10 && pkill adl

#REMOVE UNIQUE IDENTIFIER
RUN rm /root/.appdata/dofus/uid.dat

ENV DISPLAY=:1
CMD /bin/bash -c "Xvfb :1 -screen 0 480x360x16 &" && /bin/bash -c "fluxbox &" && /bin/bash -c "x11vnc -display :1 -usepw -forever &" && /bin/bash -c "/opt/air/bin/adl /opt/dofus/share/META-INF/AIR/application.xml /opt/dofus/share/" && /bin/bash -c "pkill Xvfb" && /bin/bash -c "pkill fluxbox" && /bin/bash -c "pkill x11vnc"
ENV home=/root

#VNC
EXPOSE 5900

