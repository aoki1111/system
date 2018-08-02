module PostagesHelper

    def postage_list
        list = []
        factor = [["BOX野菜 - Mサイズ", "MiddleBox"], ["小品目BOX野菜", "FewItemBox" ]]
        postages = current_user.postages
        for item in factor do
            for postage in postages do
                list.push(item) if postage.item_type != item[1]
            end
        end
        return list
    end

end
