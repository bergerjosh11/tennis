class MatchRequest < ActiveRecord::Base
  default_scope :order => "created_at DESC"
  
  scope :active, :conditions => {:denied => false, :cancelled => false, :accepted => false}
  scope :denied, :conditions => {:denied => true, :cancelled => false, :accepted => false}
  scope :accepted, :conditions => {:denied => false, :cancelled => false, :accepted => true}
    
  scope :not_denied,
    lambda {|player|  
      {:conditions => ["(second_player_id = ? and denied = ?) or owner_id = ?", player.id, false, player.id]}}      
  scope :not_cancelled, :conditions => {:cancelled => false}

  scope :with_match_request,
    lambda {|player|  
      {:conditions => ["owner_id = ? or second_player_id = ?", player.id, player.id]}}
 
  belongs_to :owner, :class_name => "Profile"
  belongs_to :second_player, :class_name => "Profile"
  
  belongs_to :match
  
  has_many :messages

  HUMANIZED_ATTRIBUTES = {
    :why_denied => 'Pole "Powód"',
    :description => 'Pole "Wiadomość"'
  }
  
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  
  validates_presence_of :owner_id, :second_player_id, :description, :message => "nie może być puste!"
  
	def opponent(player)
    if player.id == owner_id
      return second_player
    else
      return owner
    end
  end
  
  def is_active
    !denied and !cancelled and !accepted
  end
  
end
