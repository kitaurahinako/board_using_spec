require 'rails_helper'

describe MyComment do

  it "is valid with a content" do
      expect(build(:my_comment)).to be_valid
  end

  it "is invalid without a content" do
    content = build(:my_comment, content: nil)
    content.valid?
    expect(content.errors[:content]).to include ("入力してください")
  end

  it "is invalid if more than 255 letters" do
    content = build(:my_comment, content:'あ'*256)
    content.valid?
    expect(content.errors[:content]).to include("長すぎます")
  end

end
