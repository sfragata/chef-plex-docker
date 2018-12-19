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

docker_container 'plex' do
  repo 'timhaak/plex'
  action :run
  port '32400:32400'
  network_mode 'host'
  volumes ["/etc/localtime:/etc/localtime",
           "#{node['plex_docker']['config_host_docker_volume']}:/config",
           "#{node['plex_docker']['local_movies_folder']}:/data/movies",
           "#{node['plex_docker']['local_music_folder']}:/data/music"]
end
