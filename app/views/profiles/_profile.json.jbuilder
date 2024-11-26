json.extract! profile, :id, :user_id, :bio, :avatar_url, :created_at, :updated_at
json.url profile_url(profile, format: :json)
