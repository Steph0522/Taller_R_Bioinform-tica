library(tidyverse)
GTDBK<-read.table("/home/yendi/Downloads/CURSO_FILES/11.GTDBTK/gtdbtk.bac120.summary.tsv", 
                  sep = "\t", header = T, 
            na.strings ="", stringsAsFactors= F)%>%as_tibble() #%>% 
 # select(user_genome, classification) %>%  separate(classification, c("Domain", "Phylum", "Class", "Order",
#                             "Family", "Genus", "Species"), sep= ";") %>%
  #rename(Bin_name=user_genome)  %>%  unite(Bin_name_2, c("Bin_name", "Phylum"), remove = FALSE) %>%
  #select(Bin_name, Domain, Phylum, Class, Order, Family, Genus, Species)

htn_gtdbtk<-GTDBK %>%
  select(user_genome, classification) %>%
  separate(classification, c("Domain", "Phylum", "Class", "Order",
                             "Family", "Genus", "Species"), sep= ";") %>%
  rename(Bin_name=user_genome)  %>%
  unite(Bin_name_2, c("Bin_name", "Phylum"), remove = FALSE) %>%
  select(Bin_name, Domain, Phylum, Class, Order, Family, Genus, 
         Species)

#metadatos
write.table(htn_gtdbtk, file = "/home/yendi/Downloads/CURSO_FILES/11.GTDBTK/Metadatos.txt", sep="\t", quote = F,
            row.names = F, col.names = T)

#generar plot
GTDBtk<-htn_gtdbtk %>%
  count(Domain,Class) %>%
  rename(Number_of_MAGs = n) %>%
  ggplot(aes(x = Domain, 
             y = Number_of_MAGs, fill = Class)) + 
  geom_bar(stat = "identity", position=position_dodge())+
  theme_minimal()
GTDBtk
library(plotly)
GTDBtk_p_fig <- ggplotly(GTDBtk)
GTDBtk_p_fig
