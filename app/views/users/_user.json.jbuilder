json.cache! user do
  json.id user.id
  json.email user.email
  json.name user.name
  json.username user.username
  json.roles user.roles.map(&:name)
end
