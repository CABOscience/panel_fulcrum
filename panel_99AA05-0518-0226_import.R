# Panel 99AA05-0518-0226

library(googlesheets)
library(googledrive)
library(dplyr)

gs_auth()


drive_download('SRS-99-010-99AA05-0518-0226.txt')
panel_99AA0505180226_data <- read.table('SRS-99-010-99AA05-0518-0226.txt') %>%
  rename(wavelength_nm = V1,
         reflectance = V2) %>%
  mutate(fulcrum_record_id = 'e9f4b3ef-aefd-4feb-aba6-7de289eba3f2',
         fulcrum_parent_id = 'c360927c-c62e-4796-a0aa-52547fa86e6e',
         fulcrum_id = NA)
panel_99AA0505180226_data$fulcrum_id[1] <- 'dad315f8-460b-402c-8dda-aac45f3f2ee4'

# save csv
write.csv(panel_99AA0505180226_data, file = 'spectroscopy_panels-4/spectroscopy_panels_calibrations_calibrated_reflectance_UPDATED.csv', quote = F,
          row.names = F)
zip('spectroscopy_panels-4.zip', 'spectroscopy_panels-4')
