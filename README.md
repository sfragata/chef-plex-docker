# plex_docker

Chef recipe to install and configure plex media center into a
docker container

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
#### remove folder (Ex. `//127.0.0.1/Public/Videos`)
```
default['plex_docker']['cifs_movies_folder'] = 'YOUR_REMOTE_MOVIE_PATH'
default['plex_docker']['cifs_music_folder'] = 'YOUR_REMOTE_MUSIC_PATH'
```
#### path to store plex config into host's machine
```
default['plex_docker']['config_host_docker_volume'] = 'PATH_TO_STORE_PLEX_CONFIG'
```

## Mapping network folders and start docker container
```
sudo chef-client -z -r "recipe[plex_docker]"
```

## Upgrade docker images/container and start it
```
sudo chef-client -z -r "recipe[plex_docker::upgrade],recipe[plex_docker::default]"
```
