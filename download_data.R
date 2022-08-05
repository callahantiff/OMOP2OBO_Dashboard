

core_url = 'https://zenodo.org/record/6949688/files/OMOP2OBO_'
cond_data_hpo = rio::import(paste(core_url, 'V1_Condition_Occurrence_Mapping_Oct2020.xlsx?download=1', sep=''),
                            sheet='OMOP2OBO_HPO_Mapping_Results')
cond_data_mondo = rio::import(paste(core_url, 'V1_Condition_Occurrence_Mapping_Oct2020.xlsx?download=1', sep=''),
                              sheet='OMOP2OBO_Mondo_Mapping_Results')
# combine sheets into one dataframe
cond_data_hpo <- cbind(ONTOLOGY = "HPO", cond_data_hpo)
cond_data_mondo <- cbind(ONTOLOGY = "MONDO", cond_data_mondo)
cond_data <- rbind(cond_data_hpo, cond_data_mondo)
cond_data <- cbind(cond_data[,1:10], cond_data[,16:20])

arrow::write_parquet(cond_data, file.path("data", "cond_data.parquet"))

# drug data
core_url = 'https://zenodo.org/record/6949696/files/OMOP2OBO_'
drug_data_chebi = rio::import(paste(core_url, 'V1_Drug_Exposure_Mapping_Oct2020.xlsx?download=1', sep=''),
                              sheet='OMOP2OBO_ChEBI_Mapping_Results')
drug_data_pro = rio::import(paste(core_url, 'V1_Drug_Exposure_Mapping_Oct2020.xlsx?download=1', sep=''),
                            sheet='OMOP2OBO_PRO_Mapping_Results')
drug_data_vo = rio::import(paste(core_url, 'V1_Drug_Exposure_Mapping_Oct2020.xlsx?download=1', sep=''),
                           sheet='OMOP2OBO_VO_Mapping_Results')
drug_data_ncbi = rio::import(paste(core_url, 'V1_Drug_Exposure_Mapping_Oct2020.xlsx?download=1', sep=''),
                             sheet='OMOP2OBO_NCBITa_Mapping_Results')
# combine sheets into one dataframe
drug_data_chebi <- cbind(ONTOLOGY = "CHEBI", drug_data_chebi)
drug_data_pro <- cbind(ONTOLOGY = "PRO", drug_data_pro)
drug_data_vo <- cbind(ONTOLOGY = "VO", drug_data_vo)
drug_data_ncbi <- cbind(ONTOLOGY = "NCBITaxon", drug_data_ncbi)
drug_data <- rbind(drug_data_chebi, drug_data_pro, drug_data_vo, drug_data_ncbi)

arrow::write_parquet(drug_data, file.path("data", "drug_data.parquet"))

# measurement data
core_url = 'https://zenodo.org/record/6949858/files/OMOP2OBO_'
lab_data_hpo = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                           sheet='OMOP2OBO_HPO_Mapping_Results')
lab_data_uberon = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                              sheet='OMOP2OBO_UBERON_Mapping_Results')
lab_data_chebi = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                             sheet='OMOP2OBO_ChEBI_Mapping_Results')
lab_data_cl = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                          sheet='OMOP2OBO_CL_Mapping_Results')
lab_data_pro = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                           sheet='OMOP2OBO_PRO_Mapping_Results')
lab_data_ncbi = rio::import(paste(core_url, 'V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1', sep=''),
                            sheet='OMOP2OBO_NCBITa_Mapping_Results')

# combine sheets into one dataframe
lab_data_hpo <- cbind(ONTOLOGY = "HPO", lab_data_hpo)
lab_data_uberon <- cbind(ONTOLOGY = "UBERON", lab_data_uberon)
lab_data_chebi <- cbind(ONTOLOGY = "CHEBI", lab_data_chebi)
lab_data_cl <- cbind(ONTOLOGY = "CL", lab_data_cl)
lab_data_pro <- cbind(ONTOLOGY = "PRO", lab_data_pro)
lab_data_ncbi <- cbind(ONTOLOGY = "NCBITaxon", lab_data_ncbi)
lab_data <- rbind(lab_data_hpo, lab_data_uberon, lab_data_chebi, lab_data_cl,
                  lab_data_pro, lab_data_ncbi)

arrow::write_parquet(lab_data, file.path("data", "lab_data.parquet"))
