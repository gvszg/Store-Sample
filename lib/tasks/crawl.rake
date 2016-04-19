require 'net/http'
require 'capybara'
require 'capybara/dsl'

namespace :crawl do
  task :crawl_counties => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(3)
    page_no = Nokogiri::HTML(page.html)
    puts page_no
    sleep(3)
    buttons = page_no.css("#thisMainArea").css("span")
    buttons.each do |button|
      puts button.children.to_s
      county = County.new
      county.name = button.children.to_s
      county.save!
    end
  end

  task :crawl_towns => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(3)
    County.all.each do |county|
      find_button("#{county.name}").click
      sleep(3)
      page_no = Nokogiri::HTML(page.html)
      page_no.css("#thisMainArea button").css("span").last.remove
      buttons = page_no.css("#thisMainArea button").css("span")
      buttons.each do |button|
        puts button.children.to_s
        town = Town.new
        town.county_id = county.id
        town.name = button.children.to_s
        town.save!
      end

      find_button("上一步").click
      sleep(3)
    end
  end

  task :crawl_roads => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(2)
    County.all.each do |county|
      find_button("#{county.name}").click
      sleep(2)
      towns = county.towns
      towns.each do |town|
        find_button("#{town.name}").click
        sleep(2)
        page_no = Nokogiri::HTML(page.html)
        page_no.css("#thisMainArea button").css("span").last.remove
        buttons = page_no.css("#thisMainArea button").css("span")
        buttons.each do |button|
          puts button.children.to_s
          road = Road.new
          road.town_id = town.id
          road.name = button.children.to_s
          road.save!
        end

        find_button("上一步").click
        sleep(2)
      end

      find_button("上一步").click
      sleep(2)
    end
  end

  # 分批抓取道路
  task :crawl_roads_manually => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(2)
    # County.all.each do |county|
    county = County.all.find(20)
      find_button("#{county.name}").click
      sleep(1)
      towns = county.towns
      towns.each do |town|
        find_button("#{town.name}").click
        sleep(1)
        page_no = Nokogiri::HTML(page.html)
        page_no.css("#thisMainArea button").css("span").last.remove
        buttons = page_no.css("#thisMainArea button").css("span")
        buttons.each do |button|
          puts button.children.to_s
          road = Road.new
          road.town_id = town.id
          road.name = button.children.to_s
          road.save!
        end

        find_button("上一步").click
        sleep(1)
      end

      find_button("上一步").click
      sleep(1)
    # end
  end
end