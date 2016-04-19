require 'net/http'
require 'capybara'
require 'capybara/dsl'

namespace :crawl do
  task :crawl_stores => :environment do
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
        roads = town.roads
        roads.each do |road|
          find_button("#{road.name}").click
          sleep(2)
          begin
            find_button("關閉").click
            sleep(2)
          rescue Exception => e
            sleep(1)
            # find_button("關閉").click
            # find(".ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only").click_link_or_button("關閉")
            sleep(1)
          end

          page_no = Nokogiri::HTML(page.html)
          stores = page_no.css(".cssTR")
          stores.each do |store|
            store_name = store.css(".cssTDTitle").children[0].to_s
            store_code = store.css(".cssTDData")[0].children[0].to_s.gsub("門市服務代號：", "")
            store_address = store.css(".cssTDData")[1].children[0].to_s.gsub("地址：", "")
            store_phone = store.css(".cssTDData")[2].children[0].to_s.gsub("電話：", "")
            puts store_name
            puts store_code
            puts store_address
            puts store_phone
            
            if Store.find_by(store_code: store_code)
              next
            else
              the_store = Store.new
              the_store.county_id = county.id
              the_store.town_id = town.id
              the_store.road_id = road.id
              the_store.store_code = store_code
              the_store.name = store_name
              the_store.address = store_address
              the_store.phone = store_phone

              if store_name.index("全家")
                the_store.store_type = 1
              elsif store_name.index("OK")
                the_store.store_type = 2
              elsif store_name.index("萊爾富")
                the_store.store_type = 3
              end

              the_store.save!
            end
          end

          find_button("上一步").click
          sleep(2)
        end

        find_button("上一步").click
        sleep(2)
      end

      find_button("上一步").click
      sleep(2)
    end
  end

  # 手動分批抓取門市資料
  task :crawl_stores_manually => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(2)

    # County.all.each do |county|
    # 找特定縣市
    county = County.all.find(4)
      find_button("#{county.name}").click
      sleep(1)

      towns = county.towns
      towns.each do |town|
      # 找特定鄉鎮
      # town = county.towns.find(37)
        find_button("#{town.name}").click
        sleep(1)

        roads = town.roads
        roads.each do |road|
        # 找特定路段
        # road = town.roads.find(212)
          find_button("#{road.name}").click
          sleep(2)
          begin
            find_button("關閉").click
            sleep(2)
          rescue Exception => e
            # sleep(1)
            # find_button("關閉").click
            # find(".ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only").click_link_or_button("關閉")
            # sleep(1)
          end

          page_no = Nokogiri::HTML(page.html)
          stores = page_no.css(".cssTR")
          stores.each do |store|
            store_name = store.css(".cssTDTitle").children[0].to_s
            store_code = store.css(".cssTDData")[0].children[0].to_s.gsub("門市服務代號：", "")
            store_address = store.css(".cssTDData")[1].children[0].to_s.gsub("地址：", "")
            store_phone = store.css(".cssTDData")[2].children[0].to_s.gsub("電話：", "")
            puts store_name
            puts store_code
            puts store_address
            puts store_phone

            if Store.find_by(store_code: store_code)
              next
            else
              the_store = Store.new
              the_store.county_id = county.id
              the_store.town_id = town.id
              the_store.road_id = road.id
              the_store.store_code = store_code
              the_store.name = store_name
              the_store.address = store_address
              the_store.phone = store_phone

              if store_name.index("全家")
                the_store.store_type = 1
              elsif store_name.index("OK")
                the_store.store_type = 2
              elsif store_name.index("萊爾富")
                the_store.store_type = 3
              end

              the_store.save!
            end
          end

          find_button("上一步").click
          sleep(1)
        end

        find_button("上一步").click
        sleep(2)
      end

      # find_button("上一步").click
      # sleep(2)
    # end
  end

  # 大都會區專用手動分批抓取門市資料
  task :crawl_stores_capital => :environment do
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(2)

    # County.all.each do |county|
    # 找特定縣市
    county = County.all.find(1)
      find_button("#{county.name}").click
      sleep(1)

      # towns = county.towns
      # towns.each do |town|
      # 找特定鄉鎮
      town = county.towns.find(1)
        find_button("#{town.name}").click
        sleep(1)

        roads = town.roads
        roads.each do |road|
        # 找特定路段
        # road = town.roads.find(212)
          find_button("#{road.name}").click
          sleep(2)
          begin
            find_button("關閉").click
            sleep(1)
          rescue Exception => e
            # sleep(1)
            # find_button("關閉").click
            # find(".ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only").click_link_or_button("關閉")
            # sleep(1)
          end

          page_no = Nokogiri::HTML(page.html)
          stores = page_no.css(".cssTR")
          stores.each do |store|
            store_name = store.css(".cssTDTitle").children[0].to_s
            store_code = store.css(".cssTDData")[0].children[0].to_s.gsub("門市服務代號：", "")
            store_address = store.css(".cssTDData")[1].children[0].to_s.gsub("地址：", "")
            store_phone = store.css(".cssTDData")[2].children[0].to_s.gsub("電話：", "")
            puts store_name
            puts store_code
            puts store_address
            puts store_phone
            
            if Store.find_by(store_code: store_code)
              next
            else
              the_store = Store.new
              the_store.county_id = county.id
              the_store.town_id = town.id
              the_store.road_id = road.id
              the_store.store_code = store_code
              the_store.name = store_name
              the_store.address = store_address
              the_store.phone = store_phone

              if store_name.index("全家")
                the_store.store_type = 1
              elsif store_name.index("OK")
                the_store.store_type = 2
              elsif store_name.index("萊爾富")
                the_store.store_type = 3
              end

              the_store.save!
            end
          end

          find_button("上一步").click
          sleep(1)
        end

      #   find_button("上一步").click
      #   sleep(2)
      # end

      # find_button("上一步").click
      # sleep(2)
    # end
  end

  # 指定參數抓取特定縣市鄉鎮下的門市資料
  task :crawl_stores_params, [:county_id, :town_id] => :environment do |task, args|
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(1)

    # 找特定縣市
    county = County.all.find(args.county_id)
    find_button("#{county.name}").click
    sleep(1)
  
    # 找特定鄉鎮
    town = county.towns.find(args.town_id)
    find_button("#{town.name}").click
    sleep(1)

    roads = town.roads
    roads.each do |road|
        find_button("#{road.name}").click
        sleep(1)

        begin
          find_button("關閉").click
          sleep(1)
        rescue Exception => e
        end

        page_no = Nokogiri::HTML(page.html)
        stores = page_no.css(".cssTR")
        stores.each do |store|
          store_name = store.css(".cssTDTitle").children[0].to_s
          store_code = store.css(".cssTDData")[0].children[0].to_s.gsub("門市服務代號：", "")
          store_address = store.css(".cssTDData")[1].children[0].to_s.gsub("地址：", "")
          store_phone = store.css(".cssTDData")[2].children[0].to_s.gsub("電話：", "")
          puts store_name
          puts store_code
          puts store_address
          puts store_phone
         
          if Store.find_by(store_code: store_code)
            next
          else
            the_store = Store.new
            the_store.county_id = county.id
            the_store.town_id = town.id
            the_store.road_id = road.id
            the_store.store_code = store_code
            the_store.name = store_name
            the_store.address = store_address
            the_store.phone = store_phone

            if store_name.index("全家")
              the_store.store_type = 1
            elsif store_name.index("OK")
              the_store.store_type = 2
            elsif store_name.index("萊爾富")
              the_store.store_type = 3
            end

            the_store.save!
          end
        end

      find_button("上一步").click
      sleep(1)
    end
  end

  # 指定路段
  task :crawl_stores_params_road, [:county_id, :town_id, :road_id] => :environment do |task, args|
    desc "Passing county_id, town_id, and road_id to crawl specified cv stores data"
    include Capybara::DSL
    Capybara.current_driver = :selenium_chrome
    page.visit "http://map.ezship.com.tw/ezship_map_web_2014.jsp"
    find("#ui-id-3").click
    sleep(1)

    # 找特定縣市
    county = County.all.find(args.county_id)
    find_button("#{county.name}").click
    sleep(1)
  
    # 找特定鄉鎮
    town = county.towns.find(args.town_id)
      find_button("#{town.name}").click
      sleep(1)

    road = town.roads.find(args.road_id)
    find_button("#{road.name}").click
    sleep(1)
    begin
      find_button("關閉").click
      sleep(1)
    rescue Exception => e        
    end

    page_no = Nokogiri::HTML(page.html)
    stores = page_no.css(".cssTR")
    stores.each do |store|
      store_name = store.css(".cssTDTitle").children[0].to_s
      store_code = store.css(".cssTDData")[0].children[0].to_s.gsub("門市服務代號：", "")
      store_address = store.css(".cssTDData")[1].children[0].to_s.gsub("地址：", "")
      store_phone = store.css(".cssTDData")[2].children[0].to_s.gsub("電話：", "")
      puts store_name
      puts store_code
      puts store_address
      puts store_phone

      if Store.find_by(store_code: store_code)
        next
      else
        the_store = Store.new
        the_store.county_id = county.id
        the_store.town_id = town.id
        the_store.road_id = road.id
        the_store.store_code = store_code
        the_store.name = store_name
        the_store.address = store_address
        the_store.phone = store_phone

        if store_name.index("全家")
          the_store.store_type = 1
        elsif store_name.index("OK")
          the_store.store_type = 2
        elsif store_name.index("萊爾富")
          the_store.store_type = 3
        end

        the_store.save!
      end        
    end
  end
end