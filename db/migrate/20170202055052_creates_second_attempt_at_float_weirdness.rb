class CreatesSecondAttemptAtFloatWeirdness < ActiveRecord::Migration[5.0]
  def change
    drop_table :weathers
  end
end
