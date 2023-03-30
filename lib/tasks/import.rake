require 'csv'

namespace :import do
  desc "Import folks from a csv"
  task csv: :environment do
    csv_file = ENV["CSV_FILE"]
    managers_to_pk_mapping = {}
    file = File.open(csv_file)
    CSV.open(file, headers: true) do |csv|
      csv.each do |row|
        puts "row: #{row}"
        manager_id = managers_to_pk_mapping[row["reportsTo"]]
        puts "Manager id #{manager_id}"
        email = "#{row["name"].split(" ").join(".")}@shopify.com"
        user = User.create(
          email: email,
          name: row["name"],
          manager_id: manager_id,
        )

        managers_to_pk_mapping[row["id"]] = user.id
        puts "mapping #{row["id"]} to #{user.id}"
      end
    end
  end
end
