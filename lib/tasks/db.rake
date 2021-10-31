require 'fileutils'
require 'colorize'

namespace :db do
  desc 'Setup db with a clean seed'
  task clean_seed: :environment do
    Rake::Task['db:mongoid:purge'].invoke
    Rake::Task['db:seed'].invoke
  end
end
