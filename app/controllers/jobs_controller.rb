class JobsController < ApplicationController
  def show
    @job = Job.find(params[:id])
  end

  def new
    @companies = Company.all
    @job = Job.new
  end

  def create
    @companies = Company.all
    @job = Job.create(job_params)
    redirect_to @job
  end

  private

  def job_params
    params.require(:job)
      .permit(:title, :location, :category, :company_id, :description, :featured)
  end
end
