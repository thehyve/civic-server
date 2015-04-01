json.cache! evidence_item do
  json.id evidence_item.id
  json.text evidence_item.text
  json.disease evidence_item.disease.name
  json.doid evidence_item.disease.doid
  json.source_url url_for_source(evidence_item.source)
  json.rating evidence_item.rating
  json.evidence_type evidence_item.evidence_type.evidence_type
  json.evidence_level evidence_item.evidence_level.level
  json.clinical_direction evidence_item.clinical_direction
  json.clinical_significance evidence_item.clinical_significance
  json.variant_hgvs evidence_item.variant_hgvs
  if evidence_item.variant_origin
    json.variant_origin evidence_item.variant_origin.origin
  end
  json.drugs json.cache_collection!(evidence_item.drugs) do |drug|
    json.partial! 'drugs/drug', drug: drug
  end
end

if detailed_view
  json.last_modified json.partial!('shared/last_modified', object: evidence_item)
end
