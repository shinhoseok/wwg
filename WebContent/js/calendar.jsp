<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
String _context_root = "";
String img_url = _context_root+"/images";
%>
<HTML>
    <HEAD>
    <TITLE>달력</TITLE>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <STYLE TYPE="text/css">
    BODY
    {
        font-family : "verdana"
        font-size: 9pt;
    }

    SELECT, TEXTAREA
    {
        font-family : "verdana"
        border-width    :1px;
        font-size       :9pt;^
    }

    A, INPUT
    {
        font-family : "verdana"
        border-width    :0px;
        font-size       :9pt;
        cursor:hand;
    }
    </STYLE>

    <SCRIPT LANGUAGE="JavaScript">
    function setDate()
    {
        this.inDate = window.dialogArguments;
        if( this.inDate == null )
        {
            setToday();
            return;
        }

        // SET DAY MONTH AND YEAR TO TODAY'S DATE
        var now   = new Date();
        var day   = now.getDate();
        var month = now.getMonth();
        var year  = now.getYear();

        if( year < 2000 )
            year += 1900;

        // IF A DATE WAS PASSED IN THEN PARSE THAT DATE
        if( inDate.indexOf('/') )
        {
            var inYear = inDate.substring(0,inDate.indexOf("/"));
                if (inYear.substring(0,1) == "0" && inYear.length > 1)
                    inYear = inYear.substring(1,inYear.length);
                inYear = parseInt(inYear);

            var inMonth   = inDate.substring(inDate.indexOf("/") + 1, inDate.lastIndexOf("/"));
                if (inMonth.substring(0,1) == "0" && inMonth.length > 1)
                    inMonth = inMonth.substring(1,inMonth.length);
                inMonth = parseInt(inMonth);

            var inDay  = parseInt(inDate.substring(inDate.lastIndexOf("/") + 1, inDate.length));

            if (inDay)
                day = inDay;

            if (inMonth)
                month = inMonth-1;

            if (inYear)
                year = inYear;
        }

        this.focusDay                               = day;
        document.all.calControl.month.selectedIndex = month;
        document.all.calControl.year.value          = year;
        displayCalendar(day, month, year);
    }

    function setToday()
    {
        // SET DAY MONTH AND YEAR TO TODAY'S DATE
        var now   = new Date();
        var day   = now.getDate();
        var month = now.getMonth();
        var year  = now.getYear();

        if (year < 2000)
            year += 1900;

        this.focusDay                               = day;
        document.all.calControl.month.selectedIndex = month;
        document.all.calControl.year.value          = year;
        displayCalendar(day, month, year);
    }

    function isFourDigitYear(year)
    {
        if( year.length != 4 )
        {
            alert( "일자란을 지우고 달력버튼을 클릭하십시요!" );
            document.calControl.year.select();
            document.calControl.year.focus();
        }
        else
            return true;
    }

    function selectDate()
    {
        var year  = document.calControl.year.value;

        if (isFourDigitYear(year))
        {
            var day   = 0;
            var month = document.calControl.month.selectedIndex;
            displayCalendar(day, month, year);
        }
    }

    function setPreviousYear()
    {
        var year  = document.calControl.year.value;

        if (isFourDigitYear(year))
        {
            var day   = 0;
            var month = document.calControl.month.selectedIndex;
            year--;
            document.calControl.year.value = year;
            displayCalendar(day, month, year);
        }
    }

    function setPreviousMonth()
    {
        var year  = document.calControl.year.value;

        if (isFourDigitYear(year))
        {
            var day   = 0;
            var month = document.calControl.month.selectedIndex;

            if (month == 0)
            {
                month = 11;
                if (year > 1000)
                {
                    year--;
                    document.calControl.year.value = year;
                }
            }
            else
            {
                month--;
            }
            document.calControl.month.selectedIndex = month;
            displayCalendar(day, month, year);
        }
    }

    function setNextMonth()
    {
        var year  = document.calControl.year.value;

        if (isFourDigitYear(year))
        {
            var day   = 0;
            var month = document.calControl.month.selectedIndex;
            if (month == 11)
            {
                month = 0;
                year++;
                document.calControl.year.value = year;
            }
            else
            {
                month++;
            }
            document.calControl.month.selectedIndex = month;
            displayCalendar(day, month, year);
        }
    }

    function setNextYear()
    {
        var year  = document.calControl.year.value;
        if (isFourDigitYear(year))
        {
            var day   = 0;
            var month = document.calControl.month.selectedIndex;
            year++;
            document.calControl.year.value = year;
            displayCalendar(day, month, year);
        }
    }

    function displayCalendar(day, month, year)
    {

        day     = parseInt(day);
        month   = parseInt(month);
        year    = parseInt(year);
        var i   = 0;
        var now = new Date();

        if (day == 0) {
            var nowDay = now.getDate();
        }
        else {
            var nowDay = day;
        }
        var days         = getDaysInMonth(month+1,year);
        var firstOfMonth = new Date (year, month, 1);
        var startingPos  = firstOfMonth.getDay();
        days += startingPos;

        // MAKE BEGINNING NON-DATE BUTTONS BLANK
        for (i = 0; i < startingPos; i++) {
            document.calButtons.elements[i].value = "   ";
        }

        // SET VALUES FOR DAYS OF THE MONTH
        for (i = startingPos; i < days; i++)
        {
            document.calButtons.elements[i].value = i-startingPos+1;
            // ?? document.calButtons.elements[i].onClick = "returnDate"
        }

        // MAKE REMAINING NON-DATE BUTTONS BLANK
        for (i=days; i<42; i++)
            document.calButtons.elements[i].value = "   ";

        // GIVE FOCUS TO CORRECT DAY
        document.calButtons.elements[focusDay+startingPos-1].focus();
    }

    // GET NUMBER OF DAYS IN MONTH
    function getDaysInMonth(month,year)
    {
        var days;
        if (month==1 || month==3 || month==5 || month==7 || month==8 ||
            month==10 || month==12)  days=31;
        else if (month==4 || month==6 || month==9 || month==11) days=30;
        else if (month==2)  {
            if (isLeapYear(year)) {
                days=29;
            }
            else {
                days=28;
            }
        }
        return (days);
    }

    // CHECK TO SEE IF YEAR IS A LEAP YEAR
    function isLeapYear (Year)
    {
        if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0)) {
            return (true);
        }
        else {
            return (false);
        }
    }

    // SET FORM FIELD VALUE TO THE DATE SELECTED
    function returnDate(inDay)
    {
		var day   = inDay;
        var month = (document.calControl.month.selectedIndex)+1;
        var year  = document.calControl.year.value;

        if( (""+month).length == 1)
        {
            month = "0"+month;
        }
        if( (""+day).length == 1)
        {
            day = "0"+day;
        }
        if( day != "   " )
        {
            window.returnValue = year + "-" + month + "-" + day;
            window.close();
        }
    }
    </SCRIPT>
</HEAD>

<BODY ONLOAD=setDate()>
<CENTER>
    <TABLE CELLPADDING=0 CELLSPACING=0 border=0 width=203>
	 <TR>
            <FORM NAME="calControl" onSubmit="return false;">
                <TD align="center" valign=middle style='background-color:#EAF1FB; height:23px;'>
                        <IMG SRC='<%=img_url%>/cm/cal/left_double_arrow.gif' onClick="setPreviousYear()" border=0 style="cursor:hand">
                        <IMG SRC='<%=img_url%>/cm/cal/right_double_arrow.gif' onClick="setNextYear()" border=0 style="cursor:hand">
                        <INPUT NAME="year" style='border-width:0px;' TYPE=TEXT SIZE=4 MAXLENGTH=4 onChange="selectDate()" readonly>
                        <font style='font:9pt'>년</font>

                        <SELECT NAME="month" onChange='selectDate()'>
                           <OPTION>&nbsp;1월
                           <OPTION>&nbsp;2월
                           <OPTION>&nbsp;3월
                           <OPTION>&nbsp;4월
                           <OPTION>&nbsp;5월
                           <OPTION>&nbsp;6월
                           <OPTION>&nbsp;7월
                           <OPTION>&nbsp;8월
                           <OPTION>&nbsp;9월
                           <OPTION>10월
                           <OPTION>11월
                           <OPTION>12월
                        </SELECT>
                        <IMG SRC='<%=img_url%>/cm/cal/left_double_arrow.gif' onClick="setPreviousMonth()" border=0 style="cursor:hand">
                        <IMG SRC='<%=img_url%>/cm/cal/right_double_arrow.gif' onClick="setNextMonth()" border=0 style="cursor:hand">
                </TD>
            </FORM>
	</TR>
        <TR height=130>
            <TD height="100" align=center valign=top>
                <FORM NAME="calButtons">
                    <table width="203" border="0" cellpadding="1" cellspacing="1" bgcolor = "#ccccccc">

                        <tr align="center" valign="middle">
                            <td width="15" bgcolor = "#FD7B97" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>日</b></font></td>
                            <td width="15" bgcolor = "#929292" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>月</b></font></td>
                            <td width="15" bgcolor = "#929292" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>火</b></font></td>
                            <td width="15" bgcolor = "#929292" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>水</b></font></td>
                            <td width="15" bgcolor = "#929292" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>木</b></font></td>
                            <td width="15" bgcolor = "#929292" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>金</b></font></td>
                            <td width="15" bgcolor = "#3592CF" align='center' valign='middle'><font face='verdana,arial,helvetica' size="2" color="#ffffff"">&nbsp;<b>土</b></font></td>
                        </tr>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but0" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but1" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but2" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but3" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but4" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but5" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but6" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>

                        </TR>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but7"" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but8"" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but9"" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but10" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but11" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but12" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but13" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>

                        </TR>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but14" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but15" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but16" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but17" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but18" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but19" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but20" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>

                        </TR>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but21" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but22" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but23" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but24" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but25" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but26" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but27" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>

                        </TR>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but28" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but29" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but30" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but31" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but32" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but33" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but34" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                        </TR>
                        <TR>
                            <TD bgcolor = "#ffffff"><input type="button" name="but35" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but36" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but37" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but38" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but39" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but40" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                            <TD bgcolor = "#ffffff"><input type="button" name="but41" onClick="returnDate(this.value)" value="  " style="width:20;height:19;color:black; background-color:white; border-color:white; border-style:none;"></TD>
                        </TR>

                    </TABLE>
                </FORM>
            </TD>
        </TR>
    </TABLE>
</CENTER>
</BODY>
</HTML>
