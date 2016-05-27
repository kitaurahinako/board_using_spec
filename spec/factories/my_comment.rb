FactoryGirl.define do

  factory :my_thread, :class => MyThread do |thread|
      thread.title { |n| "title#{n}"}
      thread.overview { |n| "概要#{n}"}
      thread.my_comments{[
        FactoryGirl.create(:my_comment)
        ]}
  end

  factory :my_comment, :class => MyComment do |comment|
    comment.content { |n| "こんにちは#{n}" }
  end

end
