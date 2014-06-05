class CreateEventModel < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.datetime :end_date

      t.belongs_to :user
      t.belongs_to :state
    end
  end
end
