require 'rails_helper'

RSpec.describe ModeratedModel, type: :model do

  it "should considered as apropriate content" do
    a = ModeratedModel.create(title: "hi appropriate goodbye", content: "hi appropriate goodbye")

    expect(a.is_accepted).to(eq(true))
  end


  it "should considered as inapropriate content caused by title" do
    a = ModeratedModel.create(title: "i don't like you", content: "hi appropriate goodbye")

    expect(a.is_accepted).to(eq(false))
  end

  it "should considered as inapropriate content caused by content" do
    a = ModeratedModel.create(title: "hi appropriate goodbye", content: "i don't like you")

    expect(a.is_accepted).to(eq(false))
  end

end
