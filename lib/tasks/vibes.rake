namespace :faker do
  task messages: :environment do
    10.times do
      sender = User.order('RANDOM()').first
      receiver = User.order('RANDOM()').first
      if sender.messages_remaining < 1
        sender = User.order('RANDOM()').first
      end
      while sender == receiver
        receiver = User.order('RANDOM()').first
      end
      message = Faker::ChuckNorris.fact
      Message.create(
        sender_id: sender.id,
        receiver_id: receiver.id,
        body: message
      )
    end
  end

  task users: :environment do
    1500.times do
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      user = {
        fname: fname,
        lname: lname,
        email: "#{fname}.#{lname}@test-email.com"
      }
      User.create(user)
    end
  end

  task many_messages: :environment do
    1000.times do
      sender = User.order('RANDOM()').first
      receiver = User.order('RANDOM()').first
      if sender.messages_remaining < 1
        sender = User.order('RANDOM()').first
      end
      while sender == receiver
        receiver = User.order('RANDOM()').first
      end
      message = Faker::ChuckNorris.fact
      Message.create(
        sender_id: sender.id,
        receiver_id: receiver.id,
        body: message
      )
    end
  end
end
