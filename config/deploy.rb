require 'bundler/capistrano'
require "rvm/capistrano"

ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false
default_run_options[:pty] = true  # Must be set for the password prompt from git to work

# deploy.rb
set :application, "Las7encinas"

task :prod do
  set :type_server, "prod"
  set :servername, "5.135.166.174"
  set :home, "/home/deploy/lasencinas/"
  server servername, :web, :app, :db
  role :app, servername
  role :web, servername
  role :db,  servername, :primary => true
  set :deploy_to, home
  set :runner, 'deploy'
  set :user, "deploy"
  set :branch, "master"
  set :keep_releases, 4
  set :rails_env, 'production'
end

set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3-p392'

set :deploy_via, :remote_cache
set :use_sudo, false

set :migrate_env, ''

set :scm, "git"
set :scm_user, "deploy"  # The server's user for deploys
set :repository, "git@github.com:zitooon/Alamillo.git"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  desc "Tell Passenger to restart the app."
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets/pictures #{release_path}/public/images/pictures"
  end
end

namespace :assets do
  desc "Get the public/assets directory."
  task :pull do
    system "rsync -e ssh -avuzp  #{user}@#{servername}:#{shared_path}/assets/pictures public/images/"
  end

  task :push do    
    system "rsync -e ssh -avzp --delete-after --exclude-from=.rsyncignore public/images/pictures #{user}@#{servername}:#{shared_path}/assets/"
  end
end

# HOOKS
after "deploy:update_code" do
  deploy.symlink_shared
end

# Automatically clean versions by keeping the 5 last versions
after "deploy", "deploy:cleanup"