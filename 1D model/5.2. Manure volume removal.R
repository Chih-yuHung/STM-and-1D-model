#manure depth adjustment
#daily changing depth of manure for next day, L32<-L37
M.depth <- M.depth + depthchange.d
Zmmax <- M.depth    
print(M.depth)
for (removal.cycle in 1:length(removal.depth)) {
  if (Output$`Date ID`[i] %in% removal.duration[[removal.cycle]]) {
  removal.depth.d <- (M.depth - removal.depth[removal.cycle])/removal.day[removal.cycle]    
  cat(paste("manure removal date =",i))
  M.depth <- M.depth - removal.depth.d + depthchange.d
  Zmmax <- M.depth
  break
  } 
}


