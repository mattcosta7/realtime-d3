class AddsPrizeCountAchievedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :prize_hit, :boolean, default: false
    add_column :users, :prize_hit_at, :datetime
  end
end
