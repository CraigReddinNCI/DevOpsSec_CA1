class Todo < ApplicationRecord
    validates :todoname, presence: true
    validates :tododescription, presence: true
end
  
