json.cache_collection! @genes, key: 'index' do |gene|
  json.partial! 'genes/gene', gene: gene, detailed_view: false
end
