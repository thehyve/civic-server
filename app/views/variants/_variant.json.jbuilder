json.cache! [variant, variant.gene] do
  json.id variant.id
  json.entrez_name variant.gene.name
  json.entrez_id variant.gene.entrez_id
  json.name variant.name
  json.description variant.description
end

if variant.errors.any?
  json.errors variant.errors.to_hash
end

if detailed_view
  json.last_modified json.partial!('shared/last_modified', object: variant)
  json.variant_groups do
    json.cache_collection!(variant.variant_groups, key: 'index') do |variant_group|
      json.partial! 'variant_groups/variant_group', variant_group: variant_group, detailed_view: false
    end
  end
  json.variants do
    json.cache_collection!(variant.evidence_items, key: 'index') do |evidence_item|
      json.partial! 'evidence_items/evidence_item', evidence_item: evidence_item, detailed_view: false
    end
  end
end
