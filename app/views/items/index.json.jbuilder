json.array!(@items) do |item|
  json.extract! item, :name, :description, :amount, :value
  json.url item_url(item, format: :json)
end
