namespace :db do
  task :environment do
    require 'rubygems'
    require 'logger'
    require 'active_record'
    ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => 'db/development.sqlite3.db'
  end

  desc "Migrate the database"
  task(:migrate => :environment) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
