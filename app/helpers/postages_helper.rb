module PostagesHelper

    def postage_list
        list = []
        factor = [["季節の野菜セット", "MiddleBox"]]
        postages = current_user.postages
        if postages.blank?
          return factor
        else
          for item in factor do
              for postage in postages do
                  list.push(item) if postage.item_type != item[1]
              end
          end
          return list
        end
    end

end
