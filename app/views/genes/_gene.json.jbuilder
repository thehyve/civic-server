json.cache! gene do
  json.id gene.id
  json.entrez_name gene.name
  json.entrez_id gene.entrez_id
  json.description gene.description
end

json.variant_groups do
  json.cache_collection! gene.variant_groups, key: 'index' do |variant_group|
    json.partial! 'variant_groups/variant_group', variant_group: variant_group, detailed_view: false
  end
end

json.variants do
  json.cache_collection!(gene.variants, key: 'index') do |variant|
    json.partial! 'variants/variant', variant: variant, detailed_view: false
  end
end

if gene.errors.any?
  json.errors gene.errors.to_hash
end

if detailed_view
  json.sources do
    json.cache_collection!(gene.sources, key: 'index') do |source|
      json.partial! 'sources/source', source: source
    end
  end
  json.last_modified json.partial!('shared/last_modified', object: gene)
end
