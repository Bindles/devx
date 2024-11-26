class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:auth0]

  #associations
  has_one :profile, dependent: :destroy

  has_many :posts, dependent: :destroy
  #has_many :guides, dependent: :destroy
  #has_many :snippets, dependent: :destroy

  has_many :comments, dependent: :destroy

  #friend =>
  # Users that this user has added as friends
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  # Users who have added this user as a friend
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
