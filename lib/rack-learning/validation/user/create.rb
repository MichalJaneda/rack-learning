ValidationUserCreate = Dry::Validation.Schema do
  required(:email).filled(format?: Value::Validation::User, max_size?: 256)
  required(:name).filled(max_size?: 256)
end
