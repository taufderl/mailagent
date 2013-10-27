class UserMailer < ActionMailer::Base
  default from: ENV['DEFAULT_FROM_MAIL_ADDRESS']
  default bcc: ENV['MAILAGENT_DEBUG_MAIL_ADDRESS']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_new_admin.subject
  #
  def notify_new_admin user, pw
    @user = user
    @pw = pw

    mail to: @user.email
  end
end
