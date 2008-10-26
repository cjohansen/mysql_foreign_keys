require 'mysql_foreign_keys.rb'

#
# Extends ActiveRecord::Migration with foreign key functionality
#
class ActiveRecord::Migration
  extend MysqlForeignKeys
end
