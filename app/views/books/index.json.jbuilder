json.array!(@books) do |book|
  json.extract! book, :id, :title, :ISBN, :author, :publish_date, :description
  json.url book_url(book, format: :json)
end
