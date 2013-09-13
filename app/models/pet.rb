class Pet < ActiveRecord::Base
  attr_accessible :breed, :description, :namePet
  #must use for correlation between user-pet
  belongs_to :user
  validates :user_id, presence: true

  has_many :checkins

  has_many :follower_users, through: :relationships, source: :follower
  has_many :relationships, foreign_key: "followed_id", dependent: :destroy

  validates :namePet, presence: true, length: { maximum: 50 };
  validates :breed, presence: true, length: { maximum: 50 };
  validates :description, presence: true, length: { maximum: 50 };

  def self.search(breed)
    if breed
      where('breed LIKE ?', "%#{breed}%")
    else
      scoped # return an empty result set
    end
  end

  #calculate range popularity into 7days
  def self.popularity(pet)
    pet.relationships.select{|x| x.created_at > date=Date.today-(7)}
  end

  #(in the next it can other values for calculating)
  def self.actual_popularity(pet)
    pop_count=popularity(pet).count
    if pop_count < 100
      pop_count
    else
      100
    end
  end

end
