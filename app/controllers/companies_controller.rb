class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :show]
  before_action :authenticate_user!, except: [:show]
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      redirect_to @company
    else
      flash[:warning] = 'Warning! All fields are mandatory.'
      render :new
    end
  end

  def edit
    if current_user.id != @company.user_id
      redirect_to root_path, alert: 'You are not allowed to edit that company!'
    end

  end

  def update
    if @company.update(company_params)
      redirect_to @company
    else
      flash[:warning] = 'Warning! All fields are mandatory.'
      render :edit
    end
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
