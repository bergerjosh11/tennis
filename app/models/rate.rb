class Rate < ActiveRecord::Base
  default_scope :order => "created_at DESC"

  scope :positive, :conditions => {:rate_value => 1}
  scope :neutral, :conditions => {:rate_value => 2}
  scope :negative, :conditions => {:rate_value => 3}

  belongs_to :match
  belongs_to :owner, :class_name => "Profile"
  belongs_to :who_gave, :class_name => "Profile"

  HUMANIZED_ATTRIBUTES = {
    :rate_value => 'rate_value',
    :description => 'description'
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  validates_presence_of :rate_value, :description, :message => "can't be empty"
end
