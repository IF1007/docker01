# Docker para a [API em laravel](https://github.com/jbsn94/laravel-horarioaulas.git)

Neste repositório constam todos os arquivos necessários para iniciar a aplicação e seu ambiente necessário para rodar.

### Criado por:

* José Babrosa da Silva Neto ([jbsn@cin.ufpe.br](mailto:jbsn@cin.ufpe.br))

### Requisitos:
* [Docker](https://docs.docker.com/install/)
* [Docker-compose](https://docs.docker.com/compose/install/#install-compose)
* [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Mapa do repositório
- **app** - Pasta que contém todos os arquivos necessários para criação da imagem da [aplicação de horários](https://github.com/jbsn94/laravel-horarioaulas.git)
    - **.env** - Arquivos com as variáveis de ambiente para a aplicação
    - **default** - Configurações do nginx utilizado na aplicação
    - **Dockerfile** - Arquivo com as instruição para criação da imagem
- **auth** - Pasta com todos os arquivos necesários para criação da imagem da [aplicação de autenticação](https://github.com/jbsn94/apiauthescolas)
    - **.env** - Arquivos com as variáveis de ambiente para a aplicação
    - **default** - Configurações do nginx utilizado na aplicação
    - **Dockerfile** - Arquivo com as instruição para criação da imagem
- **proxy** - Pasta para a criação da imagem do *load balancing/proxy* para os containers
    - **Dockerfile** - Arquivo para criação da imagem do proxy.
    - **nginx.conf** - Arquivo com as configurações necessárias para o proxy.
- **docker-compose** - Arquivo yml que contém todas as configurações para setup da aplicação e seu ambiente.
### Iniciando a aplicação

1 - Clonando o repositório e mudando o workspace para ele
```shell
git clone https://github.com/jbsn94/docker01.git docker
cd docker
```
2 - Iniciando a aplicação e seu ambiente com o docker-compose
```shell
sudo docker-compose -d --scale app=2 --scale auth=2
```
3 - Executando as migration dentro de um container para criar as tabelas necessárias no banco caso já não tenham sido criadas
PS: Esses comandos só precisam ser executados 1x.
```shell
sudo docker exec -it docker_app_1 php artisan migrate
sudo docker exec -it docker_auth_1 php artisan migrate
```
4 - (Opcional) populando o banco com dados da aplicação de horários
```shell
sudo docker exec -it docker_app_1 php artisan db:seed
```

### ATENÇÃO
Como ambos os serviços estão sendo levantados em um mesmo *Docker hoster* será necessário adicionar dois **dns** em seu arquivo de hoster para o IP do *Docker hoster*, ambos os dns são: **local.com** e **api.local.com**, para ambos utilize o mesmo ip da maquina que está com o docker instalado, essa modificação é necessário para o *proxy* funcione corretamente e redirecione a requisição para o container adequado.

### Fontes
- Docker: https://docs.docker.com
- Docker-compose: https://docs.docker.com/compose/
- Nginx: https://hub.docker.com/_/nginx/
- Mysql: https://hub.docker.com/_/mysql/
- PHP: https://hub.docker.com/_/php/
- Redis: https://hub.docker.com/_/redis/
- Nginx as a Load balancing/proxy: http://nginx.org/en/docs/http/load_balancing.html

### Arquitetura
A imagem abixo mostra como o ambiente para aplicação está arquitetado.
![arquitetura](/arquitetura.png)
