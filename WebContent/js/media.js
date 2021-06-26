// JavaScript Document

var preWidth = 320;
var preHeight = 270;

function mediaControl(media_url,media_width,media_height) {
	document.write('<OBJECT id="mediaPlayer" name="mediaPlayer" CLASSID="CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95" standby="Loading Microsoft® Windows® Media Player components..." type="application/x-oleobject" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,7,1112" width="' + media_width + '" height="' + media_height + '">');
	document.write('<PARAM NAME="filename" VALUE="' + media_url + '">');
	document.write('<PARAM NAME="autoStart" VALUE="false">');
	document.write('<PARAM NAME="showControls" VALUE="true">');
	document.write('<PARAM NAME="ShowStatusBar" value="false">');
	document.write('<PARAM NAME="Autorewind" VALUE="true">');
	document.write('<PARAM NAME="ShowDisplay" VALUE="false">');
	document.write('<EMBED NAME="mediaPlayer" SRC="' + media_url + '" type="application/x-mplayer2" pluginspage="http://www.microsoft.com/windows/windowsmedia/download/" autostart=1 showcontrols=0 showstatusbar=1 autorewind=1 showdisplay=0>');
	document.write('</EMBED>');
	document.write('</OBJECT>');
}

function mediaControlNew(media_url,media_width,media_height) {
	document.write('<!\--[if IE]>');
	document.write('<OBJECT id="mediaPlayer" type="video/x-ms-wmv" width="' + media_width + '" height="' + media_height + '" standby="window media loding" title="komipo movie">');
	document.write('<PARAM NAME="filename" VALUE="' + media_url + '">');
	document.write('<PARAM NAME="autoStart" VALUE="0">');
	document.write('<PARAM NAME="showControls" VALUE="false">');
	document.write('<PARAM NAME="ShowStatusBar" value="false">');
	document.write('<PARAM NAME="Autorewind" VALUE="true">');
	document.write('<PARAM NAME="ShowDisplay" VALUE="false">');
	document.write('</OBJECT>');
	document.write('<![endif]\-->');
	document.write('<!--[if !IE]> <\-->');
	document.write('<object type="video/x-ms-asf-plugin" data="mms://'+media_url+'" width="'+media_width+'" height="'+media_height+'"></object>');
	document.write('<\!--><![endif]\-->');
}

function mediaControlNew1(media_url,media_width,media_height) {
	var movieHtml	= "";
	if(navigator.userAgent.indexOf('MSIE')> 0){

		movieHtml	+= "				<object id=\"mediaplayer\" type=\"video/x-ms-wmv\" width=\""+media_width+"\" height=\""+media_height+"\" standby=\"window media loding\" title=\"komipo movie\">";
		movieHtml	+= "					<param name=\"filename\" value=\"" + media_url + ".wmv\" />";
		movieHtml	+= "					<param name=\"AutoStart\" value=\"0\" />";
		movieHtml	+= "					<param name=\"showcontrols\" value=\"true\" />";
		movieHtml	+= "					<param name=\"showaudiocontrols\" value=\"true\" />";
		movieHtml	+= "					<param name=\"wmode\" value=\"Opaque\" />";
		movieHtml	+= "					<param name=\"windowlessvideo\" value=\"1\" />";
		movieHtml	+= "					<!\--[if !IE]>";
		movieHtml	+= "					<object  type=\"application/x-mplayer2\" width=\""+media_width+"\" height=\""+media_height+"\" data=\"" + media_url + ".wmv\">";
		movieHtml	+= "					<param name=\"filename\" value=\"" + media_url + ".wmv\" />";
		movieHtml	+= "					<param name=\"AutoStart\" value=\"1\" />";
		movieHtml	+= "					<param name=\"showcontrols\" value=\"false\" />";
		movieHtml	+= "					<param name=\"showaudiocontrols\" value=\"true\" />";
		movieHtml	+= "					<param name=\"wmode\" value=\"Opaque\" />";
		movieHtml	+= "					<param name=\"windowlessvideo\" value=\"1\" />";
		movieHtml	+= "					<p style=\"text-align:center\">     window media player download   </p>";
		movieHtml	+= "					</object>";
		movieHtml	+= "					<![endif]\-->";
		movieHtml	+= "				</object>";

	}else{
		movieHtml	+= "				<video id=\"videoControl\" controls width=\""+media_width+"\" height=\""+media_height+"\">";
		movieHtml	+= "					<source src=\""+ media_url +".ogv\" type=\"video/ogg;\">";
		movieHtml	+= "					<source src=\"" + media_url + ".mp4\" type=\"video/mp4;\">";
		movieHtml	+= "					this browser is not play";
		movieHtml	+= "				</video>";
	}
	document.getElementById("movie").innerHTML = movieHtml;
}

function mediaControlNew2(media_url,media_width,media_height) {

	if(navigator.userAgent.indexOf('MSIE')> 0){

		document.write("				<object id=\"mediaPlayer\" type=\"video/x-ms-wmv\" width=\""+media_width+"\" height=\""+media_height+"\" standby=\"window media loding\" title=\"komipo movie\">");
		document.write("					<param name=\"filename\" value=\"" + media_url + ".wmv\" />");
		document.write("					<param name=\"AutoStart\" value=\"0\" />");
		document.write("					<param name=\"showcontrols\" value=\"true\" />");
		document.write("					<param name=\"showaudiocontrols\" value=\"true\" />");
		document.write("					<param name=\"wmode\" value=\"Opaque\" />");
		document.write("					<param name=\"windowlessvideo\" value=\"1\" />");
		document.write("					<!\--[if !IE]>");
		document.write("					<object  type=\"application/x-mplayer2\" width=\""+media_width+"\" height=\""+media_height+"\" data=\"" + media_url + ".wmv\">");
		document.write("					<param name=\"filename\" value=\"" + media_url + ".wmv\" />");
		document.write("					<param name=\"AutoStart\" value=\"1\" />");
		document.write("					<param name=\"showcontrols\" value=\"false\" />");
		document.write("					<param name=\"showaudiocontrols\" value=\"true\" />");
		document.write("					<param name=\"wmode\" value=\"Opaque\" />");
		document.write("					<param name=\"windowlessvideo\" value=\"1\" />");
		document.write("					<p style=\"text-align:center\">     window media player download  </p>");
		document.write("					</object>");
		document.write("					<![endif]\-->");
		document.write("				</object>");

	}else{
		document.write("				<video id=\"videoControl\" controls width=\""+media_width+"\" height=\""+media_height+"\">");
		document.write("					<source src=\""+ media_url +".ogv\" type=\"video/ogg;\">");
		document.write("					<source src=\"" + media_url + ".mp4\" type=\"video/mp4;\">");
		document.write("					this browser is not play");
		document.write("				</video>");
	}
}

function mediaPlay(){
	document.getElementById("mediaPlayer").play();
}

function mediaStop(){
	if (document.getElementById("mediaPlayer").PlayState == 2) {
	    document.getElementById("mediaPlayer").stop();
	}
}

function mediaPause(){
    document.getElementById("mediaPlayer").pause();
}

function mediaChange(media_url){
	mediaStop();
//	document.getElementById("mediaPlayer").filename = media_url;
//	document.getElementById("mediaPlayer").src = media_url;

	var tmpUrl1	= media_url + ".wmv";
	var tmpUrl2	= media_url + ".ogv";

    document.getElementById("mediaPlayer").filename = tmpUrl1;
    document.getElementById("mediaPlayer").src = tmpUrl1;
    document.getElementById("videoControl").src = tmpUrl2;
//	mediaPlay();
}

function size100(){
	preWidth = 352;
	preHeight = 264;
	document.getElementById("mediaPlayer").width = 352;
	document.getElementById("mediaPlayer").height = 264;
	document.getElementById("mediaPlayer").DisplaySize = 0;
	self.resizeTo(450,465);
}

function size200(){
	preWidth = 640;
	preHeight = 480;
	document.getElementById("mediaPlayer").width = 640;
	document.getElementById("mediaPlayer").height = 480;
	document.getElementById("mediaPlayer").DisplaySize = 4;
	self.resizeTo(730, 680);
}


function fullsize(){
	document.getElementById("mediaPlayer").width = preWidth;
	document.getElementById("mediaPlayer").height = preHeight;
	document.getElementById("mediaPlayer").DisplaySize = 3;
	document.getElementById("mediaPlayer").FullScreen = true;
	self.resizeTo(preWidth + 75, preHeight + 170);
}																																																																																																																																																																																																																																																																																																																																																																												

