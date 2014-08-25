json.array!(@fixed_deposits) do |fixed_deposit|
  json.extract! fixed_deposit, :id, :account_number, :customer_id, :opening_date
  json.url fixed_deposit_url(fixed_deposit, format: :json)
end
