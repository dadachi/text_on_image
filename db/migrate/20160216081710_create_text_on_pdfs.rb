class CreateTextOnPdfs < ActiveRecord::Migration
  def change
    create_table :text_on_pdfs do |t|
      t.string :dir
      t.string :file_name
      t.string :original_dir
      t.string :original_file_name

      t.timestamps null: false
    end
  end
end
