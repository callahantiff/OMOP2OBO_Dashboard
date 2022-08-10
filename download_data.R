###############################################################################
## R Script: download xlsx files from Zenodo and save formatted data locally ##
###############################################################################
library(arrow)
library(rio)


# define global function
process_data = function(ont_list, df_file) {
  ont_len = length(ont_list)
  df_list = vector("list", ont_len)
  
  for (x1 in ont_list) {
    i = match(x1, ont_list)
    if (x1 == "NCBITa") {x2 = "NCBITaxon"} else {x2 = toupper(x1)}
    progress = paste(round((i/ont_len)*100), "%", sep="")
    print(paste(progress, ' - Downloading: ', x2, sep=""))
    
    # set sheet name, download data, add ont column, and add it to df list
    sheet_name = paste("OMOP2OBO_", x1, "_Mapping_Results", sep="")
    df = rio::import(df_file, sheet=sheet_name)
    df_list[[i]] = cbind(ONTOLOGY = x2, df)
  }
  # concatenate data
  data = do.call("rbind", df_list)
}


################################# CONDIITONS #################################
cat("\n\n\n")
symb = paste(replicate(25, "*"), collapse = "")
print(paste(symb, "Downloading Condition Concept Mapping Data", symb))

# download condition concept mappings
# set variables
cond_id = "6949688"
core_url = paste("https://zenodo.org/record/", cond_id, "/files/OMOP2OBO_", sep="")
cond_file = paste(core_url, "V1_Condition_Occurrence_Mapping_Oct2020.xlsx?download=1", sep="")
cond_onts = c("HPO", "Mondo")

# download data files by sheet
cond_data = process_data(cond_onts, cond_file)
cond_data = cbind(cond_data[,1:2], cond_data[,4:5], cond_data[,16:20])
cond_data = cond_data[,c(1, 2, 4, 3, 5, 6, 7, 8, 9)]

# save data locally
file_path = file.path("data", "cond_data.parquet")
print(paste('Saving Data to: ', file_path))
arrow::write_parquet(cond_data, file_path)


############################## DRUG INGREDIENTS ##############################
cat("\n\n\n")
print(paste(symb, "Downloading Drug Ingredient Concept Mapping Data", symb))

# download drug ingredient mappings
# set variables
drug_id = "6949696"
core_url = paste("https://zenodo.org/record/", drug_id, "/files/OMOP2OBO_", sep="")
drug_file = paste(core_url, "V1_Drug_Exposure_Mapping_Oct2020.xlsx?download=1", sep="")
drug_onts = c("ChEBI", "PRO", "VO", "NCBITa")

# download data files by sheet
drug_data = process_data(drug_onts, drug_file)

# save data locally
file_path = file.path("data", "drug_data.parquet")
print(paste('Saving Data to: ', file_path))
arrow::write_parquet(drug_data, file_path)


################################# MEASUREMENTS #################################
cat("\n\n\n")
print(paste(symb, "Downloading Measurement Concept Mapping Data", symb))

# download measurement mappings
# set variables
lab_id = "6949858"
core_url = paste("https://zenodo.org/record/", lab_id, "/files/OMOP2OBO_", sep="")
lab_file = paste(core_url, "V1_Measurement_Mapping_LOINC2HPO_Oct2020.xlsx?download=1", sep="")
lab_onts = c("HPO", "UBERON", "ChEBI", "CL", "PRO", "NCBITa")

# download data files by sheet
lab_data = process_data(lab_onts, lab_file)

# save data locally
file_path = file.path("data", "lab_data.parquet")
print(paste('Saving Data to: ', file_path))
arrow::write_parquet(lab_data, file_path)
