ActiveAdmin.register User do

  index do
    User.column_names.each do |c|
      column c.to_sym
    end
    column :messages_sent_count do |user|
      user.messages_sent_count
    end
    column :messages_received_count do |user|
      user.messages_received_count
    end
   end


end
