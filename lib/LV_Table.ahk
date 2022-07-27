LV_Table(Data_Source, delimiter="`t",UseHeader=1,Title=""){ ; default delimiter set to tab
if FileExist(Data_Source) ;if file exists use it as source
	FileRead, Data_Source, %Data_Source% ;read in and store as variable

;***********parse the data in variable and store in object******************* 
data_obj := StrSplit(Data_Source,"`n","`r") ;parse earch row and store in object
rowHeader:=StrReplace(data_obj.RemoveAt(1),Delimiter,"|",Numb_Columns) ; Remove header from Object and convert to pipe delimited
if (useHeader=0){
	loop, % Numb_Columns
		RH.="Col_" A_Index "|"
	rowHeader:=RH
}

dCols:= (Numb_Columns<10) ? 400: ((Numb_Columns<80) ? 650 : 1100) ;if cols <10 use 400; if cols <80 use 650 ; else use 1100
dRows:= (data_obj.MaxIndex() >27) ? 26 : data_obj.MaxIndex() ;if rows >27 use 26 else use # of rows
Gui, Table_View: New,,%Title% ;create new gui window and set title
Gui, Add, ListView, w%dCols% r%dRows% grid, % rowHeader ;set headers

For Each, Row In data_obj ;add the data lines to the ListView
   LV_Add("", StrSplit(Row, Delimiter)*) ;LV_Add is a variadic function

Gui, Table_View:Show
return
}