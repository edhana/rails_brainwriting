class IdeasController < ApplicationController
  def index
    @ideas = Idea.order(updated_at: :desc)
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      redirect_to  @idea
    else
      render 'new'
    end
  end

  def new
    @parent = Idea.find(params[:parent_id]) if not params[:parent_id].nil?
    @idea = Idea.new
  end

  def show
    @idea = Idea.find(params[:id])
  end

  private
  def idea_params
    params.require(:idea).permit(:description)
  end
end

