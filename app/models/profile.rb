class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :owned_rates, :class_name => "Rate", :foreign_key => :owner_id
  has_many :given_rates, :class_name => "Rate", :foreign_key => :who_gave_id

  has_many :received_messages, :class_name => "Message", :foreign_key => :addressee_id
  has_many :sent_messages, :class_name => "Message", :foreign_key => :author_id

  has_many :owned_matches, :class_name => "Match", :foreign_key => :owner_id
  has_many :winned_matches, :class_name => "Match", :foreign_key => :winner_id
  has_many :matches_as_first_player, :class_name => "Match", :foreign_key => :first_player_id
  has_many :matches_as_second_player, :class_name => "Match", :foreign_key => :second_player_id

  has_many :owned_match_requests, :class_name => "MatchRequest", :foreign_key => :owner_id
  has_many :other_match_requests, :class_name => "MatchRequest", :foreign_key => :second_player_id


  HUMANIZED_ATTRIBUTES = {
    :ntrp => 'NTRP',
    :state => 'state',
    :first_name => 'first_name',
    :last_name => 'last_name',
    :city => 'City'
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end


  validates_presence_of :ntrp, :state, :first_name, :last_name, :city, :message => "nie może być puste!", :on => :update
  validates_presence_of :nick, :message => "can't be empty", :on => :update


  validates_each :ntrp do |record, attr, value|
    acceptable_ntrps = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0]
    if value != nil and not acceptable_ntrps.include?(value)
      record.errors.add attr, "must have a value of: 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0!"
    end
  end

validates_uniqueness_of :nick, :message => "is busy", :on => :update, :case_sensitive => false,
  :unless => Proc.new { |p| p.nick.downcase == "account deactivated".downcase }


  def match_requests
    MatchRequest.with_match_request(self)
  end

  def matches
    Match.with_matches(self)
  end

  def messages
    Message.with_messages(self)
  end
end
