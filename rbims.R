library(rbims)
library(tidyverse)

#Kofamscan

htn_mapp<-read_ko("/home/yendi/Downloads/CURSO_FILES/08.Kofamscan/02.KO_results/") %>%
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

Metadatos<-read_delim("/home/yendi/Downloads/CURSO_FILES/11.GTDBTK/Metadatos.txt", delim="\t")

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


