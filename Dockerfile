FROM ubuntu

SHELL ["bash", "-c"]
# terraform
RUN apt-get update && apt-get install -y git curl unzip
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile && \
    ln -s ~/.tfenv/bin/* /usr/local/bin
RUN tfenv install latest

# ruby
RUN \curl -L https://get.rvm.io | bash -s stable
RUN source /etc/profile.d/rvm.sh && rvm install 2.4.0
RUN source /etc/profile.d/rvm.sh && gem install bundler

# kitchen-terraform
COPY Gemfile .
RUN source /etc/profile.d/rvm.sh && bundle install

ENTRYPOINT ["/bin/bash", "-l", "-c"]