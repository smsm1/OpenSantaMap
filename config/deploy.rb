set :application, "opensantamap.org"
set :repository,  "git@github.com:smsm1/OpenSantaMap.git"
set :deploy_to, "/srv/opensantamap.org/rails_source"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "admin"

role :web, "opensantamap.org"                          # Your HTTP server, Apache/etc
role :app, "opensantamap.org"                          # This may be the same as your `Web` server
role :db,  "opensantamap.org", :primary => true # This is where Rails migrations will run


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start {}
  task :stop {}
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db do
  desc "Symlink the database config file"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
after "deploy:finalize_update", "db:symlink"

namespace :delayed_job do
  desc "Start delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; script/delayed_job start #{rails_env}"
  end

  desc "Stop delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; script/delayed_job stop #{rails_env}"
  end

  desc "Restart delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; script/delayed_job restart #{rails_env}"
  end
end

after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:restart"
