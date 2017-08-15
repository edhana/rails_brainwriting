module IdeasHelper
  def get_idea_form_url
    if @parent.nil?
      return idea_path
    else
      return ideas_path(parent)
    end
  end
end
