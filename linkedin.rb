require 'rubygems'
require 'byebug'
require 'watir-webdriver'
require 'csv'
puts "ERROR in recevived args: ruby linkedin.rb USERNAME PASSWORD FILE_WITH_NAMES" unless ARGV.size == 3
Watir.default_timeout = 30
user, password, filename = *ARGV
# puts 'Linkedin username/email (bonzofenix@gmail.com):'
# user = gets.strip

# puts 'Linkedin password (xxxxxx):'
# password = gets.strip
client = Selenium::WebDriver::Remote::Http::Default.new
client.open_timeout = 30
browser = Watir::Browser.new :chrome, http_client: client
browser.driver.manage.timeouts.implicit_wait = 30
browser.goto 'https://www.linkedin.com'
puts browser.title
browser.text_field(:id => 'login-email').set user
browser.text_field(:id => 'login-password').set password
sleep 1
browser.button(:id => 'login-submit').click

#search process
CSV.foreach(filename, { :col_sep => ';' }) do |row|
  name = row.first
  res = [name]
  browser.text_field(:class => 'ember-text-field').wait_until_present
  browser.text_field(:class => 'ember-text-field').set name
  browser.text_field(:class => 'ember-text-field').send_keys(:return)

  puts '>> ' + name

  unless browser.text.include? '0 results'

      browser.div(:class => 'search-results__cluster-content').wait_until_present
      browser.div(:class => 'search-results__cluster-content').ul.lis(:class  => 'search-result').each_with_index do |l,i|
        puts '>> Profile: ' + i.to_s 

        browser.div(:class => 'search-results__cluster-content').ul.lis(:class  => 'search-result')[i].div(:class => 'search-result__wrapper').div(:class => 'search-result__info').a.click

        browser.section(:class => 'experience-section').wait_until_present
        if !browser.text.include? 'available only to premium' and browser.section(:class => 'experience-section').exists?

          puts '>>>> Experiencias'

          browser.section(:class => 'experience-section').ul(:class => 'section-info').lis(:class => 'position-entity').each_with_index do |r,j|
            if browser.section(:class => 'experience-section').ul(:class => 'section-info').lis(:class => 'position-entity')[j].h3.exists?
              puts 'Experiencia: ' + j.to_s + ', ' + browser.section(:class => 'experience-section').ul(:class => 'section-info').lis(:class => 'position-entity')[j].h3.text
            end
          end 
        end
        browser.back
      end
  end
  
end

browser.close
puts 'bye'

# => ["OU812", "8675309"] # <= save these for future requests
#
# # or authorize from previously fetched access keys
# client.authorize_from_access("OU812", "8675309")
#
# # you're now free to move about the cabin, call any API method
