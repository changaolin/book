# [Docker 安装（Ubuntu）](https://yeasy.gitbook.io/docker_practice/install/ubuntu)

```shell
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
```

# 启动Docker

```shell
sudo systemctl enable docker
sudo systemctl start docker
```

# 建立 docker用户组

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker # 刷新立即生效
# id 查看当前用户的信息
```

