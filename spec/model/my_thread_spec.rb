require 'rails_helper'

describe MyThread do

  it "is valid with a title and an overview" do
    expect(build(:my_thread)).to be_valid
  end

  it "is invalid without a title" do
    my_thread = build(:my_thread, title: nil)
    my_thread.valid?
    expect(my_thread.errors[:title]).to include("入力してください")
  end

  it "is invalid without an overview" do
    my_thread = build(:my_thread, overview: nil)
    my_thread.valid?
    expect(my_thread.errors[:overview]).to include("入力してください")
  end

end
