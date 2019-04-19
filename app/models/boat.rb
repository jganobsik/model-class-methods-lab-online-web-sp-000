class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    Boat.all[0,5]
  end
  def self.dinghy
    boats = Boat.all
    boats.filter{|b| b.length < 20}
  end
  
  def self.ship
     boats = Boat.all
     boats.filter{|b| b.length >= 20}
  end
  
  def self.last_three_alphabetically
    boats = Boat.all
    boats.order_by(name: :desc).limit(3)
  end

  def self.without_a_captain
    boats = Boat.all
    boats.filter(|b| b.captain_id == nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
  end

  def self.longest
     boats = Boat.all
    boats.order_by(length: :desc).limit(1)
  end
end
