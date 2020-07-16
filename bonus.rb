require "uri"
require "net/http"
require 'json'


def request(address)

url = URI(address)

https = Net::HTTP.new(url.host, url.port);
https.use_ssl = true

request = Net::HTTP::Get.new(url)

response = https.request(request)

JSON.parse response.read_body
end

hash_resultados = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=TjnnHaVZy702voK5eFhMRidCvsnLLsABPzK7SJRV")


#Bonus:

def photos_count (hash_resultados)

images = hash_resultados["photos"]

arr_camera = []
images.select do |x|
    arr_camera << x["camera"]
end

arr_cam_name = []
arr_camera.select do |x|
    arr_cam_name << x["name"]
end

grouped = arr_cam_name.group_by {|x|x}

count_prueba_bonus = grouped.each do |k,v|
    grouped[k] = v.count
end

print count_prueba_bonus
end

photos_count(hash_resultados)

