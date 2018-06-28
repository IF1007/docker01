# Docker para a [API em laravel](https://github.com/jbsn94/laravel-horarioaulas.git)

Neste repositório constam todos os arquivos necessários para iniciar a aplicação e seu ambiente necessário para rodar.

### Criado por:

* José Babrosa da Silva Neto ([jbsn@cin.ufpe.br](mailto:jbsn@cin.ufpe.br))

### Requisitos:
* [Docker](https://docs.docker.com/install/)
* [Docker-compose](https://docs.docker.com/compose/install/#install-compose)
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Mapa do repositório
- **nginx** - Pasta contendo arquivos de configuração do nginx
    - **default** - arquivo com as configurações necessárias para o nginx da aplicação
- **proxy** - Pasta para a criação da imagem do *load balancing/proxy* para a aplicação.
    - **Dockerfile** - Arquivo para criação da imagem do proxy.
    - **nginx.conf** - Arquivo com as configurações necessárias para o proxy.
- **.env** - Arquivo contendo todas as variaveis necessárias para a aplicação.
- **docker-compose** - Arquivo yml que contém todas as configurações para setup da aplicação e seu ambiente.
- **Dockerfile** - Arquivo responsável por gerar a imagem da aplicação em laravel utilizado no projeto

### Iniciando a aplicação

1 - Clonando o repositório e mudando o workspace para ele
```shell
git clone https://github.com/jbsn94/docker01.git docker
cd docker
```
2 - Iniciando a aplicação e seu ambiente com o docker-compose
```shell
sudo docker-compose -d --scale app=5
```
3 - Executando as migration dentro de um container para criar as tabelas necessárias no banco caso já não tenham sido criadas
```shell
sudo docker exec -it docker_app_1 php artisan migrate
```
4 - (Opcional) populando o banco com dados
```shell
sudo docker exec -it docker_app_1 php artisan db:seed
```
**OBS:** Será necessário criar exatamente 5 réplicas da aplicação pelo fato do proxy estar esperando exatamente 5 replicas, caso queira alterar o número de réplicas basta ir no arquivo **proxy/nginx.conf** e no *upstream app_servers* ajustar a quantidade de servidores e seus números para a quatidade de réplicas que irá utilizar.

**OBS2:** Não criei imagens no Dockerhub para utilizar apenas imagens local com isso tanto a imagem do proxy quanto a imagem da aplicação serão geradas localmente assim que iniciar o ambiente e a aplicação através do *docker-compose*.

### Fontes
- Docker: https://docs.docker.com
- Docker-compose: https://docs.docker.com/compose/
- Nginx: https://hub.docker.com/_/nginx/
- Mysql: https://hub.docker.com/_/mysql/
- PHP: https://hub.docker.com/_/php/
- Redis: https://hub.docker.com/_/redis/
- Nginx as a Load balancing/proxy: http://nginx.org/en/docs/http/load_balancing.html