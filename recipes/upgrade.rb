# Cookbook Name:: plex_docker
# Recipe::upgrade plex image
# Recipe to upgrade docker image/container

docker_container 'plex' do
  kill_after 30
  action [:stop, :delete]
end

docker_image 'timhaak/plex' do
  action :pull
end
