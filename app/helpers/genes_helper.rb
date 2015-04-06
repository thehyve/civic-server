module GenesHelper
  def resource_links(gene)
    [
      {
        rel: 'self',
        href: gene_url(gene.entrez_id)
      },
      {
        rel: 'index',
        href: genes_url
      },
      {
        rel: 'variants',
        href: gene_variants_url(gene.entrez_id)
      },
      {
        rel: 'variant_groups',
        href: gene_variant_groups_url(gene.entrez_id)
      },
      {
        rel: 'revisions',
        href: gene_revisions_url(gene.entrez_id)
      },
      {
        rel: 'comments',
        href: gene_comments_url(gene.entrez_id)
      },
      {
        rel: 'suggested_changes',
        href: gene_suggested_changes_url(gene.entrez_id)
      }
    ]
  end
end
