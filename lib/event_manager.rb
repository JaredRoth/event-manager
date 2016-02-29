require 'erb'
require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_phone(phone)
  phone.gsub(/\D/, "")
end

def validate_phone(phone)
  phone.slice!(0) if phone.length == 11 && phone[0] == '1'
  phone.length == 10 ? phone : "BadNumber "
end

def format_phone(phone)
  phone = phone.chars.insert(-5, '-')
  phone = phone.insert(3, ') ')
  phone = phone.insert(0, '(')
  phone.join
end

def clean_zipcode(zip)
  zip.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = validate_phone(clean_phone(row[:homephone]))
  formatted_phone = format_phone(phone)

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end
puts "Done"
