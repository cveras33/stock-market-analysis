Attribute VB_Name = "Module1"
Sub VBA_Stocks():
    
    For Each ws In Worksheets
    
        ' Variable to store the last row
        Dim last_row As Long
        
        ' Determining the last row -- WASN'T WORKING PROPERLY
        last_row = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        ' Variable to store the current volume, which can either be added to or outputted per ticker
        Dim volume As Long
        
        ' Varaible to store the ticker symbol which will then be outputted
        Dim ticker As String
        
        ' Variable to store yearly change
        Dim yearly_change As Double
        
        'Variable to store percent change
        Dim percent_change As Double
        
        ' Variable to store opening value, and setting that value to 0
        Dim opening_value As Double
        opening_value = 0
        
        ' Variable to store closing value, and setting that value to 0
        Dim closing_value As Double
        closing_value = 0
        
        'Variable for specifying column of interest
        Dim column As Integer
        column = 1
        
        ' Variable for location of outputs such as ticker, yearly change, % change & total stock vol.
        Dim output_row As Integer
        output_row = 2
        
        ' This prevents my overflow error -- found this code suggestion online, and it fixes the bug I was getting but still unsure if its
        ' allowing my code to work 100% properly
        On Error Resume Next
        
        ' Looping variable
        Dim i As Long
        
        ws.Range("I1").Value = "Ticker"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("L1").Value = "Total Stock Volume"
        
        ' Looping through every row (70926 rows)
        For i = 2 To last_row
        
            ' Get opening value for the year of each ticker
            'If opening_value = 0 Then
            
            '    opening_value = Cells(i, 3).Value
            
            'End If
        
            ' Determining if the ticker has changed and if it has:
            If ws.Cells(i + 1, column).Value <> ws.Cells(i, column).Value Then
                 
                ' Set the ticker
                ticker = ws.Cells(i, 1).Value
                     
                ' Print ticker symbol into appropriate row
                ws.Range("I" & output_row).Value = ticker
                     
                ' Add to the volume
                volume = volume + ws.Cells(i, 7).Value
                      
                ' Print volume sum
                ws.Range("L" & output_row).Value = volume
                
                ' Get opening price for the year of each ticker
                If opening_value = 0 Then
                
                    opening_value = ws.Cells(i, 3).Value
                
                End If
                
                ' Get closing price
                closing_value = ws.Cells(i, 6).Value
                
                ' Calculating Yearly Change
                yearly_change = closing_value - opening_value
                
                ' Print yearly change
                ws.Range("J" & output_row).Value = yearly_change
                
                ' Formatting yearly change.
                ' Positive values will be filled green
                If yearly_change > 0 Then
                
                    ws.Range("J" & output_row).Interior.ColorIndex = 4
                
                ' Negative values will be filled red
                Else
                
                    ws.Range("J" & output_row).Interior.ColorIndex = 3
                
                End If
                
                ' Calculate percent change
                percent_change = (yearly_change / Abs(opening_value)) * 100
                
                ' Print percent change
                ws.Range("K" & output_row).Value = percent_change
                
                     
                ' Increment output_row
                output_row = output_row + 1
                     
                ' Reset volume sum
                volume = 0
            
            Else
                ' Add to volume sum -- GETTING BUG HERE (fixed this bug with 'on error resume next' above)
                volume = volume + ws.Cells(i, 7).Value
                
                ' Add to closing value
                closing_value = closing_value + ws.Cells(i, 6).Value
                
            End If
        
        Next i
        
        ' Formating
        ' positive / negative (from checker board example)
        ' percentages (from wells_fargo example -- similar to how currency was formatted)

    Next ws

End Sub
