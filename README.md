# Docker Satis

A docker image and configuration to run Satis very easily in seconds:

* Automatically (cron every minute)
* Manually (http://127.0.0.1:3033/build)

**DO NOT forget to create a `config.json` file compatible with satis in your directory before starting the docker container.**

## Run the container

In this command do not forget to replace:

* toto.tata.tutu.com with your private repository URL in `-e PRIVATE_REPO_DOMAIN=toto.tata.tutu.com`

```
docker run -it -p 3033:3000 -v $(pwd):/app -v "${HOME}/.ssh/id_rsa":/var/tmp/id -v /var/tmp/composer:/root/.composer -e PRIVATE_REPO_DOMAIN=toto.tata.tutu.com -d ypereirareis/docker-satis
```

**SSH key**

The container needs to know the ssh key you aded in your private repo.

`-v "${HOME}/.ssh/id_rsa":/var/tmp/id`

The ssh fingerprint of the private repo server needs to be added in the known_hosts file inside the container that's why we specify the URL through ENV variable.

`-e PRIVATE_REPO_DOMAIN=toto.tata.tutu.com`

**Composer cache**

Cache must be shared with the host to be reused when you restart the container.

`-v /var/tmp/composer:/root/.composer`


## Satis Home page

[http://127.0.0.1:3033](http://127.0.0.1:3033) (but you can map another port)

## Satis manual build

[http://127.0.0.1:3033/build](http://127.0.0.1:3033/build)
