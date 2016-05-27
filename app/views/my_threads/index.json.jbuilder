json.array!(@my_threads) do |my_thread|
  json.extract! my_thread, :id, :name, :overview
  json.url my_thread_url(my_thread, format: :json)
end
