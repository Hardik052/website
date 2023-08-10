
AdminUser.create!(email: 'admin52@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?