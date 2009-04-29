class IssuesAddVotesValue < ActiveRecord::Migration
  def self.up
    add_column :issues, :votes_value, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :issues, :votes_value
  end
end