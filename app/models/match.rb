class Match < ActiveRecord::Base
  
  
  
  default_scope :order => "created_at DESC"
  
  belongs_to :owner, :class_name => "Profile"
  belongs_to :first_player, :class_name => "Profile"
  belongs_to :second_player, :class_name => "Profile"
  belongs_to :winner, :class_name => "Profile"
  
  
  
  has_one :match_request
  
  scope :active, :conditions => {:cancelled => false}
  scope :cancelled, :conditions => {:cancelled => true}
  
  scope :with_matches,
    lambda {|player|  
      {:conditions => ["first_player_id = ? or second_player_id = ?", player.id, player.id]}}
  
  scope :played, :conditions => {:was_played => true}
  scope :not_played, :conditions => {:was_played => false}
  
  scope :not_ignored, 
    lambda {|player|  
      {:conditions => ["(first_player_id = ? and first_player_ignores = ?) or (second_player_id = ? and second_player_ignores = ?)", player.id, false, player.id, false]}}
  
  scope :ignored, 
    lambda {|player|  
      {:conditions => ["(first_player_id = ? and first_player_ignores = ?) or (second_player_id = ? and second_player_ignores = ?)", player.id, true, player.id, true]}}
  
  
  has_many :messages
  
  has_many :rates

  validates_presence_of :owner_id, :first_player_id, :second_player_id, :message => "nie może być puste"

    
  def opponent(player)
    if player.id == first_player_id
      return second_player
    else
      return first_player
    end
  end
  
  def is_ignored(player)
    if player.id == first_player_id
      return first_player_ignores
    else
      return second_player_ignores
    end
  end  
  
  def is_rated(player)
    if player.id == first_player_id
      return is_rated_by_first_player
    else
      return is_rated_by_second_player
    end
  end
  
end




