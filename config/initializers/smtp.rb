unless Rails.config.action_mailer.nil?

  Rails.config.action_mailer.smtp_settings = {}

  options = YAML.load_file(Rails.root.join('config', 'smtp.yml'))[Rails.env]

  options.each do |name, value|
    Rails.config.action_mailer.smtp_settings[name.to_sym] = value
  end unless options.nil?
end