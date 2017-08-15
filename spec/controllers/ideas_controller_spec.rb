require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  before(:each) do
    @parent_idea = Idea.create(:description => "Parent Idea")
  end

  it "GET index" do
    get :index
    expect(assigns(:ideas)).to eq([@parent_idea])
  end

  it "GET new" do
    get :new
    expect(response).to render_template(:new)
    expect(response.status).to eq(200)
  end

  describe "POST create" do
    it "new parent Idea" do
      expect{
        post :create, :params => {:idea => Idea.new(:description => 'New parent idea').as_json}
      }.to change(Idea, :count).by(1)
    end

    it "new child Idea" do
      idea = Idea.new(:parent_id => @parent_idea.id, :description => "Child idea")
      expect{
        post :create, :params => {:idea => idea.as_json}
      }.to change(Idea, :count).by(1)

      idea = Idea.last
      expect(@parent_idea.children.include?(idea)).to be_truthy
    end
  end

  describe "GET newboard" do
    it "create board" do
      expect{
        get :newboard, {:params => {:name => "Teste 1"}}
      }.to change(Idea, :count).by(1)
      expect(response).to render_template(:show)
    end

    # it "doesn't create a board with invalid name parameter" do
    #   expect{
    #     get :newboard, {:params => {:name => ""}}
    #   }.to rails_error(ParameterMissing)
    # end
  end
end
