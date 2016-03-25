

unless User.where(email: 'foo@bar.com').count > 0
  User.create!(email: 'foo@bar.com', password: 'password', password_confirmation: 'password')
end

@user = User.where(email: 'foo@bar.com').first

@tag = @user.tags.new(name: Faker::Color.color_name, user_id: @user.id)
Task.create!(title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
             tag_id: @tag.id,
             user_id: @user.id)

4.times do
  @tag = @user.tags.create!(name: Faker::Hipster.word, user_id: @user.id)
  2.times do
    Task.create!(title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
                 tag_id: @tag.id,
                 user_id: @user.id,
                 desc: Faker::Hipster.paragraph(2),
                 duration: rand(20000))
  end
  2.times do
    Task.create!(title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}",
                 tag_id: @tag.id,
                 user_id: @user.id,
                 desc: Faker::Hipster.paragraph(2),
                 duration: rand(20000),
                 completed_at: Time.now)

  end
end

