# Cookbook Name:: plex_docker
# Recipe:: default
# Recipe to create folders, map them using smbfs and starting docker plex

directory "#{node['plex_docker']['local_movies_folder']}" do
  owner 'root'
  group 'root'
  action :create
end

directory "#{node['plex_docker']['local_music_folder']}" do
  owner 'root'
  group 'root'
  action :create
end

smbfs_mount "#{node['plex_docker']['local_movies_folder']}" do
  cifs_path "#{node['plex_docker']['cifs_movies_folder']}"
  username "#{node['plex_docker']['username']}"
  password "#{node['plex_docker']['password']}"
end

smbfs_mount "#{node['plex_docker']['local_music_folder']}" do
 cifs_path "#{node['plex_docker']['cifs_music_folder']}"
 username "#{node['plex_docker']['username']}"
 password "#{node['plex_docker']['password']}"
end

docker_container "#{node['plex_docker']['container_name']}" do
  repo "#{node['plex_docker']['image_name']}"
  action :run
  network_mode 'host'
  env ['TZ=America/Toronto', "PLEX_CLAIM=#{node['plex_docker']['plex_claim']}"]
  volumes ["#{node['plex_docker']['transcode_host_docker_volume']}:/transcode",
           "#{node['plex_docker']['config_host_docker_volume']}:/config",
           "#{node['plex_docker']['local_movies_folder']}:/data/movies",
           "#{node['plex_docker']['local_music_folder']}:/data/music"]
end
