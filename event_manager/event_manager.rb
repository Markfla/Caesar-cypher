require 'google/apis/civicinfo_v2'
require 'csv'
require 'date'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_number(number)
  number_str = number.to_s.gsub(/\D/, '')

  if number_str.length == 10
    number_str
  elsif number_str.length == 11 && number_str[0] == '1'
    number_str[1..10]
  else
    '0000000000'
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = File.read('secret.key').strip

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue Google::Apis::ClientError => e
    puts "Error: #{e.message}"
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  rescue StandardError => e
    puts "An unexpected error occurred: #{e.message}"
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hourly_counts = Hash.new(0)
day_of_week_counts = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  number = clean_number(row[:homephone])
  puts "#{name} - Cleaned Number: #{number}"

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  registration_time = DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M')

  hour = registration_time.hour
  day_of_week = registration_time.strftime('%A')  # Full name of the day of the week

  hourly_counts[hour] += 1
  day_of_week_counts[day_of_week] += 1
end

peak_hours = hourly_counts.max_by { |hour, count| count }
peak_days = day_of_week_counts.max_by { |day, count| count }

puts "Peak hours: #{peak_hours.inspect}"
puts "Peak days: #{peak_days.inspect}"
