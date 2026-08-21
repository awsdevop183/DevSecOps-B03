FROM ubuntu:22.04

LABEL "email": "info@madhukarreddy.com"
LABEL "Owner": "Madhukar"

ENV AWS_ACCESS_KEY_ID="sdhssd"
ENV AWS_SECRET_ACCESS_KEY="sdsa"
ENV AWS_DEFAULT_REGION="us-east-1"

ARG TF_VERSION="1.14.0"
EXPOSE 80
RUN apt update && \
    apt install -y nginx net-tools iputils-ping unzip jq wget

RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_freebsd_386.zip

CMD ["nginx", "-g", "daemon off;"]

# ENTRYPOINT ["ping"]

# CMD ["-c 5", "google.com"]
# CMD ["ping","-c 10","google.com"]

