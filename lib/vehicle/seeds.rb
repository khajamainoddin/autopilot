require 'csv'

puts "Importing sections..."
CSV.foreach(Rails.root.join("sections.csv"), headers: true) do |row|
  Section.create! do |section|
    section.id = row[0]
    section.name = row[1]
  end
end
