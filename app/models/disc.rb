class Disc < ActiveRecord::Base
  belongs_to :player
  after_initialize :set_color

  def set_color
    self.color = self.player.color
  end

end