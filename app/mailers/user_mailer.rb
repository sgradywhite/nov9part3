class UserMailer < ApplicationMailer

    def account_activation(user)
        @user = user
        mail to: user.email, subject: "Account Created Status"
    end

    def password_reset(user)
        @user = user
        mail to: user.email, subject: "Password reset"
    end

    def confirm_appointment(u, a)
      @user = u
      @appointment = a
      mail to: user.email, subject: "Confirm Appointment #{@appointment.id}"
    end

    def cancel_appointment(user)
      @user = user
      mail to: user.email, subject: "Cancel Appointment"
    end

end
