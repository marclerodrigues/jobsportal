class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  def show
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.new(application_params)
    @job = Job.find(@application.job_id)
    @candidate = Candidate.find(@application.candidate_id)
    @application[:match] = @application.calculate_match(@job, @candidate)
    if @application.save
      redirect_to @application
    else
      render :new
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    redirect_to applications_path
  end

  private

  def application_params
    params.require(:application).permit(:job_id, :company_id, :candidate_id, :match)
  end
end
