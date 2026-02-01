# Graphing details, generic
deets<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_blank(), #element_rect(fill=NA)
        
        axis.line = element_line(size=.5),
        axis.ticks = element_line(size=.5),
        axis.title = element_text(size=rel(1.3),colour="black", lineheight=1), #face="bold", 
        axis.text = element_text(size=rel(1.5), lineheight=.8,  colour="black"),#, face="bold"),
        axis.title.y=element_text(vjust=1,lineheight=.8, size=rel(1.5)),
        axis.title.x=element_text(vjust=.5, size=rel(1.5)), 
        plot.title = element_text(size=rel(2),hjust = 0.5),
        legend.title=element_text(size=rel(1.5)),
        legend.text=element_text(size=rel(1.3)),
        legend.position=c(.2,.25),
        legend.background = element_rect(fill="transparent", colour = NA))

#############################
deets2<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        axis.title = element_text(size=rel(1.2),colour="black", lineheight=.8), 
        axis.text = element_text(size=rel(1), lineheight=.8,  colour="black"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        legend.title=element_text(size=rel(1.5)),
        legend.text=element_text(size=rel(1.1)),
        legend.position=c(.8,.25),
        legend.background = element_rect(fill="transparent", colour = NA),
        strip.text.y = element_text(size = rel(1.3)))

#############################
deets3<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        
        # axis.line = element_line(size=.5),
        # axis.ticks = element_line(size=.5),
        axis.title = element_text(size=rel(1.5),colour="black", lineheight=.8), #, face="bold"
        axis.text = element_text(size=rel(1.3), lineheight=.8,  colour="black"),#, face="bold"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        
        legend.title=element_text(size=rel(1.5)),
        legend.text=element_text(size=rel(1.3)),
        # legend.position=c(.8,.25),
        legend.background = element_rect(fill="transparent", colour = NA),
        strip.text.y = element_text(size = rel(1.3)))

#############################
deets4<-theme_bw() + # No legend
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        
        # axis.line = element_line(size=.5),
        # axis.ticks = element_line(size=.5),
        axis.title = element_text(size=rel(1.5),colour="black", lineheight=.8), #, face="bold"
        axis.text = element_text(size=rel(1.3), lineheight=.8,  colour="black"),#, face="bold"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        
        legend.title=element_text(size=rel(1.5)),
        legend.text=element_text(size=rel(1.3)),
        legend.position="none",
        legend.background = element_rect(fill="transparent", colour = NA),
        strip.text.y = element_text(size = rel(1.3)))

#############################
# slightly bigger text
deets5<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        # axis.line = element_line(size=.5),
        # axis.ticks = element_line(size=.5),
        axis.title = element_text(size=rel(1.3),colour="black", lineheight=.8), 
        axis.text = element_text(size=rel(1.2), lineheight=.8,  colour="black"),#, face="bold"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        
        legend.title=element_text(size=rel(1.2)),
        legend.text=element_text(size=rel(1.1)),
        # legend.position=c(.8,.25),
        legend.background = element_rect(colour='white'),
        strip.text = element_text(size=rel(1.3)))

#deets 5, internal legend
deets6<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.grid.major=element_blank(),
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        
        # axis.line = element_line(size=.5),
        # axis.ticks = element_line(size=.5),
        axis.title = element_text(size=rel(1.3),colour="black", lineheight=.8), #, face="bold"
        axis.text = element_text(size=rel(1.2), lineheight=.8,  colour="black"),#, face="bold"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        
        legend.title=element_text(size=rel(1.3)),
        legend.text=element_text(size=rel(1.2)),
        legend.position=c(.15,.17),
        legend.background = element_rect(fill="transparent", colour = NA),
        strip.text.y = element_text(size = rel(1.3)))


deets7<-theme_bw() + #
  theme(panel.grid.minor=element_blank(), 
        panel.background=element_rect(fill=NA),
        panel.border=element_rect(fill=NA),
        axis.title = element_text(size=rel(1.2),colour="black", lineheight=.8), 
        axis.text = element_text(size=rel(1), lineheight=.8,  colour="black"),
        axis.title.y=element_text(vjust=1,lineheight=.8),
        axis.title.x=element_text(vjust=.5), 
        legend.title=element_text(size=rel(1.3)),
        legend.text=element_text(size=rel(1.2)),
        legend.position=c(.84,.3),
        legend.background = element_rect(fill="transparent", colour = NA))
