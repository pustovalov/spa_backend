
# set :local_user, 'deployer'
set :application, 'spa_backend'
set :repo_url, 'https://github.com/pustovalov/spa_backend.git'
set :branch, 'ansible'
set :deploy_to, '/home/ubuntu/applications/spa_backend'

# set :stages, %w(staging production)
# set :default_stage, "production"

set :log_level, :info
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

set :puma_init_active_record, true

require 'net/ssh/proxy/command'

# namespace :deploy do
#   desc "Uploads keys"
#   task :upload do
#     on roles(:all) do
#       upload! "config/application.yml", "#{release_path}/config/application.yml"
#     end
#   end
#   after :publishing, :upload
# end

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    on roles(:app) do
      upload! "config/application.yml", "#{shared_path}/application.yml", via: :scp
    end
  end

  desc "Symlink application.yml to the release path"
  task :symlink do
    on roles(:app) do
      execute "ln -sf #{shared_path}/application.yml #{current_path}/config/application.yml"
    end
  end
end
after "deploy:started", "figaro:setup"
after "deploy:symlink:release", "figaro:symlink"


# desc "Run rake tasks on server"
# task :rake do
#   on roles(:app), in: :sequence, wait: 5 do
#     within release_path do
#       with rails_env: :production do
#         execute :rake, ENV["task"], "RAILS_ENV=production"
#       end
#     end
#   end
# end
