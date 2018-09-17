module StocksHelper

    def calcurate_week_day
        list = []
        first_day = Date.today.beginning_of_year
        week_start_day = Date.today.beginning_of_week
        for i in (0..4)
            path_day = (week_start_day.cweek + i) * 7
            week_day = first_day + path_day - first_day.cwday + 1 - 7
            list_element = [ week_day.strftime("%m月%d日週出荷分") , week_start_day.cweek + i ]
            list.push(list_element)
        end
        return list
    end

    def product_list
        list = EcData::Product.where(id:current_user.product_items.pluck(:product_id)).pluck(:name,:id)
        return list
    end

end
