/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function openCalendar(target)
{
        var oldValue = document.getElementById(target).value;
        returnValue = showModalDialog( context_root+'/js/calendar.jsp', 'calendar', 'dialogWidth:170px;dialogHeight:195px;help:0;status:no;' );
        if(returnValue != null)
        {
                document.getElementById(target).value = returnValue;
        }
        else 
        {
                document.getElementById(target).value = oldValue;
        }
}