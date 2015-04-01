json.cache! source do
  json.id source.id
  json.citation source.description
  json.pubmed_id source.pubmed_id
  json.source_url url_for_source(source)
end
