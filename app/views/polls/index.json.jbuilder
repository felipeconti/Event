json.array!(@polls) do |poll|
  json.extract! poll, :description, :complement
  json.url poll_url(poll, format: :json)
end
