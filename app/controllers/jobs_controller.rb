class JobsController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
  before_action :set_job, only: [:edit, :show, :update]
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def new
    @job = Job.new
  end

  def edit
    if current_user.id != @job.user_id
      redirect_to root_path, alert: 'You are not allowed to edit that job!'
    end
  end

  def update
    @job.update(job_params)
    respond_with @job
  end

  def create
    @job = Job.create(job_params)
    @job.user_id = current_user.id
    respond_with @job
  end

  private

  def set_collections
    @categories = Category.all
    if current_user
      @companies = Company.where(user_id: current_user.id)
    else
      @companies = Company.all
    end
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job)
      .permit(:title, :location, :category_id, :description, :featured,
             :company_id, :hiring_type)
  end
end
