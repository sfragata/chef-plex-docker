# plex_docker

Chef recipe to install and configure plex media center into a
docker container using network folders

## Before start

### Install cifs-utils
```
sudo apt-get install cifs-utils
```

### Install docker

* Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/
* Mac: https://docs.docker.com/docker-for-mac/install/

## Attributes

The default.rb recipe is generic, so you need to add your configuration
into `attributes/default.rb`

### attributes/default.rb file

#### network username and password
```
default['plex_docker']['username'] = 'USERNAME_HERE'
default['plex_docker']['password'] = 'PASSWORD_HERE'
```
#### local folder to map network folder
```
default['plex_docker']['local_movies_folder'] = 'YOUR_LOCAL_MOVIE_PATH'
default['plex_docker']['local_music_folder'] = 'YOUR_LOCAL_MUSIC_PATH'
```
#### remote folder (Ex. `//127.0.0.1/Public/Videos`)
```
default['plex_docker']['cifs_movies_folder'] = 'YOUR_REMOTE_MOVIE_PATH'
default['plex_docker']['cifs_music_folder'] = 'YOUR_REMOTE_MUSIC_PATH'
```
#### path to store plex config into host's machine
```
default['plex_docker']['config_host_docker_volume'] = 'PATH_TO_STORE_PLEX_CONFIG'
```
#### path to store plex transcode into host's machine
```
default['plex_docker']['transcode_host_docker_volume'] = 'PATH_TO_STORE_PLEX_TRANSCODE'
```
#### image name: [plexinc/pms-docker](https://github.com/plexinc/pms-docker/blob/master/README.md)
```
default['plex_docker']['image_name'] = 'plexinc/pms-docker'
```
#### container name
default['plex_docker']['container_name'] = 'CONTAINER_NAME'

#### plex claim token
The claim token for the server to obtain a real server token. If not provided, server will not be automatically logged in. If server is already logged in, this parameter is ignored. You can obtain a claim token to login your server to your plex account by visiting https://www.plex.tv/claim
```
default['plex_docker']['plex_claim'] = 'CLAIM_TOKEN'
```

## Mapping network folders and start docker container
```
sudo chef-client -z -r "recipe[plex_docker]"
```

## Upgrade docker images/container and start it
```
sudo chef-client -z -r "recipe[plex_docker::upgrade],recipe[plex_docker::default]"
```
