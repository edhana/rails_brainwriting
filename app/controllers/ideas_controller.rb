class IdeasController < ApplicationController
  def index
    @ideas = Idea.where(parent_id: nil).order(updated_at: :desc).limit(8)
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
    if params[:parent_id].nil?
      @idea = Idea.new
    else
      load_parent_board(params[:parent_id])
    end
  end

  def show
    load_parent_board(params[:id])
  end

  def newboard
    # TODO: Add security validation (via regex of the name parameter)

    board = Idea.find_by_description(newboard_name_params)
    @idea = Idea.new

    if board.nil?
      newidea = Idea.create(:description => newboard_name_params)
      @idea.parent = newidea
    end

    # redirect_to @idea
    load_parent_board(@idea.parent.id)
    render 'newboard'
  end

  private
  def idea_params
    params.require(:idea).permit(:parent_id, :description)
  end

  def newboard_name_params
    params.require(:name)
  end

  def load_parent_board(parent_id)
    @idea = Idea.new(:parent_id => parent_id)
    @parent = @idea.parent
  end
end

