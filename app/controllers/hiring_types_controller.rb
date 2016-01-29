class HiringTypesController < ApplicationController

  def show
    @jobs = Job.where(hiring_type: params[:id]) 
  end
end
