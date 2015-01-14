json.array!(@administrators) do |administrator|
  json.extract! administrator, :id, :name
  json.url administrator_url(administrator, format: :json)
end
