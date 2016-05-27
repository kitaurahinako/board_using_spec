class MyThread < ActiveRecord::Base
  validates :title, presence: { message: "入力してください"}
  validates :overview, presence: { message: "入力してください"}
  has_many :my_comments
end
