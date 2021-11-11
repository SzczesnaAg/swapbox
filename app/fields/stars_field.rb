require "administrate/field/base"

class StarsField < Administrate::Field::Base
  def to_s
    data
  end
end
