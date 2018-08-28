FactoryBot.define do
  factory :user do
    name { 'First Last' }
    email { 'me@example.com' }

    factory :staff do
      email { 'flast@syosset.k12.ny.us' }
    end
    factory :student do
      email { '1234@syosset.k12.ny.us' }
    end
  end
end
