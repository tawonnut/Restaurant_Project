# config valid only for current version of Capistrano
set :application, 'restuarant_terebinth'
set :repo_url, 'git@bitbucket.org:swiftlet/terebinth-pos.git'

# Default branch is :master


# Default deploy_to directory is /var/www/my_app_name


# Default value for :scm is :git


# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'tmp:cache:clear'
        execute :rake, 'db:setup'
      end
    end
   set :stage, :production
   # execute :rake, 'db:mongoid:create_indexes'
  end

end
