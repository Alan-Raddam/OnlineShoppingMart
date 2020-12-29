class AddReftoProducts < ActiveRecord::Migration[6.0]

    def change
      add_reference :products,:color,foreign_key:true
      add_reference :products,:size,foreign_key:true
    end


end
