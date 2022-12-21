FROM python:3.7.16-slim 

RUN mkdir /app
WORKDIR /app

COPY . /app/


ENV SSH_PASSWD "root:Docker!"

RUN apt update && \
        apt install -y --no-install-recommends dialog gcc default-libmysqlclient-dev openssh-server nano iputils-ping && \
        echo "${SSH_PASSWD}" | chpasswd

COPY sshd_config /etc/ssh/
#COPY init.sh /usr/local/bin/

RUN pip install setuptools==45 --no-cache-dir && pip install -r requirements.txt --no-cache-dir

#RUN chmod u+x /usr/local/bin/init.sh
EXPOSE 8000 2222

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
