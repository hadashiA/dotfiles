require 'rubygems'
require 'mechanize'
require 'kconv'
require 'action_mailer'
# require 'yaml'

$KCODE = 'u'

class YahuokuMailer < ActionMailer::Base
  def result_message(cond, result)
    from 'kaimono@hadashikick.jp'
    recipients 'kaimono@hadashikick.jp'
    subject cond.inspect
    body result
  end
end

ActionMailer::Base.smtp_settings = {
  :address => 
}

ALL      = '0'
NEW      = '1'
OLD      = '2'
STORE    = '1'
PERSONAL = '2'

conditions = [
  { :p => 'オレンジ',
    :orp => '812sh 830sh',
    :istatus => ALL
  },
  { :orp => 'majestouch FKB108M',
    :notp => '黒',
    :istatus => OLD
  },
]

# agent = Mechanize.new

# conditions.each do |cond|
#   page = agent.get('http://auctions.yahoo.co.jp/jp/show/searchoptions?catid=0')
#   form = page.forms.first
#   [:p, :orp, :norp].each do |field_name|
#     form.send(:"#{field_name}=", cond[field_name]) if cond[field_name]
#   end
#   [:istatus, :abatch].each do |field_name|
#     form.radiobutton_with(:name => field_name.to_s, :value => cond[field_name]).check if cond[field_name]
#   end

#   page = form.submit

#   doc = Nokogiri::HTML(page.body)
#   puts (doc / "div#list01").to_html
# end

