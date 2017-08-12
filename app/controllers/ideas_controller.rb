class IdeasController < ApplicationController
  def index
    @ideas = Idea.order(updated_at: :desc).limit(8)
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

  def newboard
    raise ArgumentError.new('No board name was given') unless params[:name]

    boardname = params[:name]
    @idea = Idea.find_by_description boardname

    unless @idea.nil?
      redirect_to @idea if @idea
    end

    @idea = Idea.new
    @idea.description = boardname
    @idea.save
    render 'new'
  end

  private
  def idea_params
    params.require(:idea).permit(:description)
  end
end

