module Importer; module Illumina
  class Mappings

    #illumina molecularEffect column to civic evidence direction and clin sig
    #molecularEffect	Evidence Direction	Clinical Significance
    def self.molecular_effect(x)
      effect_keywords = {
        'Improved response'     => ['Supports', 'Sensitivity'],
        'Reduced response'      => ['Supports', 'Resistance or Non-Response'],
        'Growth arrest'         => ['Supports', 'Sensitivity'],
        'Increased resistance'  => ['Supports', 'Resistance or Non-Response'],
        'Increase response'     => ['Supports', 'Sensitivity'],
        'Intermediate response' => [nil, nil],
        'Reduced survival'      => ['Supports', 'Resistance or Non-Response']
      }

      effect_keywords.each do |illiumina_term, (evidence_dir, clin_sig)|
        words = illiumina_term.split(' ').map(&:downcase)
        if words.all? { |word| word.in?(x.downcase) }
          return [evidence_dir, clin_sig]
        end
      end
      return [nil, nil]
    end

    #civic: evidence type, illumina: deAssociationClassId (illumina type, civic type)
    def self.association_class_id(x)
      {
        '1' => ['Prognostic' ,'Prognostic'],
        '2' => ['Predictive', 'Predictive'],
        '3' => ['Molecular classification', 'Diagnostic'],
        '4' => ['Mendelian','Predisposing'],
        '5' => ['Pharmacogenetics', 'Predictive'],
      }[x.to_s]
    end

    def self.evidence_level_from_clinical_effect(x)
      {
        'CLINICAL' => 'B',
        'BIOLOGICAL' => nil,
        'EXPERIMENTAL' => 'D',
        'CLINICAL TRIAL' => 'B',
        'FUNCTIONAL' => nil,
        'COMPANION TEST' => nil,
        'CASE REPORT' => 'C',
        'CASE SERIES' => 'C',
        'CASE STUDY' => 'C',
      }[x.to_s.upcase.split('-').first.strip]
    end

    #illumina term in variantType or variantclassification to SO
    def self.illumina_type_to_sequence_ontology(x)
      {
        '5 prime UTR'                          => ['5_prime_UTR_variant', 'SO:1623'],
        'Coding sequence'                      => ['coding_sequence_variant', 'SO:1580'],
        'Downstream gene'                      => ['downstream_gene_variant', 'SO:1632'],
        'Frameshift'                           => ['frameshift_variant', 'SO:1589'],
        'Gain of stop codon'                   => ['stop_gained', 'SO:1587'],
        'Inframe deletion'                     => ['inframe_deletion', 'SO:1822'],
        'Inframe insertion'                    => ['inframe_insertion', 'SO:1821'],
        'Initiator codon'                      => ['initiator_codon_variant', 'SO:1582'],
        'Intergenic'                           => ['intergenic_variant', 'SO:1628'],
        'Intronic'                             => ['intron_variant', 'SO:1627'],
        'Loss of stop codon'                   => ['stop_lost', 'SO:1578'],
        'Major coding region deletion'         => [nil, nil],
        'Missense'                             => ['missense_variant', 'SO:1583'],
        'Multibase coding region substitution' => [nil, nil],
        'Non-coding transcript'                => ['non_coding_transcript_variant', 'SO:1619'],
        'Splice acceptor'                      => ['splice_acceptor_variant', 'SO:1574'],
        'Splice donor'                         => ['splice_donor_variant', 'SO:1575'],
        'Splice region'                        => ['splice_region_variant', 'SO:1630'],
        'Synonymous'                           => ['synonymous_variant', 'SO:1819'],
        'Upstream gene'                        => ['upstream_gene_variant', 'SO:1631'],
        'Deletion'                             => ['deletion', 'SO:159'],
        'Indel'                                => ['indel', 'SO:1000032'],
        'Insertion'                            => ['insertion', 'SO:667'],
        'Single Point'                         => ['point_mutation', 'SO:1000008'],
        'Single point'                         => ['point_mutation', 'SO:1000008']
      }[x.to_s]
    end

    #illumina term to our internal name/doid
    def self.illumina_disease_names_to_doid(x)
      {
        'colorectal cancer'                                             => ['Colorectal Cancer', '9256'],
        'malignant melanoma'                                            => ['Melanoma', '1909'],
        'acute myeloid leukemia'                                        => ['Acute Myeloid Leukemia', '9119'],
        'non-small cell lung cancer'                                    => ['Non-small Cell Lung Carcinoma', '3908'],
        'malignant melanoma of skin'                                    => ['Skin Melanoma', '8923'],
        'thyroid cancer'                                                => ['Thyroid Cancer', '1781'],
        'solid tumor'                                                   => ['', ''],
        'rectal cancer'                                                 => ['Rectum Cancer', '1993'],
        'multiple myeloma'                                              => ['Multiple Myeloma', '9583'],
        'hepatocellular carcinoma'                                      => ['Hepatocellular Carcinoma', '684'],
        'small cell carcinoma of lung'                                  => ['Lung Small Cell Carcinoma', '5409'],
        'cancer of thymus'                                              => ['Thymus Cancer', '3277'],
        'sarcoma'                                                       => ['Sarcoma', '1115'],
        'testicular cancer'                                             => ['Testicular Cancer', '2998'],
        'prostate cancer'                                               => ['Prostate Cancer', '10283'],
        'pancreatic cancer'                                             => ['Pancreatic Cancer', '1793'],
        'ovarian cancer'                                                => ['Ovarian Cancer', '2394'],
        'osteosarcoma of bone'                                          => ['Bone Osteosarcoma', '3376'],
        'neuroendocrine tumor'                                          => ['Neuroendocrine Tumor', '169'],
        'mesothelioma (malignant, clinical disorder)'                   => ['Malignant Mesothelioma', '1790'],
        'liver cancer'                                                  => ['Liver Cancer', '3571'],
        'kidney cancer'                                                 => ['Kidney Cancer', '263'],
        'head and neck cancer'                                          => ['Head And Neck Cancer', '11934'],
        'gastrointestinal stromal tumor'                                => ['Gastrointestinal Stromal Tumor', '9253'],
        'gastric cancer'                                                => ['Stomach Carcinoma', '5517'],
        'esophageal cancer'                                             => ['Esophageal Cancer', '5041'],
        'endometrial cancer'                                            => ['Endometrial Cancer', '1380'],
        'cervical cancer'                                               => ['Cervical Cancer', '4362'],
        'cancer of urinary tract'                                       => ['Urinary System Cancer', '3996'],
        'cancer of salivary gland'                                      => ['Salivary Gland Cancer', '8850'],
        'cancer of peritoneum'                                          => ['Peritoneum Cancer', '1725'],
        'cancer of penis'                                               => ['Penis Cancer', '11615'],
        'cancer of biliary tract'                                       => ['Biliary Tract Cancer', '4607'],
        'breast cancer'                                                 => ['Breast Cancer', '1612'],
        'bladder cancer'                                                => ['Urinary Bladder Cancer', '11054'],
        'adrenal cancer'                                                => ['Adrenal Gland Cancer', '3953'],
        'adenocarcinoma of small intestine'                             => ['Small Intestine Adenocarcinoma', '4906'],
        'colon cancer'                                                  => ['Colon Cancer', '219'],
        'medullary thyroid carcinoma'                                   => ['Thyroid Medullary Carcinoma', '3973'],
        'adenocarcinoma of lung'                                        => ['Lung Adenocarcinoma', '3910'],
        'large cell carcinoma of lung'                                  => ['Lung Large Cell Carcinoma', '4556'],
        'pituitary carcinoma'                                           => ['Pituitary Carcinoma', '4916'],
        'glioma'                                                        => ['Malignant Glioma', '3070'],
        'glioblastoma multiforme'                                       => ['Glioblastoma Multiforme', '3068'],
        'medulloblastoma'                                               => ['Medulloblastoma', '50902'],
        'acute lymphoid leukemia'                                       => ['Acute Lymphocytic Leukemia', '9952'],
        'acute monocytic leukemia'                                      => ['Acute Monocytic Leukemia', '8864'],
        'chronic lymphocytic leukemia'                                  => ['Chronic Lymphocytic Leukemia', '1040'],
        'chronic myeloid leukemia'                                      => ['Chronic Myeloid Leukemia', '8552'],
        'hairy cell leukemia'                                           => ['Hairy Cell Leukemia', '285'],
        'hodgkin\'s lymphoma'                                           => ['Hodgkin\'s Lymphoma', '8567'],
        'non-hodgkin\'s lymphoma'                                       => ['Non-Hodgkin Lymphoma', '60060'],
        'lung cancer'                                                   => ['Lung Cancer', '1324'],
        'squamous cell carcinoma of oral mucous membrane'               => ['Oral Squamous Cell Carcinoma', '50866'],
        'squamous cell carcinoma of skin'                               => ['Skin Squamous Cell Carcinoma', '3151'],
        'adenocarcinoma of rectum'                                      => ['Rectum Adenocarcinoma', '1996'],
        'squamous cell carcinoma of lung'                               => ['Lung Squamous Cell Carcinoma', '3907'],
        'myelodysplastic syndrome'                                      => ['Myelodysplastic Syndrome', '50908'],
        'head and neck squamous cell carcinoma'                         => ['Head And Neck Squamous Cell Carcinoma', '5520'],
        'lymphoma'                                                      => ['Lymphoma', '60058'],
        'glioblastoma multiforme of brain'                              => ['Brain Glioblastoma Multiforme', '3073'],
        'intracranial glioma'                                           => ['Brain Glioma', '60108'],
        'hematologic cancer'                                            => ['Hematologic Cancer', '2531'],
        'intrahepatic bile duct carcinoma'                              => ['Intrahepatic Cholangiocarcinoma', '4928'],
        'retinal hemangioblastomatosis'                                 => ['Retinal Hemangioblastoma', '5240'],
        'primary malignant clear cell tumor of ovary'                   => ['Ovarian Clear Cell Carcinoma', '50934'],
        'transitional cell carcinoma of bladder'                        => ['Bladder Urothelial Carcinoma', '4006'],
        'squamous cell carcinoma of esophagus'                          => ['Esophagus Squamous Cell Carcinoma', '3748'],
        'basal cell carcinoma of skin'                                  => ['Basal Cell Carcinoma', '2513'],
        'germ cell tumor of ovary'                                      => ['Ovarian Germ Cell Cancer', '2156'],
        'anaplastic thyroid carcinoma'                                  => ['Anaplastic Thyroid Carcinoma', '7012'],
        'follicular thyroid carcinoma'                                  => ['Follicular Thyroid Carcinoma', '3962'],
        'langerhans cell histiocytosis'                                 => ['Langerhans-cell Histiocytosis', '2571'],
        'papillary thyroid carcinoma'                                   => ['Papillary Thyroid Carcinoma', '3969'],
        'biliary tract cancer'                                          => ['Biliary Tract Cancer', '4607'],
        'gastrointestinal stroma tumor'                                 => ['Gastrointestinal Stromal Tumor', '9253'],
        'non-seminomatous malignant neoplasm of testis'                 => ['Testicular Non-seminomatous Germ Cell Cancer', '5345'],
        'small intestine adenocarcinoma'                                => ['Small Intestine Adenocarcinoma', '4906'],
        'pilocytic astrocytoma'                                         => ['Pilocytic Astrocytoma', '4851'],
        'ganglioglioma'                                                 => ['Ganglioglioma', '5078'],
        'malignant melanoma of soft tissues'                            => ['Clear Cell Sarcoma', '4233'],
        'carcinoma of thyroid'                                          => ['Thyroid Carcinoma', '3963'],
        'sarcoma of soft tissue'                                        => ['Sarcoma', '1115'],
        'cholangiocarcinoma of biliary tract'                           => ['Cholangiocarcinoma', '4947'],
        'pleomorphic xanthoastrocytoma'                                 => ['Pleomorphic Xanthoastrocytoma', '4852'],
        'anaplastic pleomorphic xanthoastrocytoma'                      => ['Pleomorphic Xanthoastrocytoma', '4852'],
        'serous papillary cystadenocarcinoma of ovary'                  => ['Ovarian Cystadenocarcinoma', '3605'],
        'malignant peripheral nerve sheath tumor'                       => ['Malignant Peripheral Nerve Sheath Tumor', '5940'],
        'histiocytic sarcoma'                                           => ['Histiocytoma', '4231'],
        'adenosquamous cell carcinoma'                                  => ['Adenosquamous Carcinoma', '4830'],
        'squamous cell carcinoma'                                       => ['Squamous Cell Carcinoma', '1749'],
        'b-cell chronic lymphocytic leukemia'                           => ['Chronic Lymphocytic Leukemia', '1040'],
        'chronic lymphoid leukemia'                                     => ['Chronic Lymphocytic Leukemia', '1040'],
        't-cell acute lymphoblastic leukemia'                           => ['Acute T Cell Leukemia', '5603'],
        'squamous cell carcinoma of head and neck'                      => ['Head And Neck Squamous Cell Carcinoma', '5520'],
        'juvenile myelomonocytic leukemia'                              => ['Juvenile Myelomonocytic Leukemia', '50458'],
        'adenoma of liver'                                              => ['Liver Cancer', '3571'],
        'malignant tumor of exocrine pancreas'                          => ['Tumor Of Exocrine Pancreas', '1795'],
        'adenocarcinoma of pancreas'                                    => ['Pancreatic Adenocarcinoma', '4074'],
        'neoplasm of pancreas'                                          => ['Pancreatic Cancer', '1793'],
        'small cell lung cancer'                                        => ['Lung Small Cell Carcinoma', '5409'],
        'carcinoma in situ of skin'                                     => ['Skin Carcinoma In Situ', '8687'],
        'carcinoma of colon'                                            => ['Colon Carcinoma', '1520'],
        'clear cell carcinoma of kidney'                                => ['Renal Clear Cell Carcinoma', '4467'],
        'burkitt\'s lymphoma'                                           => ['Burkitt Lymphoma', '8584'],
        'carcinoma of breast'                                           => ['Breast Carcinoma', '3459'],
        'atypical chronic myeloid leukemia'                             => ['Atypical Chronic Myeloid Leukemia', '60597'],
        'adenocarcinoma of cervix'                                      => ['Cervical Adenocarcinoma', '3702'],
        'uveal melanoma'                                                => ['Uveal Melanoma', '6039'],
        'neuroblastoma'                                                 => ['Neuroblastoma', '769'],
        'granulosa cell tumor of ovary'                                 => ['Ovarian Granulosa Cell Tumor', '2999'],
        'chronic myelomonocytic leukemia'                               => ['Chronic Myelomonocytic Leukemia', 'null'],
        'idiopathic hypereosinophilic syndrome'                         => ['Hypereosinophilic Syndrome', 'null'],
        'adenosquamous carcinoma of cervix'                             => ['Cervical Adenosquamous Carcinoma', '5636'],
        'adenoid cystic carcinoma of salivary gland'                    => ['Salivary Gland Adenoid Cystic Carcinoma', '4866'],
        'acral lentiginous malignant melanoma of skin'                  => ['Acral Lentiginous Melanoma', '6367'],
        'malignant melanoma of vulva'                                   => ['Vulvar Melanoma', '2093'],
        'mucosal melanoma'                                              => ['Mucosal Melanoma', '50929'],
        'chronic eosinophilic leukemia'                                 => ['Chronic Eosinophilic Leukemia', 'null'],
        'dysgerminoma of ovary'                                         => ['Dysgerminoma Of Ovary', '5511'],
        'testicular germ cell tumor'                                    => ['Testicular Germ Cell Cancer', '5557'],
        'systemic mast cell disease'                                    => ['Systemic Mastocytosis', '349'],
        'philadelphia chromosome positive chronic myelogenous leukemia' => ['Chronic Myeloid Leukemia', '8552'],
        'polycythemia vera'                                             => ['Polycythemia Vera', '8997'],
        'essential thrombocythemia'                                     => ['Essential Thrombocythemia', '2224'],
        'liver cell carcinoma'                                          => ['Liver Carcinoma', '686'],
        'hepatoblastoma'                                                => ['Hepatoblastoma', '687'],
        'gallbladder cancer'                                            => ['Gallbladder Carcinoma', '4948'],
        'desmoid fibromatosis'                                          => ['Sarcoma', '1115'],
        'extra-abdominal fibromatosis'                                  => ['Sarcoma', '1115'],
        'gallbladder carcinoma'                                         => ['Gallbladder Carcinoma', '4948'],
        'nephroblastoma'                                                => ['Nephroblastoma', '2154'],
        'renal cell carcinoma'                                          => ['Renal Cell Carcinoma', '4450'],
        'metastatic malignant melanoma'                                 => ['Skin Melanoma', '8923'],
        'mantle cell lymphoma'                                          => ['Mantle Cell Lymphoma', '50476'],
        'acute myelomonocytic leukemia, fab m4'                         => ['Acute Myeloid Leukemia', '9119'],
        'squamous cell carcinoma of oropharynx'                         => ['Oral Squamous Cell Carcinoma', '50866'],
        'myelodysplastic/myeloproliferative disease'                    => ['Myelodysplastic/myeloproliferative Neoplasm', '4972'],
        'urticaria pigmentosa'                                          => ['Urticaria Pigmentosa', '12309'],
        'adrenal carcinoma'                                             => ['Adrenal Carcinoma', '3950'],
        'diffuse large b-cell lymphoma'                                 => ['Diffuse Large B-cell Lymphoma', '50745'],
        'marginal zone lymphoma'                                        => ['Marginal Zone B-cell Lymphoma', '50748'],
        'small malignant lymphotic lymphoma'                            => ['CLL/SLL', '6354'],
        'large granular lymphocytic leukemia'                           => ['T-cell Large Granular Lymphocyte Leukemia', '50751'],
        'adult t-cell leukemia/lymphoma'                                => ['Adult T-cell Leukemia', '50523'],
        'glioblastomas'                                                 => ['Glioblastoma Multiforme', '3068'],
        'lymphoplasmacytic malignant lymphoma'                          => ['Lymphoplasmacytic Lymphoma', '50747'],
        'acute myeloid leukemia in remission'                           => ['Acute Myeloid Leukemia', '9119'],
        'follicular non-hodgkin\'s lymphoma'                            => ['Follicular Lymphoma', '50873'],
        'malignant granulosa cell tumor of ovary'                       => ['Ovarian Granulosa Cell Tumor', '2999'],
        'angiosarcoma'                                                  => ['Angiosarcoma', '1816'],
        'large cell anaplastic lymphoma'                                => ['Anaplastic Large Cell Lymphoma', '50744'],
        'clear cell carcinoma of ovary'                                 => ['Ovarian Clear Cell Carcinoma', '50934'],
        'extranodal NK/T-cell lymphoma, nasal type'                     => ['Mature T-cell and NK-cell Lymphoma', '0050743'],
        'malignant melanoma of conjunctiva'                             => ['Malignant Conjunctival Melanoma', '1751'],
        'squamous cell carcinoma of thymus'                             => ['Thymus Squamous Cell Carcinoma', '5530']
      }[x.to_s.downcase]
    end
  end
end; end