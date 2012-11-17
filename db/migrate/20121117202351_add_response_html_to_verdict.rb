class AddResponseHtmlToVerdict < ActiveRecord::Migration
  def change
    change_table :verdicts do |t|
      # TODO(pwnall) change to null: false, add limit: 1.megabyte
      t.text :response_html, null: true
    end
  end
end
