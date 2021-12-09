#####################################################################################################
#
# Title :  GooglyPlusPLus - An interactive app to analyze T20 and ODI matches
# Designed and developed by: Tinniam V Ganesh
# Date : 08  Nov 202
# File: printOrPlotT20BattingPerf
# More details: https://gigadom.in/
#
#########################################################################################################
printOrPlotT20BattingPerf <- function(input,output,type="IPL"){
   cat("match dir=",getwd(),"\n")

    print("Entering print plot")



    if (type == "IPL"){
      output$Mode <- renderUI({
        selectInput('runsOverSR', 'Mode',choices=runsVsSR,selected=input$runsOverSR)
      })

    } else if (type == "T20M"){
      print("T20M")
      output$ModeT20M <- renderUI({
        selectInput('runsOverSRT20M', 'Mode',choices=runsVsSR,selected=input$runsOverSRT20M)
      })

    } else if (type == "T20W"){
      print("Here111")
      output$ModeT20W <- renderUI({
        selectInput('runsOverSRT20W', 'Mode',choices=runsVsSR,selected=input$runsOverSRT20W)
      })


    } else if (type == "BBL"){
      print("BBL")
      output$ModeBBL <- renderUI({
        selectInput('runsOverSRBBL', 'Mode',choices=runsVsSR,selected=input$runsOverSRBBL)
      })


    } else if (type == "NTB"){
      print("NTB")
      output$ModeNTB <- renderUI({
        selectInput('runsOverSRNTB', 'Mode',choices=runsVsSR,selected=input$runsOverSRNTB)
      })

    } else if (type == "PSL"){
      print("PSL")
      output$ModePSL <- renderUI({
        selectInput('runsOverSRPSL', 'Mode',choices=runsVsSR,selected=input$runsOverSRPSL)
      })

    } else if (type == "WBB"){
      print("WBB")
      output$ModeWBB <- renderUI({
        selectInput('runsOverSRWBB', 'Mode',choices=runsVsSR,selected=input$runsOverSRWBB)
      })

    } else if (type == "CPL"){
      print("CPL")
      output$ModeCPL <- renderUI({
        selectInput('runsOverSRCPL', 'Mode',choices=runsVsSR,selected=input$runsOverSRCPL)
      })


    } else if (type == "SSM"){
      print("SSM")
      output$ModeSSM <- renderUI({
        selectInput('runsOverSRSSM', 'Mode',choices=runsVsSR,selected=input$runsOverSRSSM)
      })


    }

    cat("\nRank players date5=",input$dateRange5[1],"input$minMatches1=", input$minMatches1,"input$wicketsOverER=",input$wicketsOverER,"\n")
    if(is.null(input$dateRange5[1])){
      print("1")
      return
    }


    if(type == "IPL"){

          print("Date ok")
          if(input$T20BattingPerfFunc == "Overall batsmen rank")
            a <-rankT20Batsmen("./ipl/iplPerformance",input$minMatches, input$dateRange5,input$runsOverSR,"IPL")
          else if(input$T20BattingPerfFunc == "Overall Runs vs SR plot")
            a <- overallRunsSRPlotT20("./ipl/iplPerformance",input$minMatches, input$dateRange5,"IPL")
          else if(input$T20BattingPerfFunc == "Overall Runs vs SR Powerplay plot")
            a <- overallRunsSRPPowerplayPlotT20("./ipl/iplPerformance",input$dateRange5,"IPL",input$plotOrTable3)
          else if(input$T20BattingPerfFunc == "Overall Runs vs SR Middle overs plot")
            a <- overallRunsSRMiddleOversPlotT20("./ipl/iplPerformance", input$dateRange5,"IPL",input$plotOrTable3)
          else if(input$T20BattingPerfFunc == "Overall Runs vs SR Death overs plot")
            a <- overallRunsSRDeathOversPlotT20("./ipl/iplPerformance", input$dateRange5,"IPL",input$plotOrTable3)

    } else if(type == "T20M"){
      if(input$T20BattingPerfFuncT20M == "Overall batsmen rank")
        a <-rankT20Batsmen("./t20/t20Performance",input$minMatchesT20M, input$dateRange5T20M,input$runsOverSRT20M,"T20M")
      else if(input$T20BattingPerfFuncT20M == "Overall Runs vs SR plot")
        a <- overallRunsSRPlotT20("./t20/t20Performance",input$minMatchesT20M, input$dateRange5T20M,"T20M")
      else if(input$T20BattingPerfFuncT20M == "Overall Runs vs SR Powerplay plot")
        a <- overallRunsSRPPowerplayPlotT20("./t20/t20Performance",input$dateRange5T20M,"T20M",input$plotOrTable3T20M)
      else if(input$T20BattingPerfFuncT20M == "Overall Runs vs SR Middle overs plot")
        a <- overallRunsSRMiddleOversPlotT20("./t20/t20Performance", input$dateRange5T20M,"T20M",input$plotOrTable3T20M)
      else if(input$T20BattingPerfFuncT20M == "Overall Runs vs SR Death overs plot")
        a <- overallRunsSRDeathOversPlotT20("./t20/t20Performance", input$dateRange5T20M,"T20M",input$plotOrTable3T20M)

    }

   head(a)
   a
}

