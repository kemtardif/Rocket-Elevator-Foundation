class Battery < ApplicationRecord
    belongs_to :building
    belongs_to :employee
    has_many :columns
    has_many :interventions

    def definition
        "(ID: " + "#{self.id}) " + self.cert_ope
    end
end
