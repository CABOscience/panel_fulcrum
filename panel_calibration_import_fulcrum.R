# Script to import panel calibration data

library(googlesheets)
library(googledrive)
library(dplyr)

# Panel C7101904
gs_auth()
panel_C7101904 <- gs_title("c7101904_specchioformat.csv")
panel_C7101904_data <- gs_read(panel_C7101904, ws = 'c7101904_specchioformat.csv') %>%
  rename(wavelength_nm = wvl,
         reflectance = c7101904) %>%
  mutate(fulcrum_parent_id = '74fc0e98-5a56-459d-90fd-8caf4fa62f24')


# Panel 99AA02-0318-9711
drive_download('SRS-99-010-99AA02-0318-9711.txt')
panel_99AA0203189711_data <- read.table('SRS-99-010-99AA02-0318-9711.txt') %>%
  rename(wavelength_nm = V1,
         reflectance = V2) %>%
  mutate(fulcrum_parent_id = '4d55d943-afbf-4298-9ca7-0776ccfe4bef')

# Panel 99AA02-0318-9170
drive_download('SRS-99-010-99AA02-0318-9710.txt')
panel_99AA0203189170_data <- read.table('SRS-99-010-99AA02-0318-9710.txt') %>%
  rename(wavelength_nm = V1,
         reflectance = V2) %>%
  mutate(fulcrum_parent_id = '21f63abb-fdc0-4510-8645-6a318273c25e')


# Panel 99AA02-0318-9172
drive_download('SRS-99-010-99AA02-0318-9712.txt')
panel_99AA0203189172_data <- read.table('SRS-99-010-99AA02-0318-9712.txt') %>%
  rename(wavelength_nm = V1,
         reflectance = V2) %>%
  mutate(fulcrum_parent_id = '1dff9c1b-c46d-49d2-be39-18f4fd795a49')


# bind data frames
panels <- bind_rows(panel_C7101904_data,
                    panel_99AA0203189711_data,
                    panel_99AA0203189170_data,
                    panel_99AA0203189172_data )
# check leves
unique(panels$fulcrum_parent_id) # 4 Fulcrum parent ID

# save csv
write.csv(panels, file = 'spectroscopy_panels/spectroscopy_panels_calibrations_calibrated_reflectance_UPDATED.csv', quote = F,
          row.names = F)
zip('spectroscopy_panels.zip', 'spectroscopy_panels')
