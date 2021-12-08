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

    print("Entering print plot")



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

    cat("\nRank players date5=",input$dateRange5[1],"input$minMatches1=", input$minMatches1,"input$wicketsOverER=",input$wicketsOverER,"\n")
    if(is.null(input$dateRange5[1])){
        print("1")
        return
    }




    if(type == "IPL"){

        print("Date ok")
        if(input$T20PerfFunc == "IPL batsmen rank")
            a <-rankT20Bowlers("./ipl/IPLPerformance",input$minMatches, input$dateRange5,input$wicketsOverER,"IPL")
        # else if(input$T20PerfFunc == "IPL Runs vs SR plot")
        #     a <- overallRunsSRPlotT20M("./ipl/IPLPerformance",input$minMatches, input$dateRange5,"IPL",plot=1)
        # else if(input$T20PerfFunc == "IPL Runs vs SR Powerplay plot")
        #     a <- overallRunsSRPPowerplayPlotT20M("./ipl/IPLPerformance",input$dateRange5,"IPL",plot=1)
        # else if(input$T20PerfFunc == "IPL Runs vs SR Middle overs plot")
        #     a <- overallRunsSRMiddleOversPlotT20M("./ipl/IPLPerformance", input$dateRange5,"IPL",plot=1)
        # else if(input$T20PerfFunc == "IPL Runs vs SR Death overs plot")
        #     a <- overallRunsSRDeathOversPlotT20M("./ipl/IPLPerformance", input$dateRange5,"IPL",plot=1)

        head(a)
        a

    }
}
