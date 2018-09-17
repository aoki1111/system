class AddReferencesProductToStock < ActiveRecord::Migration[5.2]
  def change
      add_reference :stocks, :product, index:true
  end
end
