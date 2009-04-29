# ActsAsVoteable
module Juixe
  module Acts #:nodoc:
    module Voteable #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_voteable
          has_many :votes, :as => :voteable, :dependent => :delete_all
          include Juixe::Acts::Voteable::InstanceMethods
          extend Juixe::Acts::Voteable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        def find_votes_cast_by_user(user=User.current)
          voteable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          Vote.find(:all,
            :conditions => ["user_id = ? and voteable_type = ?", user.id, voteable],
            :order => "created_at DESC"
          )
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        def vote( vote=:up, user=User.current )
          return if voted_by_user? user
          Vote.create( :voteable => self, :vote => vote == :up, :user => user ) 
          self.votes_value += vote == :up ? 1:-1;
        end
        def votes_for
          self.votes.select{|v| v.vote}.size
        end
        
        def votes_against
          self.votes.select{|v| !v.vote}.size
        end
        
        def votes_count
          self.votes.size
        end
        
        def users_who_voted
          users = []
          self.votes.each { |v|
            users << v.user
          }
          users
        end
        
        def voted_by_user?(user=User.current)
          rtn = false
          if user
            self.votes.each { |v|
              rtn = true if user.id == v.user_id
            }
          end
          rtn
        end
      end
    end
  end
end

ActiveRecord::Base.send :include,  Juixe::Acts::Voteable #:nodoc: