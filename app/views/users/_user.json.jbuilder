# json.extract! user, :id, :name, :email, :manager_id, :created_at, :updated_at
# json.url user_url(user, format: :json)
org = reporting_tree(user)
json.set! :users do
  json.merge(report_hash)
end
