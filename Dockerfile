FROM python:3.10.6-buster
ARG GID=992
ARG UID=992
RUN groupadd -o -g $GID docker
RUN useradd -o -m -u $UID -g $GID -s /bin/bash docker
RUN mkdir -p /app

WORKDIR /app
#COPY --chown=docker:dockre src /app
# Copy our program in, owned by the docker user
COPY --chown=docker:docker project21/src/app.py /app


ENV PYTHONPATH=$PYTHONPATH:/app
ENV APP_BASE=/app/

RUN apt-get update -y && apt-get install -y libpcre3 && apt-get install libpcre3-dev -y && apt-get install socat -y && apt-get clean -y

ADD /project21/requirements.txt .
RUN pip3 --disable-pip-version-check install -r requirements.txt



CMD ["python3", "src/app.py"]
