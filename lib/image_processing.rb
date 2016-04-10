require 'base64'
image = open('/home/boyang/Dropbox/cosi166b_ban/cosi166-learncoding/app/assets/images/imdb_logo25.png') { |f| f.read }
test1 = Base64.encode64(image)
plain = Base64.decode64(test1)

puts plain
