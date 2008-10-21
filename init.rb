require 'migration_helpers.rb'

#
# Extends ActiveRecord::Migration with foreign key functionality
#
class ActiveRecord::Migration
  extend MigrationHelpers
end
