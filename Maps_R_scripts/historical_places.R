# José Luis Losada

#---------------------------------#
###   Historical places names   ###
###     Historical maps         ###
#---------------------------------#

# To geolocate historical places and plot a map.

# georeference the places
# install.packages("devtools")
# library(devtools)
# install_github("editio/georeference")
# see at https://github.com/editio/georeference

library(georeference)

# Run the georef function. Limit the search to Europe to improve the results.
places = georef(c("Roma", "Lutetia"), source = "geonames", inject = "username=yourusername", bounding.box = "43.7,-16.7,59.8,35.4")

# Plot the map with the tiles of the Roman Empire.

library(leaflet)

leaflet() %>%
addTiles(
    urlTemplate = "https://dh.gu.se/tiles/imperium/{z}/{x}/{y}.png", 
    attribution = 'Barrington Roman Empire: (CC BY-SA) <a href="https://dh.gu.se/dare">DARE</a>',
    group="Roman Empire",
    option=list(continuousWorld=TRUE, tileSize="256")) %>%
  
    addProviderTiles ("CartoDB.Positron", group = "Modern") %>%    
  
    addMarkers(places$lon, places$lat, label=places$searched_name) %>%
    
# Add the menu layers
    
addLayersControl(
    baseGroups = c("Modern","Roman Empire"),
    options = layersControlOptions(collapsed = F))
