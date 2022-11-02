library(rbims)
library(tidyverse)

#Kofamscan

htn_mapp<-read_ko("08.Kofamscan/02.KO_results/") %>%
  mapping_ko()

Overview<-c("Central Metabolism", "Carbon Fixation", 
            "Nitrogen Metabolism", "Sulfur Metabolism", "Fermentation", 
            "Methane Metabolism")

Energy_metabolisms_htn<-htn_mapp %>%
  drop_na(Cycle) %>%
  get_subset_pathway(rbims_pathway, Overview) 

plot_bubble(tibble_ko = Energy_metabolisms_htn,
            x_axis = Bin_name, 
            y_axis = Pathway_cycle,
            analysis="KEGG",
            calc="Percentage",
            range_size = c(1,10),
            y_labs=FALSE,
            x_labs=FALSE) 

Metadatos<-read_delim("11.GTDBTK/Metadatos.txt", delim="\t")

plot_bubble(tibble_ko = Energy_metabolisms_htn,
            x_axis = Bin_name, 
            y_axis = Pathway_cycle,
            analysis="KEGG",
            data_experiment = Metadatos,
            calc="Percentage",
            color_character = Class,
            range_size = c(1,10),
            y_labs=FALSE,
            x_labs=FALSE) 

Secretion_system_htn<-htn_mapp %>%
  drop_na(Cycle) %>%
  get_subset_pathway(Cycle, "Secretion system")

plot_heatmap(tibble_ko=Secretion_system_htn, 
             y_axis=Genes,
             analysis = "KEGG",
             calc="Binary")

plot_heatmap(tibble_ko=Secretion_system_htn, 
             y_axis=Genes,
             data_experiment = Metadatos,
             order_x = Phylum,
             analysis = "KEGG",
             calc="Binary")

plot_heatmap(tibble_ko=Secretion_system_htn, 
             y_axis=Genes,
             data_experiment = Metadatos,
             order_y = Pathway_cycle,
             order_x = Phylum,
             analysis = "KEGG",
             calc="Binary")


#Interpro
library(rbims)
library(tidyverse)
interpro_Interpro_profile<-read_interpro(
  data_interpro = "09.Interpro/01.Proteomas/htn_interpro.tsv", 
  database="INTERPRO", profile = T) %>%
  filter(!str_detect(INTERPRO, "-"))


important_INTERPRO<-get_subset_pca(tibble_rbims=interpro_Interpro_profile, 
                                   cos2_val=0.95,
                                   analysis="INTERPRO")

plot_heatmap(important_INTERPRO, y_axis=INTERPRO, analysis = "INTERPRO", distance = T)

plot_heatmap(important_INTERPRO, y_axis=INTERPRO, analysis = "INTERPRO", distance = F)
