library('move')
library("ggplot2")

rFunction <-  function(data) {
  data$turnAngle <- unlist(lapply(turnAngleGc(data), function(x) c(NA, as.vector(x), NA)))
    
    if(length(levels(trackId(data)))==1){
      dataDF <- data.frame(turnAngle=data$turnAngle,indv=namesIndiv(data))
      turnAngleHist <- ggplot(dataDF, aes(turnAngle))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Turning angle (deg)", breaks=c(-180,-90,0,90,180), labels=c("-180(S)","-90(W)","0(N)","90(E)","180(S)"), limits=c(-180,180))
      pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "turnAngle_histogram.pdf"))
      print(turnAngleHist)
      dev.off()
    } else {
    pdf(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"), "turnAngle_histogram.pdf"))
      turnAngleHistAll <- ggplot(data@data, aes(turnAngle))+geom_histogram(bins=100)+ ggtitle("All Individuals") +theme_bw()+ scale_x_continuous("Turning angle (deg)", breaks=c(-180,-90,0,90,180), limits=c(-180,180))
    print(turnAngleHistAll)
    lapply(split(data), function(x){
      dataDF <- data.frame(turnAngle=x$turnAngle, indv=namesIndiv(x)) 
      turnAngleHist <- ggplot(dataDF, aes(turnAngle))+geom_histogram(bins=100)+facet_grid(~indv)+ theme_bw()+ scale_x_continuous("Turning angle (deg)", breaks=c(-180,-90,0,90,180), limits=c(-180,180))
      print(turnAngleHist)
    })
    dev.off() 
    
  }
  return(data)
}
