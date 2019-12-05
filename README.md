# environment

Environment



### requirements

------



ai_environment is requires  `docker` and `docker-compose`

If you haven't install  `docker` and `docker-compose`  you must install



### How to Use

---



#### Step1.

Build docker

```shell
make compose-build
```



#### Step2.

Set Up Trains

```shell
make trains-init
```



#### Step 3.

```

```





#### Step1.

Build  docker.

```shell
docker-compose build
```

#### Step2.

Run docker environment.

```shell
docker-compose up -d
```

#### Step3.

After run command, you can access this

`http://localhost:8888/lab` or `127.0.0.1:8888/lab`



if you want upload local file to Jupiter notebook

put it home directory. jupyter can read it.

`enviroment/home/<put it here>`

```shell
├── README.md
├── data
│   └── common_db
│       └── conf.d
├── dictfiles
├── docker
│   ├── Dockerfile-jupyter
│   └── Dockerfile-mysql
├── docker-compose.yml
├── home #put it here
│ 
└── requirements.txt
```

