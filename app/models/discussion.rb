class Discussion < ActiveRecord::Base
  has_many :events
  has_many :messages
  has_and_belongs_to_many :promotions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :establishments

  def get_destination_names
    names_list = []
    establishments.each do |est|
      names_list << est.name
    end
    promotions.each do |prom|
      names_list << prom.name
    end
    users.each do |user|
      names_list << user.get_complete_name
    end
    names_list
  end
end
