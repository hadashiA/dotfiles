$KCODE = 'u'

require 'rubygems'
require 'mechanize'
require 'nokogiri'

search_keyword = ARGV[0]

account = { 
  :email    => 'mx4@biz.pikkle.com',
  :password => 'adadad'
}

total_results = []
agent = Mechanize.new

agent.get('http://mixi.jp/view_appli.pl?id=16267')

login_form = agent.page.form_with(:name => 'login_form')
login_form.field_with(:name => 'email').value = account[:email]
login_form.field_with(:name => 'password').value = account[:password]
login_form.submit

agent.get('http://mixi.jp/view_appli.pl?id=16267')
html = agent.page.body
doc = Nokogiri::HTML(html)
puts (doc / "dl.subInfo01 dd.numMymixi").inner_text

