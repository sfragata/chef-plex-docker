# Cookbook Name:: plex_docker
# Recipe::upgrade plex image
# Recipe to upgrade docker image/container

docker_container "#{node['plex_docker']['container_name']}" do
  kill_after 30
  action [:stop, :delete]
end

docker_image "#{node['plex_docker']['image_name']}" do
  action :pull
end
