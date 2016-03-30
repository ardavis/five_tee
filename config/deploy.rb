set :user, 'git'
set :location, 'spsapp001'

set :keep_releases, 10

set :base, '/var/www/webapps'
set :application, 'five_tee'
set :repo_url, "#{fetch(:user)}@#{fetch(:location)}:#{fetch(:base)}/apps/#{fetch(:application)}/#{fetch(:application)}.git"
set :use_sudo, false
#set :scm_verbose, true

# Capture timestamp
set :timestamp, "#{Time.now.strftime('%Y%m%d-%H%M')}"

set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')


set :pty, true
server fetch(:location),
       roles: [:app, :web, :db],
       user: fetch(:user),
       primary: true

# Backup task used to backup postgres database prior to deployment
desc 'Backup postgresql prior to deployment'
task :backup_postgresql do
  `pg_dump --host spsapp001 --port 5500 --username git --format tar --blobs --file #{fetch(:base)}/pg_backups/#{fetch(:application)}_#{fetch(:stage)}_pre_deploy_#{fetch(:timestamp)} #{fetch(:application)}_#{fetch(:stage)}`
end

namespace :deploy do
  task :restart do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :touch, 'tmp/restart.txt'
      end
    end
  end
end

before 'deploy', 'backup_postgresql' # Run database backup before deployment
after 'deploy:publishing', 'deploy:restart'
