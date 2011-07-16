ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false
default_run_options[:pty] = true  # Must be set for the password prompt from git to work

# deploy.rb
set :application, "Las7encinas"

task :prod do
  set :type_server, "prod"
  set :servername, "s1.timeisnotfree.com"
  set :home, "/home/las7encinas/www/"
  server servername, :web, :app, :db
  role :app, servername, :memcached => true
  role :web, servername
  role :db,  servername, :primary => true
  set :deploy_to, home
  set :runner, 'encinas'
  set :user, "encinas"
  set :branch, "master"
end

set :deploy_via, :remote_cache
set :use_sudo, false

set :migrate_env, ''

set :scm, "git"
set :scm_user, "zitooon"  # The server's user for deploys
set :scm_passphrase, "olivier124"  # The deploy user's password
set :repository, "git@github.com:zitooon/Las7encinas.git"

task :uname do
  server servame, :web, :app, :db
  run "uname -a"
end

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && /opt/ruby-enterprise/bin/bundle install --path  #{home}/#{shared_dir}/bundle --without test"
  end
end

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/environments/production.rb #{release_path}/config/environments/production.rb"
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

namespace :memcached do
  desc "Start memcached"
  task :start, :roles => [:app], :only => {:memcached => true} do
    sudo "/etc/init.d/memcached start"
  end
  desc "Stop memcached"
  task :stop, :roles => [:app], :only => {:memcached => true} do
    sudo "/etc/init.d/memcached stop"
  end
  desc "Restart memcached"
  task :restart, :roles => [:app], :only => {:memcached => true} do
    sudo  "/etc/init.d/memcached restart"
  end
  desc "Flush memcached"
  task :flush, :roles => [:app], :only => {:memcached => true}  do
    run "memflush --servers=localhost"
  end
end

# HOOKS
after "deploy:update_code" do
  deploy.symlink_shared
  bundler.bundle_new_release # if type_server == "preprod"
  #memcached.flush
end

# Automatically clean versions by keeping the 5 last versions
after "deploy", "deploy:cleanup"