class JobsController < ApplicationController
  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
    @companies = Company.all
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job
    else
      @companies = Company.all
      render new_job_path
    end
  end

  private

  def job_params
    params.require(:job)
      .permit(:title, :location, :category, :description, :featured,
             :company_id)
  end
end
