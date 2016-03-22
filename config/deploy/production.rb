puts "PRODUCTION DEPLOY!"

set :stage, :production

set :deploy_via, :remote_cache

set :rails_env, :production

set :deploy_to, "#{fetch(:base)}/apps/#{fetch(:application)}/production"
set :ruby_version, 'ruby-2.2.2'
set :custom_bundle_dir, "#{fetch(:deploy_to)}/shared/bundle"
set :default_env,
    {
        LANG: 'en_US.UTF-8',
        PATH: "#{fetch(:base)}/support/#{fetch(:ruby_version)}/bin:#{fetch(:base)}/support/postgresql-9.2.4/bin:#{fetch(:custom_bundle_dir)}/ruby/2.2.0/bin:$PATH",
        GEM_HOME: "#{fetch(:custom_bundle_dir)}/ruby/2.2.0",
        GEM_PATH: "#{fetch(:custom_bundle_dir)}/ruby/2.2.0/gems",

    }

set :conditionally_migrate, true