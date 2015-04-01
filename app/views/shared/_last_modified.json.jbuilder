json.cache! [object, 'last_modified'] do
  audit = object.audits.includes(:user).last
  if audit.user.present?
    json.user json.partial! 'users/user', user: audit.user
  end
  json.timestamp audit.created_at
end
