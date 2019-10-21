
library(readxl)
library(stringr)
library(dplyr)
library(tidyr)
library(xlsx)
library(rJava)
library(xlsxjars)


#setwd("C:/Users/Travis Grogan/Dropbox/Sportsbetting/Sportbetting/Seasons/18.19") #pc
setwd("~/Dropbox/Sportsbetting/Sportbetting/Seasons/18.19") #mac 
df.master <- read_excel('All.leagues.team.list.20180822.with.accents.xlsx')



df.full.schedule <- read_excel("All.teams.full.schedule.column.xlsx")

df.full.schedule$Date <- as.Date(df.full.schedule$Date)
df.schedule.trim <- df.full.schedule[(df.full.schedule$Date > Sys.Date()-90) & (df.full.schedule$Date < (Sys.Date())),]
df.schedule.trim$changehome <- 0
df.schedule.trim$changeaway <- 0

# homogenises the spelling of the df.schedule.trim list
j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.schedule.trim)) {
        if (df.master[i,j] == df.schedule.trim[p,q]){
          df.schedule.trim[p,q] <- df.master[i,(j-1)]
          if (q == 1){
            df.schedule.trim[p,"changehome"] <- df.schedule.trim[p,"changehome"] + 1
          } else {
            df.schedule.trim[p,"changeaway"] <- df.schedule.trim[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}


#creating a 2*2 dataframe with sites and their numbers.
v.sites <- c("df.365","df.blacktype", "df.ladbrokes", "df.beteasy", "df.sportsbet","df.ubet","df.neds","df.unibet")
v.numbers <- c(1:8)
df.sites <- data.frame(v.sites, v.numbers, stringsAsFactors = FALSE)
colnames(df.sites) <- c("Site","Number")


# # 365 raw data column arrange, synchronised spelling, and alphabetised
# #need to set working directory here
df <- read_excel('Outputs/20180819/365.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)
#df <- df %>% separate("Teams", c("HomeTeam", "AwayTeam"), ' v ')
colnames(df) <- c("HomeTeam365", "AwayTeam365","HomeP365", "DrawP365","AwayP365",  "URL")
df$URL <- NULL

df <- na.omit(df)
df.365 <- df

df.365$changehome <- 0
df.365$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.365)) {
        # if (grepl(df.master[i,j], df.365[p,q]) == T){
        if (df.master[i,j] == df.365[p,q]){
          df.365[p,q] <- df.master[i,(j-1)]
          df.365[p,"league"] <- colnames(df.master[i,(j-1)])
          if (q == 1){
            df.365[p,"changehome"] <- df.365[p,"changehome"] + 1
          } else {
            df.365[p,"changeaway"] <- df.365[p,"changeaway"] + 1
          }
          
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}


#
# # blacktype raw data column arrange, synchronised spelling, and alphabetised
# # need to set working directory here
# df <- read_excel("Outputs/20180819/blacktype.xlsx")
# df <- df %>% separate("Home $", c("FirstNum", "SecondNum"), '/')
# df <- na.omit(df)
# df$FirstNum <- as.numeric(df$FirstNum)
# df$SecondNum <- as.numeric(df$SecondNum)
# df$`Home $` <- df$FirstNum/df$SecondNum + 1
#
# df <- df %>% separate("Draw $", c("FirstNum1", "SecondNum1"), '/')
# df <- na.omit(df)
# df$FirstNum1 <- as.numeric(df$FirstNum1)
# df$SecondNum1 <- as.numeric(df$SecondNum1)
# df$`Draw $` <- df$FirstNum1/df$SecondNum1 + 1
#
# df <- df %>% separate("Away $", c("FirstNum2", "SecondNum2"), '/')
# df <- na.omit(df)
# df$FirstNum2 <- as.numeric(df$FirstNum2)
# df$SecondNum2 <- as.numeric(df$SecondNum2)
# df$`Away $` <- df$FirstNum2/df$SecondNum2 + 1
#
#
#
# df$`Away $` <- as.numeric(df$`Away $`)
# df$`Draw $` <- as.numeric(df$`Draw $`)
# df$`Home $` <- as.numeric(df$`Home $`)
#
# df$URL <- NULL
# df$FirstNum <- NULL
# df$SecondNum <- NULL
# df$FirstNum1 <- NULL
# df$SecondNum1 <- NULL
# df$FirstNum2 <- NULL
# df$SecondNum2 <- NULL
#
# colnames(df) <- c("HomeTeamblacktype", "AwayTeamblacktype","HomePblacktype", "DrawPblacktype", "AwayPblacktype")
#
#
# df <- na.omit(df)
# df.blacktype <- df
# df.blacktype$changehome <- 0
# df.blacktype$changeaway <- 0
#
# j <- 2
# while (j <= ncol(df.master)) {
#   for (i in 1:nrow(df.master)) {
#     q <- 1
#     while (q <= 2) {
#       for (p in 1:nrow(df.blacktype)) {
#         if (df.master[i,j] == df.blacktype[p,q]){
#           df.blacktype[p,q] <- df.master[i,(j-1)]
#           df.blacktype[p,"league"] <- colnames(df.master[i,(j-1)])
#           if (q == 1){
#             df.blacktype[p,"changehome"] <- df.blacktype[p,"changehome"] + 1
#           } else {
#             df.blacktype[p,"changeaway"] <- df.blacktype[p,"changeaway"] + 1
#           }
#         }
#       }
#       q <- q+1
#     }
#   }
#   j <- j+2
# }



# beteasy raw data column arrange, synchronised spelling, and
# need to set working directory here

df <- read_excel('Outputs/20180819/ladbrokes.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)

colnames(df) <- c("HomeTeamladbrokes", "AwayTeamladbrokes","HomePladbrokes", "DrawPladbrokes","AwayPladbrokes",  "URL")
df$URL <- NULL

df <- na.omit(df)
df.ladbrokes <- df
df.ladbrokes$changehome <- 0
df.ladbrokes$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.ladbrokes)) {
        if (df.master[i,j] == df.ladbrokes[p,q]){
          df.ladbrokes[p,q] <- df.master[i,(j-1)]
          df.ladbrokes[p,"league"] <- colnames(df.master[i,(j-1)])
          
          if (q == 1){
            df.ladbrokes[p,"changehome"] <- df.ladbrokes[p,"changehome"] + 1
          } else {
            df.ladbrokes[p,"changeaway"] <- df.ladbrokes[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}


# ladbrokes raw data column arrange, synchronised spelling, and alphabetised
# need to set working directory here
df <- read_excel('Outputs/20180819/sportsbet.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)

colnames(df) <- c("HomeTeamsportsbet", "AwayTeamsportsbet","HomePsportsbet", "DrawPsportsbet","AwayPsportsbet",  "URL")
df$URL <- NULL

df <- na.omit(df)
df.sportsbet <- df
df.sportsbet$changehome <- 0
df.sportsbet$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.sportsbet)) {
        if (df.master[i,j] == df.sportsbet[p,q]){
          df.sportsbet[p,q] <- df.master[i,(j-1)]
          df.sportsbet[p,"league"] <- colnames(df.master[i,(j-1)])
          if (q == 1){
            df.sportsbet[p,"changehome"] <- df.sportsbet[p,"changehome"] + 1
          } else {
            df.sportsbet[p,"changeaway"] <- df.sportsbet[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}


df <- read_excel('Outputs/20180819/unibet.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)

colnames(df) <- c("HomeTeamunibet", "AwayTeamunibet","HomePunibet", "DrawPunibet","AwayPunibet",  "URL")
df$URL <- NULL
df <- na.omit(df)
df.unibet <- df
df.unibet$changehome <- 0
df.unibet$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.unibet)) {
        if (df.master[i,j] == df.unibet[p,q]){
          df.unibet[p,q] <- df.master[i,(j-1)]
          df.unibet[p,"league"] <- colnames(df.master[i,(j-1)])
          if (q == 1){
            df.unibet[p,"changehome"] <- df.unibet[p,"changehome"] + 1
          } else {
            df.unibet[p,"changeaway"] <- df.unibet[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}

df <- read_excel('Outputs/20180819/beteasy.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)

colnames(df) <- c("HomeTeambeteasy", "AwayTeambeteasy","HomePbeteasy", "DrawPbeteasy","AwayPbeteasy",  "URL")
df$URL <- NULL

df <- na.omit(df)
df.beteasy <- df
df.beteasy$changehome <- 0
df.beteasy$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.beteasy)) {
        if (df.master[i,j] == df.beteasy[p,q]){
          df.beteasy[p,q] <- df.master[i,(j-1)]
          df.beteasy[p,"league"] <- colnames(df.master[i,(j-1)])
          
          if (q == 1){
            df.beteasy[p,"changehome"] <- df.beteasy[p,"changehome"] + 1
          } else {
            df.beteasy[p,"changeaway"] <- df.beteasy[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}

df <- read_excel('Outputs/20180819/ubet.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)

colnames(df) <- c("HomeTeamubet", "AwayTeamubet","HomePubet", "DrawPubet","AwayPubet",  "URL")
df$URL <- NULL

df <- na.omit(df)
df.ubet <- df
df.ubet$changehome <- 0
df.ubet$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.ubet)) {
        if (df.master[i,j] == df.ubet[p,q]){
          df.ubet[p,q] <- df.master[i,(j-1)]
          df.ubet[p,"league"] <- colnames(df.master[i,(j-1)])
          
          if (q == 1){
            df.ubet[p,"changehome"] <- df.ubet[p,"changehome"] + 1
          } else {
            df.ubet[p,"changeaway"] <- df.ubet[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}


df <- read_excel('Outputs/20180819/neds.xlsx')

df$`Away $` <- as.numeric(df$`Away $`)
df$`Draw $` <- as.numeric(df$`Draw $`)
df$`Home $` <- as.numeric(df$`Home $`)
colnames(df) <- c("HomeTeamneds", "AwayTeamneds","HomePneds", "AwayPneds","DrawPneds",  "URL")
df$URL <- NULL

df <- na.omit(df)
df$HomeTeamneds <- tolower(df$HomeTeamneds)
df$AwayTeamneds <- tolower(df$AwayTeamneds)
df$HomeTeamneds <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", df$HomeTeamneds, perl=TRUE)
df$AwayTeamneds <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", df$AwayTeamneds, perl=TRUE)


df.neds <- df
df.neds$changehome <- 0
df.neds$changeaway <- 0

j <- 2
while (j <= ncol(df.master)) {
  for (i in 1:nrow(df.master)) {
    q <- 1
    while (q <= 2) {
      for (p in 1:nrow(df.neds)) {
        if (df.master[i,j] == df.neds[p,q]){
          df.neds[p,q] <- df.master[i,(j-1)]
          df.neds[p,"league"] <- colnames(df.master[i,(j-1)])
          
          if (q == 1){
            df.neds[p,"changehome"] <- df.neds[p,"changehome"] + 1
          } else {
            df.neds[p,"changeaway"] <- df.neds[p,"changeaway"] + 1
          }
        }
      }
      q <- q+1
    }
  }
  j <- j+2
}

currentDate <- Sys.Date()
xlsxFileName <- paste(currentDate,".stats.xlsx",sep="")
write.xlsx(df.schedule.trim, file=xlsxFileName, sheetName = 'df.schedule.trim')
write.xlsx(df.365, file=xlsxFileName, sheetName = 'df.365', append = T)
# write.xlsx(df.blacktype, file=xlsxFileName, sheetName = 'df.blacktype', append = T)
write.xlsx(df.ladbrokes, file=xlsxFileName, sheetName = 'df.ladbrokes', append = T)
write.xlsx(df.ubet, file=xlsxFileName, sheetName = 'df.ubet', append = T)
write.xlsx(df.unibet, file=xlsxFileName, sheetName = 'df.unibet', append = T)
write.xlsx(df.beteasy, file=xlsxFileName, sheetName = 'df.beteasy', append = T)
write.xlsx(df.sportsbet, file=xlsxFileName, sheetName = 'df.sportsbet', append = T)
write.xlsx(df.neds, file=xlsxFileName, sheetName = 'df.neds', append = T)
# 
df.schedule.trim$changehome <- NULL
df.neds$changehome <- NULL
df.365$changehome <- NULL
#df.blacktype$changehome <- NULL
df.ladbrokes$changehome <- NULL
df.ubet$changehome <- NULL
df.unibet$changehome <- NULL
df.beteasy$changehome <- NULL
df.sportsbet$changehome <- NULL
df.schedule.trim$changeaway <- NULL
df.neds$changeaway <- NULL
df.365$changeaway <- NULL
#df.blacktype$changeaway <- NULL
df.ladbrokes$changeaway <- NULL
df.ubet$changeaway <- NULL
df.unibet$changeaway <- NULL
df.beteasy$changeaway <- NULL
df.sportsbet$changeaway <- NULL
# 
# 
# 
# 





df.all.sites.all.prices <- df.schedule.trim

#searching df.schedule.trim by df.365 and if found, places odds next to them

df.365$ConversionStat <- 0
x <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.365)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.365[p,q]) && (df.schedule.trim[i,(j+1)] == df.365[p,(q+1)])){
      x <- x+1
      print (x)
      df.all.sites.all.prices[i,(t+1)] <- df.365[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.365[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.365[p,(q+4)]
      df.365[p,"ConversionStat"] <- 1
    }
  }
}



#searching df.schedule.trim by df.blacktype and if found, places odds next to them
# df.blacktype$ConversionStat <- 0
# t <- ncol(df.all.sites.all.prices)
# for (i in 1:nrow(df.schedule.trim)){
#   for (p in 1:nrow(df.blacktype)){
#     j <- 1
#     q <- 1
#     if ((df.schedule.trim[i,j] == df.blacktype[p,q]) && (df.schedule.trim[i,(j+1)] == df.blacktype[p,(q+1)])){
#       df.all.sites.all.prices[i,(t+1)] <- df.blacktype[p,(q+2)]
#       df.all.sites.all.prices[i,(t+2)] <- df.blacktype[p,(q+3)]
#       df.all.sites.all.prices[i,(t+3)] <- df.blacktype[p,(q+4)]
#       df.blacktype[p,"ConversionStat"] <- 1
#     }
#   }
# }

#searching df.schedule.trim by df.ladbrokes and if found, places odds next to them
df.ladbrokes$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.ladbrokes)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.ladbrokes[p,q]) && (df.schedule.trim[i,(j+1)] == df.ladbrokes[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.ladbrokes[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.ladbrokes[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.ladbrokes[p,(q+4)]
      df.ladbrokes[p,"ConversionStat"] <- 1
    }
  }
}

#searching df.schedule.trim by df.beteasy and if found, places odds next to them
df.beteasy$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.beteasy)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.beteasy[p,q]) && (df.schedule.trim[i,(j+1)] == df.beteasy[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.beteasy[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.beteasy[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.beteasy[p,(q+4)]
      df.beteasy[p,"ConversionStat"] <- 1
    }
  }
}


#searching df.schedule.trim by df.sportsbet and if found, places odds next to them
df.sportsbet$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.sportsbet)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.sportsbet[p,q]) && (df.schedule.trim[i,(j+1)] == df.sportsbet[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.sportsbet[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.sportsbet[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.sportsbet[p,(q+4)]
      df.sportsbet[p,"ConversionStat"] <- 1
    }
  }
}


#searching df.schedule.trim by df.ubet and if found, places odds next to them
df.ubet$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.ubet)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.ubet[p,q]) && (df.schedule.trim[i,(j+1)] == df.ubet[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.ubet[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.ubet[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.ubet[p,(q+4)]
      df.ubet[p,"ConversionStat"] <- 1
    }
  }
}

#searching df.schedule.trim by df.neds and if found, places odds next to them
df.neds$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.neds)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.neds[p,q]) && (df.schedule.trim[i,(j+1)] == df.neds[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.neds[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.neds[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.neds[p,(q+4)]
      df.neds[p,"ConversionStat"] <- 1
    }
  }
}


#searching df.schedule.trim by df.unibet and if found, places odds next to them
df.unibet$ConversionStat <- 0
t <- ncol(df.all.sites.all.prices)
for (i in 1:nrow(df.schedule.trim)){
  for (p in 1:nrow(df.unibet)){
    j <- 1
    q <- 1
    if ((df.schedule.trim[i,j] == df.unibet[p,q]) && (df.schedule.trim[i,(j+1)] == df.unibet[p,(q+1)])){
      df.all.sites.all.prices[i,(t+1)] <- df.unibet[p,(q+2)]
      df.all.sites.all.prices[i,(t+2)] <- df.unibet[p,(q+3)]
      df.all.sites.all.prices[i,(t+3)] <- df.unibet[p,(q+4)]
      df.unibet[p,"ConversionStat"] <- 1
    }
  }
}

df.matches.paired <- df.sites
df.matches.paired$Conversions <- "NA"
df.matches.paired$numbermatched <- "NA"
df.matches.paired$totalscraped <- "NA"




df.matches.paired[1,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomeP365))) / nrow(df.365)
#df.matches.paired[2,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePblacktype))) / nrow(df.blacktype)
df.matches.paired[3,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePladbrokes))) / nrow(df.ladbrokes)
df.matches.paired[4,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePbeteasy))) / nrow(df.beteasy)
df.matches.paired[5,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePsportsbet))) / nrow(df.sportsbet)
df.matches.paired[6,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePubet))) / nrow(df.ubet)
df.matches.paired[7,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePneds))) / nrow(df.neds)
df.matches.paired[8,3] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePunibet))) / nrow(df.unibet)

df.matches.paired[1,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomeP365)))
#df.matches.paired[2,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePblacktype)))
df.matches.paired[3,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePladbrokes)))
df.matches.paired[4,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePbeteasy)))
df.matches.paired[5,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePsportsbet)))
df.matches.paired[6,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePubet)))
df.matches.paired[7,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePneds)))
df.matches.paired[8,4] <- ((nrow(df.all.sites.all.prices)) - sum(is.na(df.all.sites.all.prices$HomePunibet)))

df.matches.paired[1,5] <- nrow(df.365)
#df.matches.paired[2,5] <- nrow(df.blacktype)
df.matches.paired[3,5] <- nrow(df.ladbrokes)
df.matches.paired[4,5] <- nrow(df.beteasy)
df.matches.paired[5,5] <- nrow(df.sportsbet)
df.matches.paired[6,5] <- nrow(df.ubet)
df.matches.paired[7,5] <- nrow(df.neds)
df.matches.paired[8,5] <- nrow(df.unibet)


currentDate <- Sys.Date()
xlsxFileName <- paste(currentDate,"conversion.stats.xlsx",sep=".")
write.xlsx(df.matches.paired, file=xlsxFileName, sheetName = 'df.matches.paired')
write.xlsx(df.365, file=xlsxFileName, sheetName = 'df.365', append = T)
#write.xlsx(df.blacktype, file=xlsxFileName, sheetName = 'df.blacktype', append = T)
write.xlsx(df.ladbrokes, file=xlsxFileName, sheetName = 'df.ladbrokes', append = T)
write.xlsx(df.ubet, file=xlsxFileName, sheetName = 'df.ubet', append = T)
write.xlsx(df.unibet, file=xlsxFileName, sheetName = 'df.unibet', append = T)
write.xlsx(df.beteasy, file=xlsxFileName, sheetName = 'df.beteasy', append = T)
write.xlsx(df.sportsbet, file=xlsxFileName, sheetName = 'df.sportsbet', append = T)
write.xlsx(df.neds, file=xlsxFileName, sheetName = 'df.neds', append = T)


df.365$ConversionStat <- NULL
#df.blacktype$ConversionStat <- NULL
df.unibet$ConversionStat <- NULL
df.ubet$ConversionStat <- NULL
df.sportsbet$ConversionStat <- NULL
df.ladbrokes$ConversionStat <- NULL
df.beteasy$ConversionStat <- NULL
df.neds$ConversionStat <- NULL






df.final.stats <- data.frame(df.schedule.trim$"Home Team")
df.final.stats$"AwayTeam" <- df.schedule.trim$"Away Team"
df.final.stats$Date <- df.schedule.trim$Date
df.final.stats$HomeCount <- NA
df.final.stats$DrawCount <- NA
df.final.stats$AwayCount <- NA
df.final.stats$HomeAve <- NA
df.final.stats$DrawAve <- NA
df.final.stats$AwayAve <- NA
df.final.stats$HomeMP <- NA
df.final.stats$DrawMP <- NA
df.final.stats$AwayMP <- NA
df.final.stats$HomeProb <- NA
df.final.stats$DrawProb <- NA
df.final.stats$AwayProb <- NA
df.final.stats$TotalProb <- NA
df.final.stats$HomeRaw <- NA
df.final.stats$DrawRaw <- NA
df.final.stats$AwayRaw <- NA



colnames(df.final.stats) <- c("HomeTeam","AwayTeam","Date","HomeCount","HomeAve","DrawCount","DrawAve","AwayCount","AwayAve","HomeMP","DrawMP","AwayMP", "HomeProb" ,"DrawProb", "AwayProb", "TotalProb", "HomeRaw", "DrawRaw", "AwayRaw")

home.cell.count <- function(i){
  x <- 0
  for (j in seq(from=4, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      x <- x+1
    }
  }
  return(x)
}

draw.cell.count <- function(i){
  x <- 0
  for (j in seq(from=5, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      x <- x+1
    }
  }
  return(x)
}

away.cell.count <- function(i){
  x <- 0
  for (j in seq(from=6, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      x <- x+1
    }
  }
  return(x)
}

home.ave <- function(i){
  y <- 0
  for (j in seq(from=4, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      y <- y + df.all.sites.all.prices[i,j]
    }
  }
  return(y/(home.cell.count(i)))
  
}

draw.ave <- function(i){
  y <- 0
  for (j in seq(from=5, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      y <- y + df.all.sites.all.prices[i,j]
    }
  }
  return(y/(draw.cell.count(i)))
  
}
away.ave <- function(i){
  y <- 0
  for (j in seq(from=6, to=(ncol(df.all.sites.all.prices)), by=3)){
    if (is.na(df.all.sites.all.prices[i,j]) == F){
      y <- y + df.all.sites.all.prices[i,j]
    }
  }
  return(y/(away.cell.count(i)))
  
}

home.mp <- function(i){
  x <- 100/(home.ave(i))
  return(x)
}

draw.mp <- function(i){
  x <- 100/(draw.ave(i))
  return(x)
}

away.mp <- function(i){
  x <- 100/(away.ave(i))
  return(x)
}

home.prob <- function(i){
  x <- home.mp(i)/(home.mp(i)+draw.mp(i)+away.mp(i))
}

draw.prob <- function(i){
  x <- draw.mp(i)/(home.mp(i)+draw.mp(i)+away.mp(i))
}

away.prob <- function(i){
  x <- away.mp(i)/(home.mp(i)+draw.mp(i)+away.mp(i))
}

total.prob <- function(i){
  x <- (home.prob(i) + draw.prob(i) + away.prob(i))
}

home.raw <- function(i){
  x <- 1/(home.prob(i))
}

draw.raw <- function(i){
  x <- 1/(draw.prob(i))
}

away.raw <- function(i){
  x <- 1/(away.prob(i))
}


for (i in 1:nrow(df.all.sites.all.prices)){
  df.final.stats[i,"HomeCount"] <- home.cell.count(i)
  df.final.stats[i,"HomeAve"] <- home.ave(i)
  df.final.stats[i,"DrawCount"] <- draw.cell.count(i)
  df.final.stats[i,"DrawAve"] <- draw.ave(i)
  df.final.stats[i,"AwayCount"] <- away.cell.count(i)
  df.final.stats[i,"AwayAve"] <- away.ave(i)
  df.final.stats[i,"HomeMP"] <- home.mp(i)
  df.final.stats[i,"DrawMP"] <- draw.mp(i)
  df.final.stats[i,"AwayMP"] <- away.mp(i)
  df.final.stats[i,"HomeProb"] <- home.prob(i)
  df.final.stats[i,"DrawProb"] <- draw.prob(i)
  df.final.stats[i,"AwayProb"] <- away.prob(i)
  df.final.stats[i,"TotalProb"] <- total.prob(i)
  df.final.stats[i,"HomeRaw"] <- home.raw(i)
  df.final.stats[i,"DrawRaw"] <- draw.raw(i)
  df.final.stats[i,"AwayRaw"] <- away.raw(i)
}



df.all.sites.all.prices[is.na(df.all.sites.all.prices)] <- 0
df.final.stats[is.na(df.final.stats)] <- 0


df.optimal.bets <- data.frame(df.schedule.trim$"Home Team")
df.optimal.bets$"AwayTeam" <- df.schedule.trim$"Away Team"
df.optimal.bets$Date <- df.schedule.trim$Date
df.optimal.bets$League <- NA
df.optimal.bets$Bet <- NA
df.optimal.bets$Site <- NA
df.optimal.bets$Price <- NA
df.optimal.bets$Raw <- NA
df.optimal.bets$PercentGain <- NA
df.optimal.bets$HomeCount <- NA

colnames(df.optimal.bets) <- c("HomeTeam", "AwayTeam", "Date", "League", "Bet", "Site", "Price", "Raw", "PercentGain", "HomeCount")


optimal.bets.row <- 1
for (i in 1:nrow(df.all.sites.all.prices)){  #for all rows
  
  for (j in 4:ncol(df.all.sites.all.prices)){  #for all columns starting at the first site column
    if ((j %% 3) == 1){      #is it home, draw or away. Home = 1, draw = 2, away = 0
      if (is.na(df.all.sites.all.prices[i,j]) ==  F){ # only enter if it is not a NA)
        if ((df.all.sites.all.prices[i,j]) > (1.05*df.final.stats[i,"HomeRaw"])){ #is it greater than 5% on top of the raw
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 5
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){  # adds the league name to the optimal bet. - next 4 lines.
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.04*df.final.stats[i,"HomeRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 4
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i, "HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          
        } else if ((df.all.sites.all.prices[i,j]) > (1.03*df.final.stats[i,"HomeRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 3
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.02*df.final.stats[i,"HomeRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 2
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"HomeRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 1
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"HomeRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"HomeRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 0
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 1)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        }
      }
    } else if ((j %% 3) == 2){
      if (is.na(df.all.sites.all.prices[i,j]) ==  F){
        if ((df.all.sites.all.prices[i,j]) > (1.05*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 5
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.04*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 4
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.03*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 3
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.02*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 2
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 1
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"DrawRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- "Draw"
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"DrawRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 0
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 2)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        }
      }
    } else if ((j %% 3) == 0){
      if (is.na(df.all.sites.all.prices[i,j]) ==  F){
        if ((df.all.sites.all.prices[i,j]) > (1.05*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 5
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.04*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 4
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.03*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 3
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.02*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 2
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 1
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        } else if ((df.all.sites.all.prices[i,j]) > (1.01*df.final.stats[i,"AwayRaw"])){
          df.optimal.bets[ optimal.bets.row,"Bet"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"HomeTeam"] <- df.all.sites.all.prices[i,"Home Team"]
          df.optimal.bets[ optimal.bets.row,"AwayTeam"] <- df.all.sites.all.prices[i,"Away Team"]
          df.optimal.bets[ optimal.bets.row,"Date"] <- df.all.sites.all.prices[i,"Date"]
          df.optimal.bets[ optimal.bets.row, "Price"] <- df.all.sites.all.prices[i,j]
          df.optimal.bets[ optimal.bets.row, "Raw"] <- df.final.stats[i,"AwayRaw"]
          df.optimal.bets[ optimal.bets.row, "PercentGain"] <- 0
          df.optimal.bets[ optimal.bets.row, "HomeCount"] <- df.final.stats[i,"HomeCount"]
          for (k in 1:nrow(df.sites)){ #locating which site it is that has the bet.
            if (((j - 3)/3) == df.sites[k,"Number"]){
              df.optimal.bets[ optimal.bets.row,"Site"] <- df.sites[k,"Site"]
            }
          }
          for (n in seq(from=2, to=(ncol(df.master)), by=2)){
            for(m in 1:nrow(df.master)){
              if (grepl(df.master[m,n], df.optimal.bets[ optimal.bets.row,"HomeTeam"]) == T){
                df.optimal.bets[ optimal.bets.row,"League"] <- colnames(df.master)[n-1]
              }
            }
          }
          optimal.bets.row <- optimal.bets.row + 1
        }
      }
    }
  }
}
df.optimal.bets <- na.omit(df.optimal.bets)
df.optimal.bets <- df.optimal.bets[(df.optimal.bets$HomeCount > 4),]
# 
# print ("done")
# 
# # df.optimal.bets$Prob <- NA
# # df.optimal.bets$PotentialReturn <- NA
# # df.optimal.bets$Betamount <- NA
# # df.optimal.bets$Totalbets <- NA
# # df.optimal.bets$WonLoss <- NA
# # df.optimal.bets$ExProfitPerc <- NA
# # df.optimal.bets$TotalExProfitPerc <- NA
# # df.optimal.bets$TotalExPercProfitBet <- NA
# # df.optimal.bets$ExProfitBet <- NA
# # df.optimal.bets$TotalExProfit <- NA
# # df.optimal.bets$AveExProfitBet <- NA
# # df.optimal.bets$ActualProfitLoss <- NA
# # df.optimal.bets$TotalProfitLoss <- NA
# # df.optimal.bets$ActualProfLossDoll <- NA
# # df.optimal.bets$Bankroll <- NA
# # colnames(df.optimal.bets) <- c("HomeTeam", "AwayTeam", "Date", "League", "Bet", "Site", "Price", "Raw", "PercentGain","Prob","PotentialReturn","Betamount","Totalbets","WonLoss","ExProfitPerc","TotalExProfitPerc","TotalExPercProfitBet","ExProfitBet", "TotalExProfit","AveExProfitBet", "ActualProfitLoss","TotalProfitLoss","ActualProfLossDoll","Bankroll")
# 
# 
# # df.big.dog <- read_excel("/Users/TravisGrogan/Dropbox/Sportsbetting/Sportbetting/TheBigDog.xlsm",sheet="Bets")
# # colnames(df.big.dog) <- c("HomeTeam", "AwayTeam", "Date", "League", "Bet", "Site", "Price", "Raw", "PercentGain","Prob","PotentialReturn","Betamount","Totalbets","WonLoss","ExProfitPerc","TotalExProfitPerc","TotalExPercProfitBet","ExProfitBet", "TotalExProfit","AveExProfitBet", "ActualProfitLoss","TotalProfitLoss","ActualProfLossDoll","Bankroll")
# # df.big.dog <- rbind(df.big.dog, df.optimal.bets)
# # write.xlsx(df.big.dog,"TheBigDog.xlsm")
# 
# 
# #
currentDate <- Sys.Date()
xlsxFileName <- paste(currentDate,".xlsx",sep="")
write.xlsx(df.optimal.bets, file=xlsxFileName, sheetName = 'df.optimal.bets')
write.xlsx(df.final.stats, file=xlsxFileName, sheetName = 'df.final.stats', append = T)
write.xlsx(df.master, file=xlsxFileName, sheetName = 'df.master', append = T)
write.xlsx(df.schedule.trim, file=xlsxFileName, sheetName = 'df.schedule.trim', append = T)
write.xlsx(df.all.sites.all.prices, file=xlsxFileName, sheetName = 'df.all.sites.all.prices', append = T)
