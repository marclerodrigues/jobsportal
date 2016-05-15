class RequirementsController < ApplicationController
  def index
    @requirements = Requirement.all
  end
  def show
    @requirement = Requirement.find(params[:id])
  end
  def create
    @requirement = Requirement.new(requirement_params)
    if @requirement.save
      redirect_to @requirement
    else
      render :new
    end
  end
  def update
    @requirement = Requirement.find(params[:id])
    if @requirement.update(requirement_params)
      redirect_to @requirement
    else
      render :edit
    end
  end
  def destroy
    @requirement = Requirement.find(params[:id])
    @requirement.destroy
    redirect_to requirements_path
  end

  private

  def requirement_params
    params.require(:requirement).permit(:title, :years, :job_id)
  end
end
