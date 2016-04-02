namespace :db do
  task smash: %w(redis:flush db:schema:load db:test:prepare db:seed)

  namespace :download do
    def db_dump_file
      "coderwall-production.dump"
    end

    # https://www.mongolab.com/downloadbackup/543ea81670096301db49ddd2

    desc 'Create a production database backup'
    task :generate do
      Bundler.with_clean_env do
        cmd = "heroku pg:backups capture DATABASE_URL --app coderwall-production"
        sh(cmd)
      end
    end

    desc 'Download latest database backup'
    task :latest do
      unless File.exists?(db_dump_file)
        Bundler.with_clean_env do
          sh("curl `heroku pg:backups public-url --app coderwall-production` -o #{db_dump_file}")
        end
      end
    end

    desc 'Load local database backup into dev'
    task load: :environment do
      raise 'local dump not found' unless File.exists?(db_dump_file)

      puts 'Cleaning out local database tables'
      ActiveRecord::Base.connection.tables.each do |table|
        puts "Dropping #{table}"
        ActiveRecord::Base.connection.execute("DROP TABLE #{table};")
      end

      puts 'Loading Production database locally'
      `pg_restore --verbose --clean --no-acl --no-owner -h localhost -d coderwall_development #{db_dump_file}`
    end

    task :clean do
      `rm #{db_dump_file}`
    end
  end

  task restore: %w(db:download:generate db:download:latest db:download:load vagrant:db:restart db:download:clean db:migrate)
  task reload:  %w(db:download:latest db:download:load vagrant:db:restart db:migrate)

  desc 'ActiveRecord can you shut up for 30 minutes?'
  task mute: :environment do
    ActiveRecord::Base.logger = nil
  end
end
