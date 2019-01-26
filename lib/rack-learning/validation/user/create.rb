ValidationUserCreate = Dry::Validation.Schema do
  required(:email).filled(format?: Value::Validation::User::EMAIL_REGEX)
  required(:name).filled(max_size?: 256)
end
