require 'net/http'

namespace :crawl do
  # 單一門市經緯度
  task :stores_lat_lng_one_store => :environment do
    # url_string = URI.escape('http://maps.googleapis.com/maps/api/geocode/json?address=台中市大里區益民路一段58號&sensor=true')
    store = Store.find(ARGV[1].to_i)
    store_address = store.address.to_s
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor=true"
    url_string = URI.escape(url)

    # proxy_host = "24.230.220.227"
    # proxy_port = 34002

    uri = URI.parse(url_string)

    # proxy = Net::HTTP::Proxy(proxy_host, proxy_port)

    # req = Net::HTTP::Get.new(uri.path)
    # req.basic_auth(<sauce_username>,<sauce_password>)

    # response = proxy.start(uri.host,uri.port) { |http| http.request(req) }

    # response = Net::HTTP::Proxy(proxy_addr, proxy_port).get_response(uri)
    # response = Net::HTTP::Proxy("37.59.13.53", "34529").get_response(uri)

    # response = Net::HTTP.get_response(uri.to_s, "37.59.13.53", 34529)

    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

    content = response.body
    lat = JSON.parse(content)['results'][0]['geometry']['location']['lat'].to_s
    lng = JSON.parse(content)['results'][0]['geometry']['location']['lng'].to_s
    store.lat = lat
    store.lng = lng
    store.save!
    print lat + " " + lng

    # 避免執行 rake ARGV 出現錯誤
    ARGV.each { |a| task a.to_sym do ; end }
  end

  # 單一鄉鎮區門市經緯度
  task :stores_lat_lng_one_town => :environment do
    # url_string = URI.escape('http://maps.googleapis.com/maps/api/geocode/json?address=台中市大里區益民路一段58號&sensor=true')
    town = Town.find(ARGV[1].to_i)
    stores = town.stores
    begin
      stores.each do |store|
        if store.lng && store.lat
          next
        else
          store_address = store.address.to_s
          url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor=true"
          url_string = URI.escape(url)
          url = URI.parse(url_string)
          req = Net::HTTP::Get.new(url.to_s)
          res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
          content = res.body
          lat = JSON.parse(content)['results'][0]['geometry']['location']['lat'].to_s
          lng = JSON.parse(content)['results'][0]['geometry']['location']['lng'].to_s
          store.lat = lat
          store.lng = lng
          store.save!
          print lat + " " + lng
        end
      end
      
      puts "此鄉鎮區的門市已儲存完成"
    rescue Exception => e
      puts "\n"
      puts "Something Wrong!"
      puts "Please Checking Program!"
    end

    # 避免執行 rake ARGV 出現錯誤
    ARGV.each { |a| task a.to_sym do ; end }
  end

  # 單一縣市門市經緯度
  # FIXME
  task :stores_lat_lng_one_county => :environment do
    # url_string = URI.escape('http://maps.googleapis.com/maps/api/geocode/json?address=台中市大里區益民路一段58號&sensor=true')
    county = County.find(ARGV[1].to_i)
    stores = county.stores
    
    begin
      stores.each do |store|
        if store.lng && store.lat
          next
        else
          store_address = store.address.to_s
          # url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor=true"
          url_address = "http://maps.googleapis.com/maps/api/geocode/json?address=#{store_address}&sensor"
          url_string = URI.escape(url_address)
          url = URI.parse(url_string)
          req = Net::HTTP::Get.new(url.to_s)
          res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
          content = res.body
          lat = JSON.parse(content)['results'][0]['geometry']['location']['lat'].to_s
          lng = JSON.parse(content)['results'][0]['geometry']['location']['lng'].to_s
          store.lat = lat
          store.lng = lng
          store.save!
          print lat + " " + lng + " "
          # sleep(1)
        end
      end

      puts "此鄉鎮區的門市已儲存完成"
    rescue Exception => e
      puts "\n"
      puts "Something Wrong!"
      puts "Please Checking Program!"
    end

    # 避免執行 rake ARGV 出現錯誤
    ARGV.each { |a| task a.to_sym do ; end }
  end
end