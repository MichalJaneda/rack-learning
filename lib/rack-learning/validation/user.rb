ValidationUserCreate = Dry::Validation.Schema do
  config do
    option :record

    def unique?(attr_name, value)
      record.class.where.not(id: record.id).where(attr_name => value).empty?
    end
  end

  required(:email).filled(format?: Value::Validation::User::EMAIL_REGEX,
                          unique?: :email)
  required(:name).filled(max_size?: 256)
end
