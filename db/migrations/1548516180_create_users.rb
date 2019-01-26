Sequel.migration do
  change do
    create_table(:users) do
      String :name, null: false, size: 256, index: true
      String :email, null: false, size: 256, primary_key: true
    end
  end
end
