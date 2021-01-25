FactoryBot.define do
  factory :user do
    email { "#{Time.now}@example.com"}
    password {'haliho123'}
  end

end
