json.cache! variant_group do
  json.id variant_group.id
  json.name variant_group.name
  json.description variant_group.description
end

if detailed_view
  json.variants do
    json.cache_collection!(variant_group.variants, key: 'index') do |variant|
      json.partial! 'variants/variant', variant: variant, detailed_view: false
    end
  end
end
