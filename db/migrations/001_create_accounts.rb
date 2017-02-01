Sequel.migration do
  change do
    create_table :accounts do
      primary_key :id
      column :eth_address, :varchar, :unique=>true
      column :balance, :integer
    end
  end
end