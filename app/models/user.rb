class User < ActiveRecord::Base
  after_save :create_profile
  after_update :change_profile_email
  before_destroy :update_profile

  has_one :profile

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable,
    #:recoverable,
    :rememberable,
    #:trackable,
    :validatable#, :confirmable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  private

  def create_profile
    profile = Profile.new
    profile.email = self.email
    profile.user_id = self.id
    profile.save
  end

  def change_profile_email
    profile = self.profile
    profile.email = self.email
    profile.save
  end

  def update_profile
    profile = self.profile
    profile.nick = "nick"
    profile.first_name = "first_name"
    profile.last_name = "last_name"
    profile.state = "state"
    profile.city = "city"
    profile.ntrp = 1.0
    profile.email = "email"
    profile.active = false

    profile.owned_match_requests.active.each do |r|
      r.cancelled = true
      r.save
    end

    profile.other_match_requests.active.each do |r|
      r.denied = true
      r.why_denied = "this account has been deactived"
      r.save
    end

    profile.matches.not_played.each do |m|
      m.cancelled = true
      m.save
    end

    profile.save
  end

end
