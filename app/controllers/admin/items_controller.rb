class ItemsController < ApplicationController
  def index
    @items = current_user.items
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: '商品紹介', #pdfファイルの名前。これがないとエラーが出ます
        encording: 'UTF-8',
        layout: 'pdf_layouts.html', #レイアウトファイルの指定。views/layoutsが読まれます。
        template: 'items/index_pdf.html' #テンプレートファイルの指定。viewsフォルダが読み込まれます。
      end
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = current_user.items.build(item_params)
    @item.save!
    redirect_to items_url, notice: "品目を登録しました。"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    flash[:success] = "「#{item.item_name}」を更新しました。"
    redirect_to items_url
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = "品目が削除されました。"
    redirect_to items_url
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :area, :description)
  end
end
