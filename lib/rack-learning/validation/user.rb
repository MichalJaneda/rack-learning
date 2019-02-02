ValidationUser = Dry::Validation.Schema(AppSchema) do
  configure do
    def unique?(attr_name, value)
      Query::Repository::Users.where(attr_name => value).empty?
    end
  end

  required(:email).filled(format?: Value::Validation::User::EMAIL_REGEX,
                          unique?: :email)
  required(:name).filled(max_size?: 256)
end
