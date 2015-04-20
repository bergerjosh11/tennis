class Message < ActiveRecord::Base
  default_scope :order => "created_at DESC"

  scope :with_messages,
    lambda {|player|
      {:conditions => ["author_id = ? or addressee_id = ?", player.id, player.id]}}

  belongs_to :match_request
  belongs_to :match
  belongs_to :author, :class_name => "Profile"
  belongs_to :addressee, :class_name => "Profile"

  HUMANIZED_ATTRIBUTES = {
    :content => "Message content"
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  validates_presence_of :content, :author_id, :addressee_id, :message => "nie może być pusta!"
end
