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


def build_web_page (hash_resultados)

images = hash_resultados["photos"]

images.each do |i|
    i.each do |k , v|
    output = "<html>\n<head>\n</head>\n\t<body>\n\t\t<ul>"
        if k == "img_src"
            output += "\n\t\t\t<li><img src=\"#{v}\"> </li>\n\t\t</ul>\n\t</body>\n</html>"
            File.write('index.html', output)
        end
        end
    end
end

build_web_page(hash_resultados)




