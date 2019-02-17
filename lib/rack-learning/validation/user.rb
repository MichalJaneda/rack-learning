ValidationUser = Dry::Validation.Schema(AppSchema) do
  required(:email).filled(format?: Value::Validation::User::EMAIL_REGEX,
                          unique?: :email)
  required(:name).filled(max_size?: 256)
end
