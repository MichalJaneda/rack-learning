Sequel.migration do
  change do
    create_table(:posts) do
      String :title, null: false, size: 256, primary_key: true
      Integer :views, null: false, default: 0
      foreign_key :author, :users, type: 'VARCHAR(256)', on_update: :cascade

      String :body, null: false, text: true
    end
  end
end
