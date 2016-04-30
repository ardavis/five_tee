def new_title
  @new_title = "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}"
end

def new_description
  @new_desc = Faker::Hipster.paragraph(2)[0..199]
end

def new_tag
  @new_tag = Faker::Hipster.word
end

def new_duration
  @new_duration = {hours: rand(5), mins: rand(59), secs: rand(59)}
end