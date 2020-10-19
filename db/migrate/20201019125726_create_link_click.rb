class CreateLinkClick < ActiveRecord::Migration[6.0]
  def change
    create_table :link_clicks do |t|
      t.references :link, index: true, null: false
      t.timestamps
    end
  end
end
