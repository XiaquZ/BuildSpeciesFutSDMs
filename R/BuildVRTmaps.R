Build_VRT <- function(tile_paths) {
  species_names <- basename(tile_paths)

  for (species in species_names) {
    t.list <- list.files(
      species_tiles[grepl(species, basename(species_tiles))],
      full.names = T
    )
    r <- vrt(t.list)
    r <- round(r, digits = 1)
    print(species)
    print(r)
    
    fout <- paste0(
      "D:/Output/fut_SDMs/species_final/",
      species, "_predictedSDMs_2071-2100_ssp370_25m.tif"
    )
    writeRaster(r, fout, overwrite = TRUE)
  }
}
