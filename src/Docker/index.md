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

# 修改国内镜像地址

```shell
# Docker 官方中国区	https://registry.docker-cn.com
# 网易	http://hub-mirror.c.163.com
# 中国科学技术大学	https://docker.mirrors.ustc.edu.cn
# 阿里云	https://<你的ID>.mirror.aliyuncs.com


sudo vim /etc/docker/daemon.json # 打开并修改内容或者新建
EOF>>
{
  "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
EOF<<
sudo systemctl daemon-reload # 重载配置
sudo service docker restart # 重启docker
docker search postgresql # 测试是否成功
```

