#
# Adds methods for adding foreign keys to MySQL tables.
#
# Christian Johansen (christian@ixd.no)
# 2008-06-14
#
module MysqlForeignKeys

  #
  # Add a foreign key restraint for MySQL tables.
  #
  # Normally it is not needed to provide the from_column parameter. The column
  # name will be guess from a singularized version with the string _id appended.
  #
  # In the following example the column name is assumed to be address_id
  #
  #   add_foreign_key :websites, :addresses
  #
  # The field in the receiving table is assumed to be the part of the
  # from_column after the last _. In the example above this amounts
  # to id. Another example:
  #
  #   add_foreign_key :websites, :addresses, :location_type
  #
  # Allthough contrived, this will result in:
  #
  #   alter table websites add constraint [NAME] foreign_key location_type references addresses(type)
  #
  def add_foreign_key(from_table, to_table, from_column = nil)
    from_column ||= "#{to_table.to_s.singularize}_id"
    to_column = from_column.to_s.split('_').last
    constraint_name = "fk_#{from_table}_#{from_column}"

    exec_fk "alter table #{from_table} add constraint #{constraint_name} " +
      "foreign key (#{from_column}) references #{to_table}(#{to_column})"
  end

  #
  # Remove a foreign key restraint
  #
  def remove_foreign_key(from_table, from_column)
    constraint_name = "fk_#{from_table}_#{from_column}"

    exec_fk "alter table #{from_table} drop foreign key #{constraint_name}"
  end

  #
  # Executes sql statements. May be overriden when tested to check that
  # statements are correctly created
  #
  def exec_fk(stmt)
    execute stmt
  end
end
