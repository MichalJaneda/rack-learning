DATABASE_CONNECTION_CONTAINER = Dry::Container.new
DATABASE_CONNECTION_CONTAINER.register(:connection, Sequel.connect(adapter: Value::Query::DB::ADAPTER,
                                                                   host: Value::Query::DB::HOST,
                                                                   database: Value::Query::DB::NAME,
                                                                   user: Value::Query::DB::USER,
                                                                   password: Value::Query::DB::PASSWORD,
                                                                   logger: Logger.new($stderr)))
