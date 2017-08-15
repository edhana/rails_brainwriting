require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "save a child idea with a parent reference" do
    parent = Idea.create(:description => "Parent")

    parent.children.create(:description => "Child")
    child = Idea.last

    expect(child.parent).not_to be_nil
  end
end
