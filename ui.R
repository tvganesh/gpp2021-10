#########################################################################################################
#
# Title :  GooglyPlusPLus2021 - An interactive app to analyze T20
# Designed and developed by: Tinniam V Ganesh
# Date : 11 Oct 2021
# File: ui.R
# More details: https://gigadom.in/
#
#########################################################################################################
source("data.R")
source("definitions.R")
library(shinybusy)
library(lubridate)
library(shinythemes)
library(yorkr)
library(ggthemes)
library(plotly)
library(stringr)


shinyUI(fluidPage(theme = shinytheme("readable"),
                  ## Title and headings
                  titlePanel("GooglyPlusPlus 2021!!!"),
                  h5("GooglyPlusPlus"),

                  ## Beginning of navlistPanel
                  navlistPanel(
                      widths = c(2, 10),
                      "Match formats",
                      tabPanel("IPL T20", navbarPage("GooglyPlusPlus - Indian Premier League (IPL)",
                                                     # Batsman tab
                                                     tabsetPanel(id = "tabs",
                                                                 tabPanel("IPL batsman", value = "IPL",
                                                                          h4('Analyze IPL batsman performances'),
                                                                          sidebarPanel(
                                                                              selectInput('batsmanFuncIPL', 'Select function', batsmanFuncs),
                                                                              selectInput('batsmanIPL', 'Select batsman', IPLBatsmen,selectize=FALSE, size=14),
                                                                              uiOutput("dateRange3"),
                                                                              radioButtons("staticIntv", label = h4("Plot type"),
                                                                                           choices = c("interactive" = 2,"static" = 1 ),
                                                                                           selected = 2,inline=T)
                                                                          ),
                                                                          mainPanel(
                                                                              uiOutput('batsmanPlotIPL'),

                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )

                                                                 ),
                                                                 # Bowlers tab
                                                                 tabPanel("IPL bowlers",

                                                                          h4('Analyze IPL bowler performances'),

                                                                          sidebarPanel(
                                                                              selectInput('bowlerFuncIPL', 'Select function', bowlerFuncs),
                                                                              selectInput('bowlerIPL', 'Select IPL bowler', IPLBowlers,selectize=FALSE, size=14),
                                                                              uiOutput("dateRange4"),
                                                                              radioButtons("staticIntv1", label = h4("Plot type"),
                                                                                           choices = c("interactive" = 2,"static" = 1 ),
                                                                                           selected = 2,inline=T)


                                                                          ),
                                                                          mainPanel(
                                                                              uiOutput('bowlerPlotIPL'),
                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )

                                                                 ),
                                                                 # Analyze IPL matches
                                                                 tabPanel("IPL Match",

                                                                          h4('Analyze an IPL match'),
                                                                          sidebarPanel(
                                                                              selectInput('matchFunc', 'Select match function', matchFuncs),
                                                                              #Horizontal scrollbar
                                                                              tags$head(tags$style(type="text/css", '.myclass .shiny-bound-input{overflow-x: scroll;}')),
                                                                              tags$div(id="myclass1", class="myclass",selectInput('match', 'Select IPL match ', IPLMatches,selectize=FALSE, size=12,width='800px')),
                                                                              uiOutput("selectTeam"),
                                                                              radioButtons("plotOrTable", label = h4("Plot(static,interactive) or table"),
                                                                                           choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                           selected = 2,inline=T)

                                                                          ),
                                                                          mainPanel(
                                                                              uiOutput("plotOrPrintIPLMatch"),
                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )

                                                                 ),
                                                                 # Analyze 2 Teams IPL matches
                                                                 tabPanel("Head to head",
                                                                          h4('Head-to-head between 2 IPL teams'),
                                                                          sidebarPanel(
                                                                              selectInput('matches2TeamFunc', 'Select function', matches2TeamsFuncs),
                                                                              selectInput('match2', 'Select matches', IPLMatches2Teams,selectize=FALSE, size=13),
                                                                              uiOutput("selectTeam2"),
                                                                              uiOutput("dateRange1"),
                                                                              #dateRangeInput("dateRange1", label = h4("Date range"),
                                                                              #               start = "2016-01-01",
                                                                              #               end   = "2020-12-31"),
                                                                              radioButtons("plotOrTable1", label = h4("Plot(static,interactive) or table"),
                                                                                           choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                           selected = 2,inline=T),
                                                                              radioButtons("repType", label = h4("Report Type"),
                                                                                           choices = c("Summary" = 1, "Detailed" = 2),
                                                                                           selected = 1,inline=T)

                                                                          ),
                                                                          mainPanel(
                                                                              uiOutput("plotOrPrintIPLMatch2teams"),
                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )
                                                                 ),
                                                                 # Analyze IPL Team Overall Perf
                                                                 tabPanel("Overall Team Performance",
                                                                          h4("Analyze IPL team's overall performance"),
                                                                          sidebarPanel(
                                                                              selectInput('overallperfFunc', 'Select function', teamOverallPerfFunc),
                                                                              selectInput('teamMatches', 'Select the team', IPLTeamsAll,selectize=FALSE, size=13),
                                                                              uiOutput("Rank"),
                                                                              uiOutput("dateRange2"),
                                                                              radioButtons("plotOrTable2", label = h4("Plot or table"),
                                                                                           choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                           selected = 2,inline=T),
                                                                              radioButtons("repType2", label = h4("Report Type"),
                                                                                           choices = c("Summary" = 1, "Detailed" = 2),
                                                                                           selected = 1,inline=T)
                                                                          ),
                                                                          mainPanel(
                                                                              uiOutput('printOrPlotIPLTeamPerfoverall'),
                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )


                                                                 ),

                                                                 # Rank IPL Batsmen tab
                                                                 tabPanel("IPL Performance Analysis",
                                                                          #h4("IPL Performance analysis"),
                                                                          sidebarPanel(
                                                                              selectInput('T20BattingPerfFunc', 'Select function', T20OverallBattingPerfFunc),
                                                                              sliderInput("minMatches", "Matches played",

                                                                                          min = (helper(IPLTeamNames,"./ipl/iplPerformance","IPL")[[3]]),
                                                                                          max = (helper(IPLTeamNames,"./ipl/iplPerformance","IPL")[[4]]),
                                                                                          value =round(((helper(IPLTeamNames,"./ipl/iplPerformance","IPL")[[3]]) +
                                                                                                            (helper(IPLTeamNames,"./ipl/iplPerformance")[[4]]))/2)
                                                                              ),
                                                                              uiOutput("Mode"),
                                                                              uiOutput("dateRange5"),
                                                                              radioButtons("plotOrTable3", label = h4("Plot(static,interactive) or table"),
                                                                                           choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                           selected = 2,inline=T)

                                                                          ),
                                                                          mainPanel(
                                                                              shinycssloaders::withSpinner(
                                                                                  uiOutput('plotOrPrintIPLBattingPerf'),
                                                                              ),

                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )
                                                                 ),
                                                                 # Rank IPL Bowlers tab
                                                                 tabPanel("Rank IPL Bowlers",
                                                                          h4('Rank IPL Bowlers'),

                                                                          sidebarPanel(
                                                                              selectInput('T20BowlingPerfFunc', 'Select function', T20OverallBowlingPerfFunc),
                                                                              sliderInput("minMatches1", "Matches played",
                                                                                          min = (helper2(IPLTeamNames,"./ipl/iplPerformance","IPL")[[3]]),
                                                                                          max = (helper2(IPLTeamNames,"./ipl/iplPerformance","IPL")[[4]]),
                                                                                          value =round(((helper2(IPLTeamNames,"./ipl/iplPerformance","IPL")[[3]]) +
                                                                                                            (helper2(IPLTeamNames,"./ipl/iplPerformance","IPL")[[4]]))/2)
                                                                              ),
                                                                              uiOutput("Mode1"),
                                                                              uiOutput("dateRange6"),
                                                                              radioButtons("plotOrTable4", label = h4("Plot(static,interactive) or table"),
                                                                                           choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                           selected = 2,inline=T)

                                                                          ),
                                                                          mainPanel(
                                                                              shinycssloaders::withSpinner(
                                                                                  uiOutput('plotOrPrintIPLBowlingPerf'),
                                                                              ),

                                                                              column(7, offset=4,
                                                                                     tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                     tags$h5((tags$i("Oct 11, 2021"))),
                                                                                     tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                     tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                              )
                                                                          )
                                                                 )


                                                     ))),


                      ############################# International T20 (Men) ############################################
                      #############################################################################################
                      tabPanel("Intl. T20 (men)",navbarPage("GooglyPlusPlus - International T20 (men)",
                                                            # Batsman tab
                                                            tabPanel("Intl T20 batsman",
                                                                     h4('Analyze Intl T20 batsman performances'),
                                                                     sidebarPanel(
                                                                         selectInput('batsmanFuncT20M', 'Select function', batsmanFuncs),
                                                                         selectInput('batsmanT20M', 'Select batsman', T20MBatsmen,selectize=FALSE, size=14),
                                                                         uiOutput("dateRange3T20M"),
                                                                         radioButtons("staticIntvT20M", label = h4("Plot type"),
                                                                                      choices = c("interactive" = 2,"static" = 1 ),
                                                                                      selected = 2,inline=T)
                                                                     ),
                                                                     mainPanel(

                                                                         uiOutput('batsmanPlotT20M'),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )
                                                            ),
                                                            # Bowlers tab
                                                            tabPanel("Intl. T20 bowlers",

                                                                     h4('Analyze Intl. T20 bowler performances'),

                                                                     sidebarPanel(
                                                                         selectInput('bowlerFuncT20M', 'Select function', bowlerFuncs),
                                                                         selectInput('bowlerT20M', 'Select bowler', T20MBowlers,selectize=FALSE, size=14),
                                                                         uiOutput("dateRange4T20M"),
                                                                         radioButtons("staticIntv1T20M", label = h4("Plot type"),
                                                                                      choices = c("interactive" = 2,"static" = 1 ),
                                                                                      selected = 2,inline=T)


                                                                     ),
                                                                     mainPanel(
                                                                         uiOutput('bowlerPlotT20M'),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )

                                                            ),
                                                            tabPanel("Intl T20 Match",
                                                                     h4('Analyze an Intl T20 match'),
                                                                     sidebarPanel(
                                                                         selectInput('matchFuncT20M', 'Select match function', matchFuncs),
                                                                         tags$head(tags$style(type="text/css", '.myclass .shiny-bound-input{overflow-x: scroll;}')),
                                                                         tags$div(id="myclass2", class="myclass",selectInput('matchT20M', 'Select T20 match ', T20MMatches,selectize=FALSE, size=15,width='800px')),
                                                                         uiOutput("selectTeamT20M"),
                                                                         radioButtons("plotOrTableT20M", label = h4("Plot(static,interactive) or table"),
                                                                                      choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                      selected = 2,inline=T)

                                                                     ),
                                                                     mainPanel(
                                                                         uiOutput("plotOrPrintT20MMatch"),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )
                                                            ),

                                                            # Analyze 2 T20 Teams men's  matches
                                                            tabPanel("Head to head",
                                                                     h4('Head-to-head between 2 T20 (mens) teams'),
                                                                     sidebarPanel(
                                                                         selectInput('matches2TeamFuncT20M', 'Select function', matches2TeamsFuncs),
                                                                         selectInput('match2T20M', 'Select matches', T20MMatches2Teams,selectize=FALSE, size=13),
                                                                         uiOutput("selectTeam2T20M"),
                                                                         uiOutput("dateRange1T20M"),
                                                                         radioButtons("plotOrTable1T20M", label = h4("Plot(static,interactive) or table"),
                                                                                      choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                      selected = 2,inline=T),
                                                                         radioButtons("repTypeT20M", label = h4("Report Type"),
                                                                                      choices = c("Summary" = 1, "Detailed" = 2),
                                                                                      selected = 1,inline=T)

                                                                     ),
                                                                     mainPanel(
                                                                         uiOutput("plotOrPrintT20MMatch2teams"),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )

                                                            ),
                                                            # Analyze T20Mens Team Overall Perf
                                                            tabPanel("Overall Team Performance",
                                                                     h4("Analyze T20M team's overall performance"),
                                                                     sidebarPanel(
                                                                         selectInput('overallperfFuncT20M', 'Select function', teamOverallPerfFunc),
                                                                         selectInput('teamMatchesT20M', 'Select the team', T20MTeamsAll,selectize=FALSE, size=13),
                                                                         uiOutput("RankT20M"),
                                                                         uiOutput("dateRange2T20M"),
                                                                         radioButtons("plotOrTable2T20M", label = h4("Plot or table"),
                                                                                      choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                      selected = 2,inline=T),
                                                                         radioButtons("repType2T20M", label = h4("Report Type"),
                                                                                      choices = c("Summary" = 1, "Detailed" = 2),
                                                                                      selected = 1,inline=T)
                                                                     ),
                                                                     mainPanel(
                                                                         uiOutput('printOrPlotT20MTeamPerfoverall'),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )

                                                            ),
                                                            #  Overall T20 Men tab
                                                            tabPanel("Overall T20 Batsmen  (men)",

                                                                     h4('Intl. T20 Batsmen (men) performance'),
                                                                     sidebarPanel(
                                                                         selectInput('T20BattingPerfFuncT20M', 'Select function', T20OverallBattingPerfFunc),
                                                                         sliderInput("minMatchesT20M", "Matches played",
                                                                                     min = (helper(T20MTeamNames,"./t20/t20Performance","T20M")[[3]]),
                                                                                     max = (helper(T20MTeamNames,"./t20/t20Performance","T20M")[[4]]),
                                                                                     value =round(((helper(T20MTeamNames,"./t20/t20Performance","T20M")[[3]]) +
                                                                                                       (helper(T20MTeamNames,"./t20/t20Performance","T20M")[[3]]))/2)
                                                                         ),
                                                                         uiOutput("ModeT20M"),
                                                                         uiOutput("dateRange5T20M"),
                                                                         radioButtons("plotOrTable3T20M", label = h4("Plot(static,interactive) or table"),
                                                                                      choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                      selected = 2,inline=T)
                                                                     ),
                                                                     mainPanel(
                                                                         shinycssloaders::withSpinner(
                                                                             uiOutput('plotOrPrintT20MBattingPerf'),
                                                                         ),

                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )
                                                            ),
                                                            # Overall T20 Bowlers(men) tab
                                                            tabPanel("Intl. T20 Bowlers (men) performance",

                                                                     h4('Intl. T20 Bowlers (men) performance'),
                                                                     sidebarPanel(
                                                                         selectInput('T20BowlingPerfFuncT20M', 'Select function', T20OverallBowlingPerfFunc),
                                                                         sliderInput("minMatches1T20M", "Matches played",
                                                                                     min = (helper2(T20MTeamNames,"./t20/t20Performance","T20M")[[3]]),
                                                                                     max = (helper2(T20MTeamNames,"./t20/t20Performance","T20M")[[4]]),
                                                                                     value =round(((helper2(T20MTeamNames,"./t20/t20Performance","T20M")[[3]]) +
                                                                                                       (helper2(T20MTeamNames,"./t20/t20Performance","T20M")[[4]]))/2)
                                                                         ),
                                                                         uiOutput("Mode1T20M"),
                                                                         uiOutput("dateRange6T20M"),
                                                                         radioButtons("plotOrTable4T20M", label = h4("Plot(static,interactive) or table"),
                                                                                      choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                      selected = 2,inline=T)
                                                                     ),
                                                                     mainPanel(
                                                                         shinycssloaders::withSpinner(
                                                                             uiOutput('plotOrPrintT20MBowlingPerf'),
                                                                         ),
                                                                         column(7, offset=4,
                                                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                tags$h5((tags$i("Oct 11, 2021"))),
                                                                                tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                         )
                                                                     )
                                                            )

                      )),
                      ############################# International T20 (Women) ################################
                      ########################################################################################
                      tabPanel("Intl. T20 (women)",navbarPage("GooglyPlusPlus - International T20 (women)",
                                                              # Batsman tab
                                                              tabPanel("Intl T20 batsman",
                                                                       h4('Analyze Intl T20 batsman performances'),
                                                                       sidebarPanel(
                                                                           selectInput('batsmanFuncT20W', 'Select function', batsmanFuncs),
                                                                           selectInput('batsmanT20W', 'Select batsman', T20WBatsmen,selectize=FALSE, size=14),
                                                                           uiOutput("dateRange3T20W"),
                                                                           radioButtons("staticIntvT20W", label = h4("Plot type"),
                                                                                        choices = c("interactive" = 2,"static" = 1 ),
                                                                                        selected = 2,inline=T)
                                                                       ),
                                                                       mainPanel(

                                                                           uiOutput('batsmanPlotT20W'),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )
                                                              ),
                                                              # Bowlers tab
                                                              tabPanel("Intl. T20 bowlers",

                                                                       h4('Analyze Intl. T20 bowler performances'),

                                                                       sidebarPanel(
                                                                           selectInput('bowlerFuncT20W', 'Select function', bowlerFuncs),
                                                                           selectInput('bowlerT20W', 'Select bowler', T20WBowlers,selectize=FALSE, size=14),
                                                                           uiOutput("dateRange4T20W"),
                                                                           radioButtons("staticIntv1T20W", label = h4("Plot type"),
                                                                                        choices = c("interactive" = 2,"static" = 1 ),
                                                                                        selected = 2,inline=T)


                                                                       ),
                                                                       mainPanel(
                                                                           uiOutput('bowlerPlotT20W'),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )

                                                              ),
                                                              tabPanel("Intl T20 Match",
                                                                       h4('Analyze an Intl T20 match'),
                                                                       sidebarPanel(
                                                                           selectInput('matchFuncT20W', 'Select match function', matchFuncs),
                                                                           selectInput('matchT20W', 'Select T20 match ', T20WMatches,selectize=FALSE, size=15),
                                                                           uiOutput("selectTeamT20W"),
                                                                           radioButtons("plotOrTableT20W", label = h4("Plot(static,interactive) or table"),
                                                                                        choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                        selected = 2,inline=T)

                                                                       ),
                                                                       mainPanel(
                                                                           uiOutput("plotOrPrintT20WMatch"),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )
                                                              ),

                                                              # Analyze 2 T20 Teams women's  matches
                                                              tabPanel("Head to head",
                                                                       h4('Head-to-head between 2 T20 (womens) teams'),
                                                                       sidebarPanel(
                                                                           selectInput('matches2TeamFuncT20W', 'Select function', matches2TeamsFuncs),
                                                                           selectInput('match2T20W', 'Select matches', T20WMatches2Teams,selectize=FALSE, size=13),
                                                                           uiOutput("selectTeam2T20W"),
                                                                           uiOutput("dateRange1T20W"),
                                                                           radioButtons("plotOrTable1T20W", label = h4("Plot(static,interactive) or table"),
                                                                                        choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                        selected = 2,inline=T),
                                                                           radioButtons("repTypeT20W", label = h4("Report Type"),
                                                                                        choices = c("Summary" = 1, "Detailed" = 2),
                                                                                        selected = 1,inline=T)

                                                                       ),
                                                                       mainPanel(
                                                                           uiOutput("plotOrPrintT20WMatch2teams"),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )

                                                              ),
                                                              # Analyze T20Wens Team Overall Perf
                                                              tabPanel("Overall Performance",
                                                                       h4("Analyze T20W team's overall performance"),
                                                                       sidebarPanel(
                                                                           selectInput('overallperfFuncT20W', 'Select function', teamOverallPerfFunc),
                                                                           selectInput('teamMatchesT20W', 'Select the team', T20WTeamsAll,selectize=FALSE, size=13),
                                                                           uiOutput("RankT20W"),
                                                                           uiOutput("dateRange2T20W"),
                                                                           radioButtons("plotOrTable2T20W", label = h4("Plot or table"),
                                                                                        choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                        selected = 2,inline=T),
                                                                           radioButtons("repType2T20W", label = h4("Report Type"),
                                                                                        choices = c("Summary" = 1, "Detailed" = 2),
                                                                                        selected = 1,inline=T)
                                                                       ),
                                                                       mainPanel(
                                                                           uiOutput('printOrPlotT20WTeamPerfoverall'),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )

                                                              ),
                                                              # Rank T20 Women  tab
                                                              tabPanel("Rank Intl. T20 Batsmen (women)",

                                                                       h4('Rank Intl. T20 Batsmen (women)'),

                                                                       sidebarPanel(
                                                                           selectInput('T20BattingPerfFuncT20W', 'Select function', T20OverallBattingPerfFunc),
                                                                           sliderInput("minMatchesT20W", "Matches played",
                                                                                       min = (helper(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[3]]),
                                                                                       max = (helper(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[4]]),
                                                                                       value =round(((helper(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[3]]) +
                                                                                                         (helper(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[3]]))/2),
                                                                           ),
                                                                           uiOutput("ModeT20W"),
                                                                           uiOutput("dateRange5T20W"),
                                                                           radioButtons("plotOrTable3T20W", label = h4("Plot(static,interactive) or table"),
                                                                                        choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                        selected = 2,inline=T)

                                                                       ),
                                                                       mainPanel(
                                                                           shinycssloaders::withSpinner(
                                                                               uiOutput('plotOrPrintT20WBattingPerf'),
                                                                           ),

                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )
                                                              ),
                                                              # Rank T20 Bowlers(women) tab
                                                              tabPanel("Rank Intl. T20 Bowlers (women)",

                                                                       h4('Rank Intl. T20 Bowlers (women)'),
                                                                       sidebarPanel(
                                                                           selectInput('T20BowlingPerfFuncT20W', 'Select function', T20OverallBowlingPerfFunc),
                                                                           sliderInput("minMatches1T20W", "Matches played",
                                                                                       min = (helper2(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[3]]),
                                                                                       max = (helper2(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[4]]),
                                                                                       value =round(((helper2(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[3]]) +
                                                                                                         (helper2(T20WTeamNames,"./t20/t20WomenPerformance","T20W")[[4]]))/2)
                                                                           ),
                                                                           uiOutput("Mode1T20W"),
                                                                           uiOutput("dateRange6T20W"),
                                                                           radioButtons("plotOrTable4T20W", label = h4("Plot(static,interactive) or table"),
                                                                                        choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                        selected = 2,inline=T)
                                                                       ),
                                                                       mainPanel(
                                                                           shinycssloaders::withSpinner(
                                                                               uiOutput('plotOrPrintT20WBowlingPerf'),
                                                                           ),
                                                                           column(7, offset=4,
                                                                                  tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                                  tags$h5((tags$i("Oct 11, 2021"))),
                                                                                  tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                                  tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                           )
                                                                       )
                                                              )

                      )),
                      #############################Big Bash League T20 #########################################################
                      ###########################################################################################################
                      tabPanel("BBL T20",navbarPage("GooglyPlusPlus - Big Bash League T20",
                                                    # Batsman tab
                                                    tabPanel("BBL T20 batsman",
                                                             h4('Analyze BBL T20 batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncBBL', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanBBL', 'Select batsman', BBLBatsmen,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange3BBL"),
                                                                 radioButtons("staticIntvBBL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotBBL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("BBL T20 bowlers",

                                                             h4('Analyze BBL T20 bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncBBL', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerBBL', 'Select bowler', BBLBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4BBL"),
                                                                 radioButtons("staticIntv1BBL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotBBL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("BBL T20 Match",
                                                             h4('Analyze BBL T20 match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncBBL', 'Select match function', matchFuncs),
                                                                 selectInput('matchBBL', 'Select T20 match ', BBLMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamBBL"),
                                                                 radioButtons("plotOrTableBBL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintBBLMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 BBL T20 Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 BBL teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncBBL', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2BBL', 'Select matches', BBLMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2BBL"),
                                                                 uiOutput("dateRange1BBL"),
                                                                 radioButtons("plotOrTable1BBL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypeBBL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintBBLMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze BBL Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze BBL team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncBBL', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesBBL', 'Select the team', BBLTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankBBL"),
                                                                 uiOutput("dateRange2BBL"),
                                                                 radioButtons("plotOrTable2BBL", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2BBL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotBBLTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Rank BBL Players tab
                                                    tabPanel("Overall BBL Batsmen Amalysis",

                                                             h4('Overall BBL Batsmen '),
                                                             sidebarPanel(
                                                                 selectInput('T20BattingPerfFuncBBL', 'Select function', T20OverallBattingPerfFunc),
                                                                 sliderInput("minMatchesBBL", "Matches played",
                                                                             min = (helper(BBLTeamNames,"./bbl/bblPerformance","BBL")[[3]]),
                                                                             max = (helper(BBLTeamNames,"./bbl/bblPerformance","BBL")[[4]]),
                                                                             value =round(((helper(BBLTeamNames,"./bbl/bblPerformance","BBL")[[3]]) +
                                                                                               (helper(BBLTeamNames,"./bbl/bblPerformance","BBL")[[3]]))/2)
                                                                 ),
                                                                 uiOutput("ModeBBL"),
                                                                 uiOutput("dateRange5BBL"),
                                                                 radioButtons("plotOrTable3BBL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintBBLBattingPerf'),
                                                                 ),

                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Rank BBL Bowlers tab
                                                    tabPanel("BBL Bowlers Overall Performance",

                                                             h4('BBL BowlersOverall Performance'),
                                                             sidebarPanel(
                                                                 selectInput('T20BowlingPerfFuncBBL', 'Select function', T20OverallBowlingPerfFunc),
                                                                 sliderInput("minMatches1BBL", "Matches played",
                                                                             min = (helper2(BBLTeamNames,"./bbl/bblPerformance","BBL")[[3]]),
                                                                             max = (helper2(BBLTeamNames,"./bbl/bblPerformance","BBL")[[4]]),
                                                                             value =round(((helper2(BBLTeamNames,"./bbl/bblPerformance","BBL")[[3]]) +
                                                                                               (helper2(BBLTeamNames,"./bbl/bblPerformance","BBL")[[4]]))/2)
                                                                 ),
                                                                 uiOutput("Mode1BBL"),
                                                                 uiOutput("dateRange6BBL"),
                                                                 radioButtons("plotOrTable4BBL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintBBLBowlingPerf'),
                                                                 ),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    )

                      )),
                      ############################# Natwest T20 ################################
                      ##########################################################################
                      tabPanel("NTB T20",navbarPage("GooglyPlusPlus - Natwest T20",
                                                    # Batsman tab
                                                    tabPanel("NTB T20 batsman",
                                                             h4('Analyze NTB T20 batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncNTB', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanNTB', 'Select batsman', NTBBatsmen,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange3NTB"),
                                                                 radioButtons("staticIntvNTB", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotNTB'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("NTB T20 bowlers",

                                                             h4('Analyze NTB T20 bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncNTB', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerNTB', 'Select bowler', NTBBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4NTB"),
                                                                 radioButtons("staticIntv1NTB", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotNTB'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("NTB T20 Match",
                                                             h4('Analyze NTB T20 match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncNTB', 'Select match function', matchFuncs),
                                                                 selectInput('matchNTB', 'Select T20 match ', NTBMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamNTB"),
                                                                 radioButtons("plotOrTableNTB", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintNTBMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 NTB T20 Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 NTB teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncNTB', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2NTB', 'Select matches', NTBMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2NTB"),
                                                                 uiOutput("dateRange1NTB"),
                                                                 radioButtons("plotOrTable1NTB", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypeNTB", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintNTBMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze NTB Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze NTB team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncNTB', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesNTB', 'Select the team', NTBTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankNTB"),
                                                                 uiOutput("dateRange2NTB"),
                                                                 radioButtons("plotOrTable2NTB", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2NTB", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotNTBTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # NTB Players tab
                                                    tabPanel("NTB Batsmen Overall",

                                                             h4('NTB Batsmen Overall '),
                                                             sidebarPanel(
                                                                 selectInput('T20BattingPerfFuncNTB', 'Select function', T20OverallBattingPerfFunc),
                                                                 sliderInput("minMatchesNTB", "Matches played",
                                                                             min = (helper(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[3]]),
                                                                             max = (helper(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[4]]),
                                                                             value =round(((helper(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[3]]) +
                                                                                               (helper(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[3]]))/2)
                                                                 ),
                                                                 uiOutput("ModeNTB"),
                                                                 uiOutput("dateRange5NTB"),
                                                                 radioButtons("plotOrTable3NTB", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintNTBBattingPerf'),
                                                                 ),

                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Rank NTB Bowlers tab
                                                    tabPanel("NTB Bowlers",

                                                             h4('NTB Bowlers overall'),
                                                             sidebarPanel(
                                                                 selectInput('T20BowlingPerfFuncNTB', 'Select function', T20OverallBowlingPerfFunc),
                                                                 sliderInput("minMatches1NTB", "Matches played",
                                                                             min = (helper2(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[3]]),
                                                                             max = (helper2(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[4]]),
                                                                             value =round(((helper2(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[3]]) +
                                                                                               (helper2(NTBTeamNames,"./ntb/ntbPerformance","NTB")[[4]]))/2)
                                                                 ),
                                                                 uiOutput("Mode1NTB"),
                                                                 uiOutput("dateRange6NTB"),
                                                                 radioButtons("plotOrTable4NTB", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintNTBBowlingPerf'),
                                                                 ),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    )

                      )),
                      ############################# PSL T20 ################################
                      #######################################################################
                      tabPanel("PSL T20",navbarPage("GooglyPlusPlus - Pakistan Super League",
                                                    # Batsman tab
                                                    tabPanel("PSL T20 batsman",
                                                             h4('Analyze PSL T20 batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncPSL', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanPSL', 'Select batsman', PSLBatsmen,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange3PSL"),
                                                                 radioButtons("staticIntvPSL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotPSL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("PSL T20 bowlers",

                                                             h4('Analyze PSL T20 bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncPSL', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerPSL', 'Select bowler', PSLBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4PSL"),
                                                                 radioButtons("staticIntv1PSL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotPSL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("PSL T20 Match",
                                                             h4('Analyze PSL T20 match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncPSL', 'Select match function', matchFuncs),
                                                                 selectInput('matchPSL', 'Select T20 match ', PSLMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamPSL"),
                                                                 radioButtons("plotOrTablePSL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintPSLMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 PSL T20 Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 PSL teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncPSL', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2PSL', 'Select matches', PSLMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2PSL"),
                                                                 uiOutput("dateRange1PSL"),
                                                                 radioButtons("plotOrTable1PSL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypePSL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintPSLMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze PSL Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze PSL team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncPSL', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesPSL', 'Select the team', PSLTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankPSL"),
                                                                 uiOutput("dateRange2PSL"),
                                                                 radioButtons("plotOrTable2PSL", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2PSL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotPSLTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Rank PSL Players tab
                                                    tabPanel("Rank  PSL Batsmen",

                                                             h4('Rank  PSL Batsmen '),
                                                             sidebarPanel(
                                                                 selectInput('T20BattingPerfFuncPSL', 'Select function', T20OverallBattingPerfFunc),
                                                                 sliderInput("minMatchesPSL", "Matches played",
                                                                             min = (helper(PSLTeamNames,"./psl/pslPerformance","PSL")[[3]]),
                                                                             max = (helper(PSLTeamNames,"./psl/pslPerformance","PSL")[[4]]),
                                                                             value =round(((helper(PSLTeamNames,"./psl/pslPerformance","PSL")[[3]]) +
                                                                                               (helper(PSLTeamNames,"./psl/pslPerformance","PSL")[[3]]))/2)
                                                                 ),
                                                                 uiOutput("ModePSL"),
                                                                 uiOutput("dateRange5PSL"),
                                                                 radioButtons("plotOrTable3PSL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintPSLBattingPerf'),
                                                                 ),

                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Rank PSL Bowlers tab
                                                    tabPanel("PSL Bowlers",

                                                             h4('PSL Bowlers '),
                                                             sidebarPanel(
                                                                 selectInput('T20BowlingPerfFuncPSL', 'Select function', T20OverallBowlingPerfFunc),
                                                                 sliderInput("minMatches1PSL", "Matches played",
                                                                             min = (helper2(PSLTeamNames,"./psl/pslPerformance","PSL")[[3]]),
                                                                             max = (helper2(PSLTeamNames,"./psl/pslPerformance","PSL")[[4]]),
                                                                             value =round(((helper2(PSLTeamNames,"./psl/pslPerformance","PSL")[[3]]) +
                                                                                               (helper2(PSLTeamNames,"./psl/pslPerformance","PSL")[[4]]))/2)
                                                                 ),
                                                                 uiOutput("Mode1PSL"),
                                                                 uiOutput("dateRange6PSL"),
                                                                 radioButtons("plotOrTable4PSL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintPSLBowlingPerf'),
                                                                 ),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    )

                      )),
                      ############################# WBB T20 ################################
                      #####################################################################
                      tabPanel("WBBL T20",navbarPage("GooglyPlusPlus - Women's Big Bash League",
                                                     # Batsman tab
                                                     tabPanel("WBB T20 batsman",
                                                              h4('Analyze WBB T20 batsman performances'),
                                                              sidebarPanel(
                                                                  selectInput('batsmanFuncWBB', 'Select function', batsmanFuncs),
                                                                  selectInput('batsmanWBB', 'Select batsman', WBBBatsmen,selectize=FALSE, size=14),
                                                                  uiOutput("dateRange3WBB"),
                                                                  radioButtons("staticIntvWBB", label = h4("Plot type"),
                                                                               choices = c("interactive" = 2,"static" = 1 ),
                                                                               selected = 2,inline=T)
                                                              ),
                                                              mainPanel(

                                                                  uiOutput('batsmanPlotWBB'),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )
                                                     ),
                                                     # Bowlers tab
                                                     tabPanel("WBB T20 bowlers",

                                                              h4('Analyze WBB T20 bowler performances'),

                                                              sidebarPanel(
                                                                  selectInput('bowlerFuncWBB', 'Select function', bowlerFuncs),
                                                                  selectInput('bowlerWBB', 'Select bowler', WBBBowlers,selectize=FALSE, size=14),
                                                                  uiOutput("dateRange4WBB"),
                                                                  radioButtons("staticIntv1WBB", label = h4("Plot type"),
                                                                               choices = c("interactive" = 2,"static" = 1 ),
                                                                               selected = 2,inline=T)


                                                              ),
                                                              mainPanel(
                                                                  uiOutput('bowlerPlotWBB'),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )

                                                     ),
                                                     tabPanel("WBB T20 Match",
                                                              h4('Analyze WBB T20 match'),
                                                              sidebarPanel(
                                                                  selectInput('matchFuncWBB', 'Select match function', matchFuncs),
                                                                  selectInput('matchWBB', 'Select T20 match ', WBBMatches,selectize=FALSE, size=15),
                                                                  uiOutput("selectTeamWBB"),
                                                                  radioButtons("plotOrTableWBB", label = h4("Plot(static,interactive) or table"),
                                                                               choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                               selected = 2,inline=T)

                                                              ),
                                                              mainPanel(
                                                                  uiOutput("plotOrPrintWBBMatch"),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )
                                                     ),

                                                     # Analyze 2 WBB T20 Teams men's  matches
                                                     tabPanel("Head to head",
                                                              h4('Head-to-head between 2 WBB teams'),
                                                              sidebarPanel(
                                                                  selectInput('matches2TeamFuncWBB', 'Select function', matches2TeamsFuncs),
                                                                  selectInput('match2WBB', 'Select matches', WBBMatches2Teams,selectize=FALSE, size=13),
                                                                  uiOutput("selectTeam2WBB"),
                                                                  uiOutput("dateRange1WBB"),
                                                                  radioButtons("plotOrTable1WBB", label = h4("Plot(static,interactive) or table"),
                                                                               choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                               selected = 2,inline=T),
                                                                  radioButtons("repTypeWBB", label = h4("Report Type"),
                                                                               choices = c("Summary" = 1, "Detailed" = 2),
                                                                               selected = 1,inline=T)

                                                              ),
                                                              mainPanel(
                                                                  uiOutput("plotOrPrintWBBMatch2teams"),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )

                                                     ),
                                                     # Analyze WBB Team Overall Perf
                                                     tabPanel("Overall Performance",
                                                              h4("Analyze WBB team's overall performance"),
                                                              sidebarPanel(
                                                                  selectInput('overallperfFuncWBB', 'Select function', teamOverallPerfFunc),
                                                                  selectInput('teamMatchesWBB', 'Select the team', WBBTeamsAll,selectize=FALSE, size=13),
                                                                  uiOutput("RankWBB"),
                                                                  uiOutput("dateRange2WBB"),
                                                                  radioButtons("plotOrTable2WBB", label = h4("Plot or table"),
                                                                               choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                               selected = 2,inline=T),
                                                                  radioButtons("repType2WBB", label = h4("Report Type"),
                                                                               choices = c("Summary" = 1, "Detailed" = 2),
                                                                               selected = 1,inline=T)
                                                              ),
                                                              mainPanel(
                                                                  uiOutput('printOrPlotWBBTeamPerfoverall'),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )

                                                     ),
                                                     # Rank WBB PlayersL tab
                                                     tabPanel("Rank WBB Batsmen",
                                                              h4('Rank  WBB Batsmen '),
                                                              sidebarPanel(
                                                                  selectInput('T20BattingPerfFuncWBB', 'Select function', T20OverallBattingPerfFunc),
                                                                  sliderInput("minMatchesWBB", "Matches played",
                                                                              min = (helper(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[3]]),
                                                                              max = (helper(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[4]]),
                                                                              value =round(((helper(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[3]]) +
                                                                                                (helper(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[3]]))/2)
                                                                  ),
                                                                  uiOutput("ModeWBB"),
                                                                  uiOutput("dateRange5WBB"),
                                                                  radioButtons("plotOrTable3WBB", label = h4("Plot(static,interactive) or table"),
                                                                               choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                               selected = 2,inline=T)

                                                              ),
                                                              mainPanel(
                                                                  shinycssloaders::withSpinner(
                                                                      uiOutput('plotOrPrintWBBBattingPerf'),
                                                                  ),

                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )
                                                     ),
                                                     # Rank WBB Bowlers tab
                                                     tabPanel("Rank WBB Bowlers",

                                                              h4('Rank WBB Bowlers '),
                                                              sidebarPanel(
                                                                  selectInput('T20BowlingPerfFuncWBB', 'Select function', T20OverallBowlingPerfFunc),
                                                                  sliderInput("minMatches1WBB", "Matches played",
                                                                              min = (helper2(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[3]]),
                                                                              max = (helper2(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[4]]),
                                                                              value =round(((helper2(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[3]]) +
                                                                                                (helper2(WBBTeamNames,"./wbb/wbbPerformance","WBB")[[4]]))/2)
                                                                  ),
                                                                  uiOutput("Mode1WBB"),
                                                                  uiOutput("dateRange6WBB"),
                                                                  radioButtons("plotOrTable4WBB", label = h4("Plot(static,interactive) or table"),
                                                                               choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                               selected = 2,inline=T)
                                                              ),
                                                              mainPanel(
                                                                  shinycssloaders::withSpinner(
                                                                      uiOutput('plotOrPrintWBBBowlingPerf'),
                                                                  ),
                                                                  column(7, offset=4,
                                                                         tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                         tags$h5((tags$i("Oct 11, 2021"))),
                                                                         tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                         tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                  )
                                                              )
                                                     )

                      )),

                      #############################Carribean Premier League T20 ################################
                      tabPanel("CPL T20",navbarPage("GooglyPlusPlus - Carribean Premier League T20",
                                                    # Batsman tab
                                                    tabPanel("CPL T20 batsman",
                                                             h4('Analyze CPL T20 batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncCPL', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanCPL', 'Select batsman', CPLBatsmen,selectize=FALSE, size=20),
                                                                 uiOutput("dateRange3CPL"),
                                                                 radioButtons("staticIntvCPL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotCPL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("CPL T20 bowlers",

                                                             h4('Analyze CPL T20 bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncCPL', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerCPL', 'Select bowler', CPLBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4CPL"),
                                                                 radioButtons("staticIntv1CPL", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotCPL'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("CPL T20 Match",
                                                             h4('Analyze CPL T20 match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncCPL', 'Select match function', matchFuncs),
                                                                 selectInput('matchCPL', 'Select T20 match ', CPLMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamCPL"),
                                                                 radioButtons("plotOrTableCPL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintCPLMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 CPL T20 Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 CPL teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncCPL', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2CPL', 'Select matches', CPLMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2CPL"),
                                                                 uiOutput("dateRange1CPL"),
                                                                 radioButtons("plotOrTable1CPL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypeCPL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintCPLMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze CPL Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze CPL team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncCPL', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesCPL', 'Select the team', CPLTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankCPL"),
                                                                 uiOutput("dateRange2CPL"),
                                                                 radioButtons("plotOrTable2CPL", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2CPL", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotCPLTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Rank CPL Players tab
                                                    tabPanel("Rank  CPL Batsmen",

                                                             h4('Rank  CPL Batsmen '),
                                                             sidebarPanel(
                                                                 selectInput('T20BattingPerfFuncCPL', 'Select function', T20OverallBattingPerfFunc),
                                                                 sliderInput("minMatchesCPL", "Matches played",
                                                                             min = (helper(CPLTeamNames,"./cpl/cplPerformance","CPL")[[3]]),
                                                                             max = (helper(CPLTeamNames,"./cpl/cplPerformance","CPL")[[4]]),
                                                                             value =round(((helper(CPLTeamNames,"./cpl/cplPerformance","CPL")[[3]]) +
                                                                                               (helper(CPLTeamNames,"./cpl/cplPerformance","CPL")[[3]]))/2)
                                                                 ),
                                                                 uiOutput("ModeCPL"),
                                                                 uiOutput("dateRange5CPL"),
                                                                 radioButtons("plotOrTable3CPL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintCPLBattingPerf'),
                                                                 ),

                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Rank CPL Bowlers tab
                                                    tabPanel("Rank CPL Bowlers",

                                                             h4('Rank CPL Bowlers '),
                                                             sidebarPanel(
                                                                 selectInput('T20BowlingPerfFuncCPL', 'Select function', T20OverallBowlingPerfFunc),
                                                                 sliderInput("minMatches1CPL", "Matches played",
                                                                             min = (helper2(CPLTeamNames,"./cpl/cplPerformance","CPL")[[3]]),
                                                                             max = (helper2(CPLTeamNames,"./cpl/cplPerformance","CPL")[[4]]),
                                                                             value =round(((helper2(CPLTeamNames,"./cpl/cplPerformance","CPL")[[3]]) +
                                                                                               (helper2(CPLTeamNames,"./cpl/cplPerformance","CPL")[[4]]))/2)
                                                                 ),
                                                                 uiOutput("Mode1CPL"),
                                                                 uiOutput("dateRange6CPL"),
                                                                 radioButtons("plotOrTable4CPL", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintCPLBowlingPerf'),
                                                                 ),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    )
                      )),


                      ############################# Super Smash  T20 ################################
                      ##############################################################################
                      tabPanel("SSM T20",navbarPage("GooglyPlusPlus - Super Smash T20",
                                                    # Batsman tab
                                                    tabPanel("SSM T20 batsman",
                                                             h4('Analyze SSM T20 batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncSSM', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanSSM', 'Select batsman', SSMBatsmen,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange3SSM"),
                                                                 radioButtons("staticIntvSSM", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotSSM'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("SSM T20 bowlers",

                                                             h4('Analyze SSM T20 bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncSSM', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerSSM', 'Select bowler', SSMBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4SSM"),
                                                                 radioButtons("staticIntv1SSM", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotSSM'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("SSM T20 Match",
                                                             h4('Analyze SSM T20 match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncSSM', 'Select match function', matchFuncs),
                                                                 selectInput('matchSSM', 'Select T20 match ', SSMMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamSSM"),
                                                                 radioButtons("plotOrTableSSM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintSSMMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 SSM T20 Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 SSM teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncSSM', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2SSM', 'Select matches', SSMMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2SSM"),
                                                                 uiOutput("dateRange1SSM"),
                                                                 radioButtons("plotOrTable1SSM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypeSSM", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintSSMMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze SSM Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze SSM team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncSSM', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesSSM', 'Select the team', SSMTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankSSM"),
                                                                 uiOutput("dateRange2SSM"),
                                                                 radioButtons("plotOrTable2SSM", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2SSM", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotSSMTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Rank SSM Players tab
                                                    tabPanel("Rank  SSM Batsmen",

                                                             sidebarPanel(
                                                                 h4('Rank  SSM Batsmen '),
                                                                 selectInput('T20BattingPerfFuncSSM', 'Select function', T20OverallBattingPerfFunc),

                                                                 sliderInput("minMatchesSSM", "Matches played",
                                                                             min = (helper(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[3]]),
                                                                             max = (helper(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[4]]),
                                                                             value =round(((helper(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[3]]) +
                                                                                               (helper(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[3]]))/2)
                                                                 ),
                                                                 uiOutput("ModeSSM"),
                                                                 uiOutput("dateRange5SSM"),
                                                                 radioButtons("plotOrTable3SSM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintSSMBattingPerf'),
                                                                 ),

                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Rank SSM Bowlers tab
                                                    tabPanel("Rank SSM Bowlers",

                                                             h4('Rank SSM Bowlers '),
                                                             sidebarPanel(
                                                                 selectInput('T20BowlingPerfFuncSSM', 'Select function', T20OverallBowlingPerfFunc),
                                                                 sliderInput("minMatches1SSM", "Matches played",
                                                                             min = (helper2(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[3]]),
                                                                             max = (helper2(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[4]]),
                                                                             value =round(((helper2(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[3]]) +
                                                                                               (helper2(SSMTeamNames,"./ssm/ssmPerformance","SSM")[[4]]))/2)
                                                                 ),
                                                                 uiOutput("Mode1SSM"),
                                                                 uiOutput("dateRange6SSM"),
                                                                 radioButtons("plotOrTable4SSM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 shinycssloaders::withSpinner(
                                                                     uiOutput('plotOrPrintSSMBowlingPerf'),
                                                                 ),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    )
                      )),


                      ############################# ODI Men ################################
                      tabPanel("ODI Men",navbarPage("GooglyPlusPlus - One Day International (ODI) Men",
                                                    # Batsman tab
                                                    tabPanel("ODI Men batsman",
                                                             h4('Analyze ODI Men batsman performances'),
                                                             sidebarPanel(
                                                                 selectInput('batsmanFuncODIM', 'Select function', batsmanFuncs),
                                                                 selectInput('batsmanODIM', 'Select batsman', ODIMBatsmen,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange3ODIM"),
                                                                 radioButtons("staticIntvODIM", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)
                                                             ),
                                                             mainPanel(

                                                                 uiOutput('batsmanPlotODIM'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),
                                                    # Bowlers tab
                                                    tabPanel("ODI Men bowlers",

                                                             h4('Analyze ODI Men bowler performances'),

                                                             sidebarPanel(
                                                                 selectInput('bowlerFuncODIM', 'Select function', bowlerFuncs),
                                                                 selectInput('bowlerODIM', 'Select bowler', ODIMBowlers,selectize=FALSE, size=14),
                                                                 uiOutput("dateRange4ODIM"),
                                                                 radioButtons("staticIntv1ODIM", label = h4("Plot type"),
                                                                              choices = c("interactive" = 2,"static" = 1 ),
                                                                              selected = 2,inline=T)


                                                             ),
                                                             mainPanel(
                                                                 uiOutput('bowlerPlotODIM'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    tabPanel("ODI Men Match",
                                                             h4('Analyze ODI Men match'),
                                                             sidebarPanel(
                                                                 selectInput('matchFuncODIM', 'Select match function', matchFuncs),
                                                                 selectInput('matchODIM', 'Select T20 match ', ODIMMatches,selectize=FALSE, size=15),
                                                                 uiOutput("selectTeamODIM"),
                                                                 radioButtons("plotOrTableODIM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintODIMMatch"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )
                                                    ),

                                                    # Analyze 2 ODI Men Teams men's  matches
                                                    tabPanel("Head to head",
                                                             h4('Head-to-head between 2 ODI Men teams'),
                                                             sidebarPanel(
                                                                 selectInput('matches2TeamFuncODIM', 'Select function', matches2TeamsFuncs),
                                                                 selectInput('match2ODIM', 'Select matches', ODIMMatches2Teams,selectize=FALSE, size=13),
                                                                 uiOutput("selectTeam2ODIM"),
                                                                 uiOutput("dateRange1ODIM"),
                                                                 radioButtons("plotOrTable1ODIM", label = h4("Plot(static,interactive) or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repTypeODIM", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)

                                                             ),
                                                             mainPanel(
                                                                 uiOutput("plotOrPrintODIMMatch2teams"),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    ),
                                                    # Analyze ODI Men Team Overall Perf
                                                    tabPanel("Overall Performance",
                                                             h4("Analyze ODI Men team's overall performance"),
                                                             sidebarPanel(
                                                                 selectInput('overallperfFuncODIM', 'Select function', teamOverallPerfFunc),
                                                                 selectInput('teamMatchesODIM', 'Select the team', ODIMTeamsAll,selectize=FALSE, size=13),
                                                                 uiOutput("RankODIM"),
                                                                 uiOutput("dateRange2ODIM"),
                                                                 radioButtons("plotOrTable2ODIM", label = h4("Plot or table"),
                                                                              choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                              selected = 2,inline=T),
                                                                 radioButtons("repType2ODIM", label = h4("Report Type"),
                                                                              choices = c("Summary" = 1, "Detailed" = 2),
                                                                              selected = 1,inline=T)
                                                             ),
                                                             mainPanel(
                                                                 uiOutput('printOrPlotODIMTeamPerfoverall'),
                                                                 column(7, offset=4,
                                                                        tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                        tags$h5((tags$i("Oct 11, 2021"))),
                                                                        tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                        tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                 )
                                                             )

                                                    )
                      )),

                      ############################# ODI Women ################################
                      tabPanel("ODI Women",navbarPage("GooglyPlusPlus - One Day International (ODI) Women",
                                                      # Batsman tab
                                                      tabPanel("ODI Women batsman",
                                                               h4('Analyze ODI Women batsman performances'),
                                                               sidebarPanel(
                                                                   selectInput('batsmanFuncODIW', 'Select function', batsmanFuncs),
                                                                   selectInput('batsmanODIW', 'Select batsman', ODIWBatsmen,selectize=FALSE, size=14),
                                                                   uiOutput("dateRange3ODIW"),
                                                                   radioButtons("staticIntvODIW", label = h4("Plot type"),
                                                                                choices = c("interactive" = 2,"static" = 1 ),
                                                                                selected = 2,inline=T)
                                                               ),
                                                               mainPanel(

                                                                   uiOutput('batsmanPlotODIW'),
                                                                   column(7, offset=4,
                                                                          tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                          tags$h5((tags$i("Oct 11, 2021"))),
                                                                          tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                          tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                   )
                                                               )
                                                      ),
                                                      # Bowlers tab
                                                      tabPanel("ODI Women bowlers",

                                                               h4('Analyze ODI Women bowler performances'),

                                                               sidebarPanel(
                                                                   selectInput('bowlerFuncODIW', 'Select function', bowlerFuncs),
                                                                   selectInput('bowlerODIW', 'Select bowler', ODIWBowlers,selectize=FALSE, size=14),
                                                                   uiOutput("dateRange4ODIW"),
                                                                   radioButtons("staticIntv1ODIW", label = h4("Plot type"),
                                                                                choices = c("interactive" = 2,"static" = 1 ),
                                                                                selected = 2,inline=T)


                                                               ),
                                                               mainPanel(
                                                                   uiOutput('bowlerPlotODIW'),
                                                                   column(7, offset=4,
                                                                          tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                          tags$h5((tags$i("Oct 11, 2021"))),
                                                                          tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                          tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                   )
                                                               )

                                                      ),
                                                      tabPanel("ODI Women Match",
                                                               h4('Analyze ODI Women match'),
                                                               sidebarPanel(
                                                                   selectInput('matchFuncODIW', 'Select match function', matchFuncs),
                                                                   selectInput('matchODIW', 'Select T20 match ', ODIWMatches,selectize=FALSE, size=15),
                                                                   uiOutput("selectTeamODIW"),
                                                                   radioButtons("plotOrTableODIW", label = h4("Plot(static,interactive) or table"),
                                                                                choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                selected = 2,inline=T)

                                                               ),
                                                               mainPanel(
                                                                   uiOutput("plotOrPrintODIWMatch"),
                                                                   column(7, offset=4,
                                                                          tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                          tags$h5((tags$i("Oct 11, 2021"))),
                                                                          tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                          tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                   )
                                                               )
                                                      ),

                                                      # Analyze 2 ODI Women Teams men's  matches
                                                      tabPanel("Head to head",
                                                               h4('Head-to-head between 2 ODI Women teams'),
                                                               sidebarPanel(
                                                                   selectInput('matches2TeamFuncODIW', 'Select function', matches2TeamsFuncs),
                                                                   selectInput('match2ODIW', 'Select matches', ODIWMatches2Teams,selectize=FALSE, size=13),
                                                                   uiOutput("selectTeam2ODIW"),
                                                                   uiOutput("dateRange1ODIW"),
                                                                   radioButtons("plotOrTable1ODIW", label = h4("Plot(static,interactive) or table"),
                                                                                choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                selected = 2,inline=T),
                                                                   radioButtons("repTypeODIW", label = h4("Report Type"),
                                                                                choices = c("Summary" = 1, "Detailed" = 2),
                                                                                selected = 1,inline=T)

                                                               ),
                                                               mainPanel(
                                                                   uiOutput("plotOrPrintODIWMatch2teams"),
                                                                   column(7, offset=4,
                                                                          tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                          tags$h5((tags$i("Oct 11, 2021"))),
                                                                          tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                          tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                   )
                                                               )

                                                      ),
                                                      # Analyze ODI Women Team Overall Perf
                                                      tabPanel("Overall Performance",
                                                               h4("Analyze ODI Women team's overall performance"),
                                                               sidebarPanel(
                                                                   selectInput('overallperfFuncODIW', 'Select function', teamOverallPerfFunc),
                                                                   selectInput('teamMatchesODIW', 'Select the team', ODIWTeamsAll,selectize=FALSE, size=13),
                                                                   uiOutput("RankODIW"),
                                                                   uiOutput("dateRange2ODIW"),
                                                                   radioButtons("plotOrTable2ODIW", label = h4("Plot or table"),
                                                                                choices = c("Plot(interactive)" = 2, "Plot(static)" = 1, "Table" = 3),
                                                                                selected = 2,inline=T),
                                                                   radioButtons("repType2ODIW", label = h4("Report Type"),
                                                                                choices = c("Summary" = 1, "Detailed" = 2),
                                                                                selected = 1,inline=T)
                                                               ),
                                                               mainPanel(
                                                                   uiOutput('printOrPlotODIWTeamPerfoverall'),
                                                                   column(7, offset=4,
                                                                          tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                                          tags$h5((tags$i("Oct 11, 2021"))),
                                                                          tags$h6("Data source Cricsheet: http://cricsheet.org/"),
                                                                          tags$a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr")
                                                                   )
                                                               )

                                                      )


                      )),

                      tabPanel("About GooglyPlusPlus 2021",h3("GooglyPlusPlus 2021 - Analyzing ODI,T20 Players, teams and matches with plots and tables"),
                               p("This Shiny app is based on my R package 'yorkr'. In this Shiny app, I use  the
                    yorkr package to analyze the performances of cricketers,teams, matches."),
                               p("GooglyPlusPlus an handle ODI (men),ODI (women), Intl T20 (men), Intl T20 (women), IPL, BBL, NTB, PSL,CPL, SSM and Women BBL"),
                               p("The R package 'yorkr' has been authored by Tinniam V Ganesh for analyzing  performances of cricketers
                    teams, individudal match, head-to-head and overall team performances"),
                               p("This Shiny app 'GooglyPlusPlus2021' has been designed and developed by  Tinniam V Ganesh,Oct 11,2021"),
                               p("This data includes the all the latest data including IPL 2020, CPL 2020, NTB 2020, BBL 2020-21,PSL 2021, SSM 2021"),
                               p("Daily updates from IPL 2021"),
                               p("The data for this Shiny app has been taken from Cricsheet - http://http://cricsheet.org/"),
                               p("More details about this app and for other posts, see my blog
                    https://gigadom.in/"),
                               a(href="https://cran.r-project.org/web/packages/yorkr/index.html", " Based on R package yorkr"),
                               h5("Please see"),
                               a(href="https://gigadom.in/2020/06/28/introducing-googlyplusplus/","How to use GooglyPlusPlus?"))


                  )))
