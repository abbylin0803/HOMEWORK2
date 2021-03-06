Attribute VB_Name = "Module1"
Sub Stockdata()

Dim WS As Worksheet
    For Each WS In ActiveWorkbook.Worksheets
    WS.Activate
Dim worksheetname As String
    worksheetname = WS.Name
    

'set varaible
Dim tickername As String
Dim yearchange As Double
Dim percentchange As Double
Dim totalvolume As Double
Dim i As Long
Dim tabtlerow As Double
Dim openprice As Double
Dim closeprice As Double


Range("I1").Value = "Ticker"
Range("J1").Value = "Yearly Change"
Range("K1").Value = "Percent Change"
Range("L1").Value = "Total Stock Volume"
Range("P1").Value = "Ticker"
Range("Q1").Value = "Value"
Range("O2").Value = "Greatest % Increase"
Range("O3").Value = "Greatest % Decrease"
Range("O4").Value = "Greatest Total Volume"



'set the row count
RowCount = WS.Cells(Rows.Count, 1).End(xlUp).Row

'set the default starting value
totalvolume = 0
tablerow = 2
openprice = WS.Cells(2, 3).Value


'create a loop
For i = 2 To RowCount

'see if the next ticker is the same or not.
'now it's when next ticker is  different
'Tickername=9, yearchange =10, % =11, totalvolume = 12



If WS.Cells(i + 1, 1).Value <> WS.Cells(i, 1).Value Then

'set tickername in table
tickername = WS.Cells(i, 1).Value
WS.Cells(tablerow, 9).Value = tickername

'set closeprice
closeprice = WS.Cells(i, 6).Value

'set yearchange in table
yearchange = closeprice - openprice
WS.Cells(tablerow, 10).Value = yearchange

'set % change
'when there is zero

If (openprice = 0 And closeprice = 0) Then
percentchange = 0
ElseIf (openprice = 0 And closeprice <> 0) Then
percentchange = 1
Else

'when there is no zero in the value
percentchange = yearchange / openprice
WS.Cells(tablerow, 11).Value = percentchange
WS.Cells(tablerow, 11).NumberFormat = "0.00%"
 
End If
 
'set totalvolume
totalvolume = totalvolume + WS.Cells(i, 7).Value
WS.Cells(tablerow, 12).Value = totalvolume

'since ticker is a different one, gotta move to another row to print so
tablerow = tablerow + 1
totalvolume = 0

'but if the next ticker is the same, keep adding then
Else

totalvolume = totalvolume + WS.Cells(i, 7).Value



End If

Next i

'set color

tablelastrow = WS.Cells(Rows.Count, 10).End(xlUp).Row
For j = 2 To tablelastrow
            If (WS.Cells(j, 10).Value > 0 Or WS.Cells(j, 10).Value = 0) Then
                WS.Cells(j, 10).Interior.ColorIndex = 10
            ElseIf WS.Cells(j, 10).Value < 0 Then
                WS.Cells(j, 10).Interior.ColorIndex = 3
            End If
        Next j


Next WS



End Sub



