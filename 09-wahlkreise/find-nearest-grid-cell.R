library(sf)
library(dplyr)
library(readr)
library(here)

shp_wk <- st_read(here("data", "Wahlkreise", "btw25_geometrie_wahlkreise_shp_geo",
                       "btw25_geometrie_wahlkreise_shp_geo.shp"))


shp_centroids_wk <- st_centroid(shp_wk)

# Create a grid covering the bounding box
grid_sf <- st_make_grid(shp_wk, cellsize = 0.25, square = TRUE) |> 
  st_sf() |> 
  st_filter(shp_wk) |> 
  mutate(cell_id = row_number())

# Find the closest grid cell for each centroid
nearest_grid <- function(centroids, grid_sf) {
  assignments <- data.frame()
  
  for (i in seq_len(nrow(centroids))) {
    centroid <- centroids[i, ]
    
    # Compute distances to grid cells
    dists <- st_distance(centroid, grid_sf)
    # Rank grid cells by distance
    grid_sf$dist <- as.vector(dists)
    sorted_grid <- grid_sf |> arrange(dist)
    
    # Find the first available grid cell
    for (j in seq_len(nrow(sorted_grid))) {
      chosen_cell <- sorted_grid[j, ]
      cell_id <- chosen_cell$cell_id
      
      if (!(cell_id %in% assignments$cell_id)) {
        assignments <- rbind(assignments, data.frame(
          centroid_id = i,
          cell_id = cell_id,
          geometry = st_geometry(chosen_cell)
        ))
        break  # Stop after assigning a grid cell
      }
    }
  }
  
  return(st_as_sf(assignments, crs = st_crs(shp_centroids_wk)))
}

grid_wk <- nearest_grid(shp_centroids_wk, grid_sf)
write_rds(grid_wk, here("data", "Wahlkreise", "grid-wk.rds"))
