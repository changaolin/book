# 获取镜像

```shell
docker pull postgres
```

# 启动容器

```shell
docker run --name postgres-db -e POSTGRES_PASSWORD=root -p 15432:5432 -d postgres
```

# 启动容器 -详细

```shell
docker run --name postgres-db -e TZ=PRC -e POSTGRES_USER=root -e POSTGRES_DB=database -e POSTGRES_PASSWORD=Root123 -p 5432:5432 -v pgdata:/var/lib/postgresql/data -d postgres

--name 容器名称postgres-db
-e TZ=PRC时区，中国
-e POSTGRES_USER=root 用户名是root（不设置默认用户名postgres）
-e POSTGRES_DB=database DB模式数据库模式
-e POSTGRES_PASSWORD 密码
-p 5432:5432端口映射，把容器的5432端口映射到服务器的5432端口
-v 将数据存到宿主服务器
-d 后台运行
(时区问题:如果在启动容器时不设置时区，默认为UTC，使用now()设置默认值的时候将有时间差。)
```

