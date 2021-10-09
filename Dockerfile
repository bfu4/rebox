FROM amd64/ubuntu:latest
RUN apt update
RUN apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install vim openjdk-8-jdk ant neofetch wget make clang g++ \
	lldb git curl radare2 mercurial -y
RUN wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.17.2.linux-amd64.tar.gz
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go
RUN rm go1.17.2.linux-amd64.tar.gz
RUN git clone https://git.tcp.direct/bfu/asmtools
RUN cd asmtools/build && ant 
RUN mkdir /usr/local/share/asmtools/ 
RUN cp ../../asmtools-7.0-build/release/lib/asmtools.jar /usr/local/share/asmtools/asmtools.jar
RUN cd ../.. && rm -rf asmtools*
RUN printf '#!/bin/bash\njava -jar /usr/local/share/asmtools/asmtools.jar $@' >> /usr/local/bin/asmtools
RUN chmod +x /usr/local/bin/asmtools
RUN apt install openjdk-11-jdk -y
RUN wget https://github.com/goretk/redress/releases/download/v0.7.10/redress-v0.7.10-linux-amd64.tar.gz;
RUN tar -xvf redress-v0.7.10-linux-amd64.tar.gz && cp redress-v0.7.10/redress /usr/local/bin/redress
RUN rm -rf redress*
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
