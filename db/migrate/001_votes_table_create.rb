class VotesTableCreate < ActiveRecord::Migration
  def self.up
    create_table :votes, :force => true do |t|
      t.column :vote, :boolean, :default => false
      t.column :created_at, :datetime, :null => false
      t.column :voteable_type, :string, :default => "", :null => false
      t.column :voteable_id, :integer, :default => 0, :null => false
      t.column :user_id, :integer, :default => 0, :null => false
    end

    add_index :votes, [:user_id], :name => "fk_votes_user"
    add_index :votes, [:voteable_id, :voteable_type], :name => "fk_votes_voteable"
  end

  def self.down
    drop_table :votes
  end
end