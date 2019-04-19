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
end
