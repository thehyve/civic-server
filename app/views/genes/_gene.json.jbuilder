json.cache! gene do
  json.id gene.id
  json.entrez_name gene.name
  json.entrez_id gene.entrez_id
  json.description gene.description
  json.aliases gene.gene_aliases.map(&:name)
  json.links resource_links(gene)
end
