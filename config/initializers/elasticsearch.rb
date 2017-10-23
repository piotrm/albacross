config = {
  host: "http://localhost:9202",
  transport_options: {
    request: { timeout: 5 }
  }
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)