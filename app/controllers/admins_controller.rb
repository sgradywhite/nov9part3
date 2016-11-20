class AdminsController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    before_action :office_user,    only: :destory
    before_action :doctor_user,    only: :destory
    before_action :patient_user,   only: :destory

     def index
         @admin = User.paginate(page: params[:page])
     end

     def show
         admin = User.find(params[:id])
         if admin.role == "admin"
           redirect_to(admin_page_url)
         elsif admin.role == "doctor"
           redirect_to(doctor_page_url)
         elsif admin.role == "office"
          redirect_to(office_page_url)
         elsif admin.role == "patient"
          redirect_to(patient_page_url)
         end
     end

     def new
         @admin = User.new
     end

     def admin_page
     end

     def doctor_page
     end

     def office_page
     end

     def patient_page
     end

    def create
    @admin = User.new(user_params)
     if @admin.save
       @admin.send_activation_email
       flash[:info] = "You have created an account."
       redirect_to root_url
     else
       render 'new'
     end
    end

     def edit

     end

     def update
         @admin = User.find(params[:id])
         if @admin.update_attributes(user_params)
             flash[:success] = "Profile updated"
             redirect_to @admin
             else
             render 'edit'
         end
     end

     def destroy
         User.find(params[:id]).destroy
         flash[:success] = "User deleted"
         redirect_to createaccount_path
     end

     
     

   private

     def user_params
         params.require(:user).permit(:firstname, :lastname, :email, :password,
                                      :password_confirmation, :role, :specialty)
     end
     

     # Before filters

     # Confirms the correct user.
     def correct_user
         @admin = User.find(params[:id])
         redirect_to(root_url) unless current_user?(@admin)
     end

     # Confirms an admin user.
     def admin_user
         redirect_to(admin_page_url) if current_user.admin?
     end
      # Confirms an doctor user.
     def doctor_user
         redirect_to(doctor_page_url) if current_user.doctor?
     end
      # Confirms an office user.
     def office_user
         redirect_to(office_page_url) if current_user.office?
     end
      # Confirms an patient user.
     def patient_user
         redirect_to(patient_page_url) if current_user.patient?
     end
end