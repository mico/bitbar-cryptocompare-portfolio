#!/usr/bin/env ruby

# <bitbar.title>Cryptocompare portfolio holdings</bitbar.title>
# <bitbar.version>v0.1.1</bitbar.version>
# <bitbar.author>Artur Komarov</bitbar.author>
# <bitbar.author.github>mico</bitbar.author.github>
# <bitbar.desc>Shows Cryptocompare portfolio holdings amount</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>

#
# Configuration
# - Create ~/portfolio.yml with 'cookie' value you get from your browser:
# ---
# cookie: __cfduid=...; _ga=...; G_ENABLED_IDPS=google; lightsOff=1; _gid=..; sid=...

require 'open-uri'
require 'net/http'
require 'json'
require 'yaml'

settings = YAML.load(open("#{ENV['HOME']}/portfolio.yml").read)

uri = URI.parse('https://www.cryptocompare.com/portfolio/')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
headers = { "Cookie" => settings['cookie'] }
resp = http.get(uri.request_uri, headers)
page = resp.body
json_data = JSON.parse(page.split("portfolioManager.setPortfolioData(")[1].split(');')[0])
symbols = json_data['Data'][0]['Members'].map{|coin| coin['Coin']['Symbol']}.join(',')
prices = JSON.parse(open("https://min-api.cryptocompare.com/data/pricemulti?fsyms=#{symbols}&tsyms=USD").read)
total = 0
json_data['Data'][0]['Members'].each do |coin|
  total += prices[coin['Coin']['Symbol']]['USD'] * coin['Amount']
end
puts "#{total.round(0)}"

# add 24h top gainers (+% current price totalUSDforAllPositions )
# top value currencies (accumulated positions) - same fields
