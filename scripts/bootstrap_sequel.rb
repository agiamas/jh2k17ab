### DEPRECATED

require "rubygems"
require "sequel"

# connect to a file based database
DB = Sequel.sqlite("db/sqlite3.db")


# create an accounts table
DB.create_table :accounts do
  primary_key :id
  String  :eth_address
  Integer :balance
end