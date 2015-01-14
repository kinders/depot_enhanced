# Preview all emails at http://localhost:3000/rails/mailers/console_notifier
class ConsoleNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/console_notifier/error_occured
  def error_occured
    ConsoleNotifier.error_occured
  end

end
