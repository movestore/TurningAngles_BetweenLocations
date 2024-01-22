library('move2')
library("ggplot2")
library("sf")
library("units")
library("lwgeom")

rFunction <-  function(data, setunits){
  
  if(!st_crs(data)[[1]]=="EPSG:4326"){
    dataLL <- st_transform(data,crs="EPSG:4326")
  }
  if(st_crs(data)[[1]]=="EPSG:4326"){
    dataLL <- data
  }
  
  dataLL$turnAngle <- mt_turnangle(dataLL, units=setunits)
  if(setunits=="rad"){
    setbreaks <- c(-pi,-(pi/2),0,(pi/2),pi)
    setlim <- c(-pi,pi)
    setlabels <- round(c(-pi,-(pi/2),0,(pi/2),pi),2)
  }
  if(setunits=="degrees"){
    setbreaks <- c(-180,-(180/2),0,(180/2),180)
    setlim <- c(-180,180)
    setlabels <- c(-180,-(180/2),0,(180/2),180)
  }
  
  if(length(levels(as.factor(mt_track_id(dataLL))))==1){
    dataDF <- data.frame(turnAngle=drop_units(dataLL$turnAngle),indv=unique(mt_track_id(dataLL)))
    turnAngleHist <- ggplot(dataDF, aes(turnAngle))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Turning angle (rad)", breaks=setbreaks, labels=setlabels, limits=setlim)
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "turnAngle_histogram.pdf"))
    print(turnAngleHist)
    dev.off()
  }else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "turnAngle_histogram.pdf"))
    turnAngleHistAll <- ggplot(dataLL, aes(drop_units(turnAngle)))+
      geom_histogram(bins=100)+ ggtitle("All Individuals") +theme_bw()+ 
      scale_x_continuous("Turning angle (rad)", breaks=setbreaks, labels=setlabels, limits=setlim)
    print(turnAngleHistAll)
    lapply(split(dataLL, mt_track_id(dataLL)), function(x){
      dataDF <- data.frame(turnAngle=drop_units(x$turnAngle), indv=unique(mt_track_id(x))) 
      turnAngleHist <- ggplot(dataDF, aes(turnAngle))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Turning angle (rad)", breaks=setbreaks, labels=setlabels, limits=setlim)
      print(turnAngleHist)
    })
    dev.off() 
  }
  data$turnAngle <- dataLL$turnAngle
  return(data)
}
