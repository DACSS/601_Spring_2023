umasscolors<-tibble(name = c("red", "brown", "light brown", "cool gray",
                             "warm gray", "yellow", "orange", "harvest", "light green",
                             "green", "dark blue", "blue", "light blue", "dark maroon",
                             "dark brown", "black", "gray 5", "gray 4", "gray 3",
                             "gray 2", "gray 1", "tan 3", "tan 2", "tan 1"),
                    hex = c( "#881c1c", "#94795d", "#a89968", "#63666a", "#aca39a",
                             "#c69214", "#b86125", "#a8431e", "#b3b995","#76881d", "#003b5c",
                             "#5b7f95", "#71b2c9", "#5d2a2c", "#41273b", "#333333", "#666666", 
                             "#999999","#aaaaaa","#cccccc", "#eeeeee","#beb395", "#dbd3ba", "#ece9d4"))

get_umass_color<-function(color="red"){
  x<-filter(umasscolors, name=={{color}})%>%
    select(hex)
  paste(x)
}
