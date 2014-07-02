require 'rubygems'
require 'debugger'
require 'watir-webdriver'
require 'csv'


puts 'Linkedin username/email (bonzofenix@gmail.com):'
user = gets.strip

puts 'Linkedin password (xxxxxx):'
password = gets.strip

browser = Watir::Browser.new
browser.goto 'https://www.linkedin.com'
browser.text_field(:id => 'session_key-login').set user
browser.text_field(:id => 'session_password-login').set password
sleep 1
browser.button(:value => 'Sign In').click

#search process
CSV.foreach("vcap-bosh.csv", { :col_sep => ';' }) do |row|
  name = row.first
  res = [name]
  browser.text_field(:id => 'main-search-box').set name
  browser.button(:value => 'Search').click
  unless browser.text.include? '0 results'
    browser.ol(id: 'results').lis(:class  => 'people')[0..2].each_with_index do |l,i|
      browser.ol(id: 'results').lis(:class  => 'people')[i].a.click
      if browser.div(id: 'background-experience').exists?
        res << browser.div(id: 'background-experience').divs[0].header.text
      end
      browser.back
    end
  end
  puts res.join(';').gsub("\n", ";")
end

browser.close
puts 'bye'

# => ["OU812", "8675309"] # <= save these for future requests
#
# # or authorize from previously fetched access keys
# client.authorize_from_access("OU812", "8675309")
#
# # you're now free to move about the cabin, call any API method
