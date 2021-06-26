/* for IE */

if (!Element.prototype.addEventListener) {

 Element.prototype.addEventListener = function(event_name, func) {

  event_name = "on" + event_name;

  this.attachEvent(event_name,func);

 }

}



