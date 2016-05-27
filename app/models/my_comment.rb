class MyComment < ActiveRecord::Base
  validates :content,
  presence: { message: "入力してください"},
  length: { maximum: 255, message: "長すぎます" }
end
