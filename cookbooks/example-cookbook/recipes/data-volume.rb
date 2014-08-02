#
# Cookbook Name:: example-cookbook
# Recipe:: data-volume
#

include_recipe 'docker'

cookbook_file 'Dockerfile' do
  path '/tmp/Dockerfile'
  source 'data-volume/Dockerfile'
end

# nginx configuration files
directory('/tmp/nginx') { action :create }

cookbook_file 'nginx/run.sh' do
  path '/tmp/nginx/run.sh'
  source 'nginx/run.sh'
end

cookbook_file 'nginx/nginx.conf' do
  path '/tmp/nginx/nginx.conf'
  source 'nginx/nginx.conf'
end

# Postgres configuration files
directory('/tmp/postgres') { action :create }
cookbook_file 'postgres/run.sh' do
  path '/tmp/postgres/run.sh'
  source 'postgres/run.sh'
end

cookbook_file 'postgres/postgresql.conf' do
  path '/tmp/postgres/postgresql.conf'
  source 'postgres/postgresql.conf'
end

cookbook_file 'postgres/pg_hba.conf' do
  path '/tmp/postgres/pg_hba.conf'
  source 'postgres/pg_hba.conf'
end

# rails application configuration files
directory('/tmp/rails-example') { action :create }

cookbook_file 'rails-example/run.sh' do
  path '/tmp/rails-example/run.sh'
  source 'rails-example/run.sh'
end


docker_image 'ubuntu' do
  tag 'data-volume'
  source '/tmp'
  action :build_if_missing
end

docker_container 'data-volume' do
  image 'ubuntu:data-volume'
  container_name 'data-volume'
  detach true
  action :run
end