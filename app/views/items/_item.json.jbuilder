json.extract! item, :id, :name, :description, :amount, :category_id, :transfer_id, :created_at, :updated_at
json.url item_url(item, format: :json)
