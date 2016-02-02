class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :show]
  before_action :authenticate_user!, except: [:show]
  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    @company.user = current_user
    respond_with @company
  end

  def edit
    if current_user.id != @company.user_id
      redirect_to root_path, alert: 'You are not allowed to edit that company!'
    end

  end

  def update
    @company.update(company_params)
    respond_with @company
  end

  def show
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :location, :mail, :phone)
  end
end
