class Stock < ApplicationRecord
    attr_accessor :select_type

    def calculate_lock_date
        first_day = Date.today.beginning_of_year
        path_day = self.shipment_week * 7
        week_day = first_day + path_day - first_day.cwday + 1 - 7
        self.edit_lock_at = week_day
    end
end
