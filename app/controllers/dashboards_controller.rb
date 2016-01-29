class DashboardsController < ApplicationController
   before_action :authenticate_user!

def show
  if current_user.id.to_s == params[:id]
    @companies = Company.where(user: current_user)
    @jobs = Job.where(user_id: current_user.id)
    @categories = Category.includes(:jobs).where(jobs: {user_id: current_user.id})
  else
    redirect_to root_path, alert: "You cannot other users dashboard, MF!"
  end
end
end
