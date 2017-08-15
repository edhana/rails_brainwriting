class IdeasController < ApplicationController
  def index
    @ideas = Idea.order(updated_at: :desc).limit(8)
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save!
      if @idea.parent.nil?
        redirect_to @idea
      else
        redirect_to @idea.parent
      end
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
    # TODO: Add security validation (via regex of the name parameter)

    boardname = newboard_name_params
    @idea = Idea.find_by_description boardname

    if @idea.nil?
      @idea = Idea.create(:description => boardname)
    end

    # redirect_to @idea
    render :show
  end

  private
  def idea_params
    params.require(:idea).permit(:parent_id, :description)
  end

  def newboard_name_params
    params.require(:name)
  end
end

