Sequel.migration do
  change do
    alter_table(:posts) do
      add_column :created_at, 'timestamp', default: 'NOW()'
    end
  end
end
