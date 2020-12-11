require 'csv'

namespace :import_csv do

  desc "csvデータをインポートするタスク"

  task users: :environment do
    # インポート対象のCSVファイルのパスを設定
    path = "db/csv_data/csv_data.csv"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end
    puts "インポート処理を開始"
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポート完了".green
    rescue => e
      puts"#{e.class}: #{e.message}".red
      puts "-------------------------"
      puts "#{e.backtrace}"
      puts "-------------------------"
      puts "インポートに失敗".red
    else
      
    end
  end
end
