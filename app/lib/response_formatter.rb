class ResponseFormatter
  def initialize(url)
    @url = url
  end

  def from_item(item)
    {
      data: ActiveModelSerializers::SerializableResource.new(item).serializable_hash,
      metadata: single_item_metadata(item)
    }
  end

  def from_collection(collection)
    {
      items: collection.map{|item| from_item(item)},
      metadata: collection_metadata(collection)
    }
  end

  private
  attr_accessor :url

  def single_item_metadata(item)
    { type: item.class.name.downcase }
  end

  def collection_metadata(collection)
    {
      type: "collection",
      count: collection.count,
      links: prepare_links(collection)
    }
  end

  def prepare_links(collection)
    { self: self_link(collection) }
  end

  def self_link(collection)
    self_link = url.split("?")[0]
    if collection.respond_to?(:current_page)
      page = collection.current_page
      per_page = collection.per_page
      self_link += "?page=#{page}&per_page=#{per_page}"
    end
    self_link
  end
end
