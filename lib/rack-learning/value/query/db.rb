module Value
  module Query
    class DB
      ADAPTER = ENV['DATABASE_ADAPTER']
      HOST = ENV['DATABASE_HOST']
      NAME = ENV['DATABASE_NAME']
      USER = ENV['DATABASE_USER']
      PASSWORD = ENV['DATABASE_PASSWORD']
    end
  end
end
