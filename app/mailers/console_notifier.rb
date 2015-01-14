class ConsoleNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.console_notifier.error_occured.subject
  #
  def error_occured(error)
    @error = error
    mail to: "869027168@qq.com",
         subject: 'Depot App出现了错误' 
  end
end
