# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "ad-scraper"
set :repo_url, "git@github.com:maromaro0013/ad-scraper.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV['BRANCH'] || "master"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  task :restart do
    on roles(:web) do
      execute "ruby /var/www/ad-scraper/current/get_secrets_from_aws.rb > /var/www/ad-scraper/current/.env"
      sudo :systemctl, "restart ad-scraper"
    end
  end

  task :create_db do
    on roles(:web) do
      within release_path do
        with rails_env: "production" do
          execute :rake, 'db:create'
        end
      end
    end
  end

  task :migrate_db do
    on roles(:web) do
      within release_path do
        with rails_env: "production" do
          execute :rake, 'db:migrate'
        end
      end
    end
  end

  task :restart_nginx do
    on roles(:web) do
      sudo :systemctl, "restart nginx"
    end
  end

  task :restart_sidekiq do
  on roles(:web) do
    sudo :systemctl, "restart sidekiq"
  end
  end

  task :restart_sidekiq_and_clear do
    on roles(:web) do
      within release_path do
        sudo :systemctl, "stop sidekiq"
        execute :rake, 'ad-scraper:clear_running_jobs'
        sudo :systemctl, "start sidekiq"
      end
    end
  end
end
