Thread.new do
  if ENV["RAILS_ENV"] == "development"
    system("rackup sync.ru -s thin -E production")
  end
end
