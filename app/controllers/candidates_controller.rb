class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end
  def show
    @candidate = Candidate.find(params[:id])
  end
  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to @candidate
    else
      render :new
    end
  end
  def update
    @candidate = Candidate.find(params[:id])
    if @candidate.update(candidate_params)
      redirect_to @candidate
    else
      render :edit
    end
  end
  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    redirect_to candidates_path
  end

  private

  def candidate_params
    params.require(:candidate).permit(
      :first_name,
      :last_name
      )
  end
end
