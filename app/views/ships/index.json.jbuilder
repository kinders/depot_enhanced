json.array!(@ships) do |ship|
  json.extract! ship, :id, :order_id, :send_date, :sender, :express_company, :express_number, :is_receive
  json.url ship_url(ship, format: :json)
end
