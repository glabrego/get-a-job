class CompaniesController < ApplicationController
  def new
    @company = Company.new
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.create(company_params)
    redirect_to @company
  end

  private

  def company_params
    params.require(:company)
      .permit(:name, :location, :mail, :phone)
  end
end
