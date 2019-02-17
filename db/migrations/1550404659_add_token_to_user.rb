Sequel.migration do
  up do
    alter_table(:users) do
      add_column :token, String
      add_index :token, unique: true
    end

    DATABASE_CONNECTION_CONTAINER.resolve(:connection)[:users]
      .update(token: Sequel.lit('MD5(email)'))

    alter_table(:users) do
      set_column_not_null :token
    end
  end

  down do
    alter_table(:users) do
      drop_column :token
    end
  end
end
