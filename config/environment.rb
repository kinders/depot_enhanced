# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# 下面是邮件配置
Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.sina.cn",           # 'smtp.gmail.com',
    port: 25,                           # 587,
    domain: "sina.cn",                  # 'domain.of.sender.net',
    authentication: :login,             #  "plain"
    user_name: "dave" 
    password: "secret", 
    enable_starttls_auto: true
  }
end
