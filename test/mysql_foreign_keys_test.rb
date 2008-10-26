require File.dirname(__FILE__) + '/../lib/mysql_foreign_keys.rb'
require 'test/unit'
require 'rubygems'
require 'active_support/core_ext/string/inflections.rb'

#
# Override exec method so we can inspect the generated string
#
module MysqlForeignKeys
  # Simply return string
  def exec_fk(stmt)
    stmt
  end
end

class String
  include ActiveSupport::CoreExtensions::String::Inflections
end

class MysqlForeignKeysTest < Test::Unit::TestCase
  include MysqlForeignKeys

  def test_add_simple_foreign_key
    assert_equal 'alter table tests add constraint fk_tests_unit_id foreign key (unit_id) references units(id)',
                 add_foreign_key(:tests, :units)
  end

  def test_add_foreign_key_custom_column
    assert_equal 'alter table tests add constraint fk_tests_number foreign key (number) references units(number)',
                 add_foreign_key(:tests, :units, :number)
  end

  def test_remove_foreign_key
    assert_equal 'alter table tests drop foreign key fk_tests_units',
                 remove_foreign_key(:tests, :units)
  end
end
