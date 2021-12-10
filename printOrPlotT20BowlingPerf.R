#####################################################################################################
#
# Title :  GooglyPlusPLus - An interactive app to analyze T20 and ODI matches
# Designed and developed by: Tinniam V Ganesh
# Date : 08  Nov 2021
# File: printOrPlotT20BowlingPerf
# More details: https://gigadom.in/
#
#########################################################################################################
printOrPlotT20BowlingPerf <- function(input,output,type="IPL"){
    cat("match dir=",getwd(),"\n")

    print("Entering print plot bowling")



    if (type == "IPL"){

        output$Mode1 <- renderUI({
            selectInput('wicketsOverER', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverER)
        })
    } else if (type == "T20M"){
        print("T20M")

        output$Mode1T20M <- renderUI({
            selectInput('wicketsOverERT20M', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERT20M)
        })

    } else if (type == "T20W"){
        print("Here111")
        output$Mode1T20W <- renderUI({
            selectInput('wicketsOverERT20W', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERT20W)
        })

    } else if (type == "BBL"){
        print("BBL")
        output$Mode1BBL <- renderUI({
            selectInput('wicketsOverERBBL', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERBBL)
        })

    } else if (type == "NTB"){
        print("NTB")
        output$Mode1NTB <- renderUI({
            selectInput('wicketsOverERNTB', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERNTB)
        })

    } else if (type == "PSL"){
        print("PSL")

        output$Mode1PSL <- renderUI({
            selectInput('wicketsOverERPSL', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERPSL)
        })

    } else if (type == "WBB"){
        print("WBB")
        output$Mode1WBB <- renderUI({
            selectInput('wicketsOverERWBB', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERWBB)
        })

    } else if (type == "CPL"){
        print("CPL")
        output$Mode1CPL <- renderUI({
            selectInput('wicketsOverERCPL', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERCPL)
        })

    } else if (type == "SSM"){
        print("SSM")
        output$Mode1SSM <- renderUI({
            selectInput('wicketsOverERSSM', 'Mode1',choices=wicketsVsER,selected=input$wicketsOverERSSM)
        })

    }

    # cat("\nRank players date5=",input$dateRange5[1],"input$minMatches1=", input$minMatches1,"input$wicketsOverER=",input$wicketsOverER,
    #      "type=", type,"\n")
    if(is.null(input$dateRange5[1])){
        print("1")
        return
    }




    if(type == "IPL"){

        print("Date ok")
        if(input$T20BowlingPerfFunc == "Overall bowlers rank")
            a <-rankT20Bowlers("./ipl/iplPerformance",input$minMatches1, input$dateRange6,input$wicketsOverER,"IPL")
        else if(input$T20BowlingPerfFunc == "Overall Wickets vs ER plot")
             a <- overallWicketsERPlotT20("./ipl/iplPerformance",input$minMatches1, input$dateRange6,"IPL",input$plotOrTable4)
         else if(input$T20BowlingPerfFunc == "Overall Wickets vs ER Powerplay plot")
             a <- overallWicketsERPowerPlayPlotT20("./ipl/iplPerformance",input$dateRange6,"IPL",input$plotOrTable4)
         else if(input$T20BowlingPerfFunc == "Overall Wickets vs ER Middle overs plot")
             a <- overallWicketsERMiddleOversPlotT20("./ipl/iplPerformance", input$dateRange6,"IPL",input$plotOrTable4)
         else if(input$T20BowlingPerfFunc == "Overall Wickets vs ER Death overs plot")
             a <- overallWicketsERDeathOversPlotT20("./ipl/iplPerformance", input$dateRange6,"IPL",input$plotOrTable4)


    } else if (type == "T20M"){
        if(input$T20BowlingPerfFuncT20M == "Overall bowlers rank")
            a <-rankT20Bowlers("./t20/t20Performance",input$minMatches1T20M, input$dateRange6T20M,input$wicketsOverERT20M,"T20M")
        else if(input$T20BowlingPerfFuncT20M == "Overall Wickets vs ER plot")
            a <- overallWicketsERPlotT20("./t20/t20Performance",input$minMatches1T20M, input$dateRange6T20M,"T20M",input$plotOrTable4T20M)
        else if(input$T20BowlingPerfFuncT20M == "Overall Wickets vs ER Powerplay plot")
            a <- overallWicketsERPowerPlayPlotT20("./t20/t20Performance",input$dateRange6T20M,"T20M",input$plotOrTable4T20M)
        else if(input$T20BowlingPerfFuncT20M == "Overall Wickets vs ER Middle overs plot")
            a <- overallWicketsERMiddleOversPlotT20("./t20/t20Performance", input$dateRange6T20M,"T20M",input$plotOrTable4T20M)
        else if(input$T20BowlingPerfFuncT20M == "Overall Wickets vs ER Death overs plot")
            a <- overallWicketsERDeathOversPlotT20("./t20/t20Performance", input$dateRange6T20M,"T20M",input$plotOrTable4T20M)

    } else if (type == "T20W"){
        if(input$T20BowlingPerfFuncT20W == "Overall bowlers rank")
            a <-rankT20Bowlers("./t20/t20WomenPerformance",input$minMatches1T20W, input$dateRange6T20W,input$wicketsOverERT20W,"T20W")
        else if(input$T20BowlingPerfFuncT20W == "Overall Wickets vs ER plot")
            a <- overallWicketsERPlotT20("./t20/t20WomenPerformance",input$minMatches1T20W, input$dateRange6T20W,"T20W",input$plotOrTable4T20W)
        else if(input$T20BowlingPerfFuncT20W == "Overall Wickets vs ER Powerplay plot")
            a <- overallWicketsERPowerPlayPlotT20("./t20/t20WomenPerformance",input$dateRange6T20W,"T20W",input$plotOrTable4T20W)
        else if(input$T20BowlingPerfFuncT20W == "Overall Wickets vs ER Middle overs plot")
            a <- overallWicketsERMiddleOversPlotT20("./t20/t20WomenPerformance", input$dateRange6T20W,"T20W",input$plotOrTable4T20W)
        else if(input$T20BowlingPerfFuncT20W == "Overall Wickets vs ER Death overs plot")
            a <- overallWicketsERDeathOversPlotT20("./t20/t20WomenPerformance", input$dateRange6T20W,"T20W",input$plotOrTable4T20W)

    }
    head(a)
    a
}
