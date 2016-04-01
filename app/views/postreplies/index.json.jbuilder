json.array!(@postreplies) do |postreply|
  json.extract! postreply, :id
  json.url postreply_url(postreply, format: :json)
end
