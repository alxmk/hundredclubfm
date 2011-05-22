class Savegame < ActiveRecord::Base
  attr_accessible :name, :description
  
  belongs_to :user
  
  validates :name,        :presence => true,
                          :length   => { :within => 2..30 }
  validates :description, :length   => { :maximum => 50 }
end
