<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.nio.file.Files, java.nio.file.Paths, java.awt.Color, java.awt.image.BufferedImage, java.io.*, javax.imageio.*, java.io.FileInputStream, java.util.ArrayList, java.net.URL, java.io.DataInputStream, java.io.InputStream, java.io.InputStreamReader, java.io.File, java.io.BufferedReader, java.net.URLConnection, java.io.BufferedInputStream, java.security.*, java.net.*, java.util.*, java.util.concurrent.ConcurrentHashMap, java.util.Locale, java.text.DateFormat, java.text.NumberFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Clark Taylor</title>
<style>
html, body
{
	opacity: 1.0;
	transition: background 3000ms linear, color 3000ms linear;
}

h1
{
	font-size: xx-large;
	font-weight: bold;
}

#bodydiv
{
	opacity: 0.0;
	width: 0;
	transition: width 3000ms linear, opacity 3000ms linear, background-color 3000ms linear, color 3000ms linear;
}

#naviDiv
{
	opacity: 0.0;
	width: 60%;
	transition: width 3000ms linear, opacity 3000ms linear, background-color 3000ms linear, color 3000ms linear;
	margin: 1em 1em 1em 1em;
	padding-top: .5em;
	padding-bottom: .5em;
}

.naviCell
{
	transition: width 1500ms linear, opacity 1500ms linear, background-color 1500ms linear, color 1500ms linear;
}

#contentDiv
{
	opacity: 0.0;
	width: 60%;
	transition: width 3000ms linear, opacity 3000ms linear, background-color 3000ms linear, color 3000ms linear;
	margin: 1em 1em 1em 1em;
	padding-top: .5em;
	padding-bottom: .5em;
}

.highlighted
{
	color: #9e0000;
}

.selectable
{
	cursor: pointer;
}

#contentTitle
{
	color: red;
}

#titleDiv
{
	padding: 1em 1em 1em 1em;
}

#titleText
{
	/* Thanks to https://css-tricks.com/snippets/css/typewriter-effect/ for this effect */
	overflow: hidden;
	border-right: .15em solid orange;
	white-space: nowrap;
	margin: 0 auto;
	letter-spacing: .15em;
	opacity: 0.0;
	/*animation: typing 3000ms steps(40, end), blink-caret 1000ms step-end infinite;*/
}

@keyframes typing
{
	from { width: 0 }
	to { width: 100% }
}

@keyframes blink-caret
{
	from, to { border-color: transparent }
	50% { border-color: red; }
}
</style>
</head>
<body>
<div align="center">
<div id="bodydiv" align="center" style="width:0; opacity:0.0;">
<div id="titleDiv" align="center" style="display: inline-block;">
<h1 id="titleText">Clark Taylor</h1>
</div>
</div>
<div id="naviDiv" align="center">
<%
ServletContext sc=getServletContext();
String reportPath=sc.getRealPath("/pages/");
File myFile = new File(reportPath);
String[] fileList = myFile.list();
HashMap fileTitles = new HashMap();
HashMap fileContents = new HashMap();
for(int x=0; x<fileList.length; x++)
{
	String path = reportPath + "/" + fileList[x];
	byte[] encoded = Files.readAllBytes(Paths.get(path));
	String contents = new String(encoded);
	Scanner scanner = new Scanner(contents);
	String position = scanner.nextLine();
	String title = scanner.nextLine();
	String display = "";
	while(scanner.hasNextLine())
	{
		display += scanner.nextLine() + "\n";
	}
	scanner.close();
	int positionInt = new Integer(position);
	fileTitles.put(positionInt, title);
	fileContents.put(positionInt, display);
}
double widths = 100.0/(double)fileTitles.size();
%>
<table width="100%">
<tr>
<%
for(int x=0; x<fileTitles.size(); x++)
{
	String highlighted = " highlighted";
	String style = "";
	String onclick = "showDocument(this, '" + fileTitles.get(x) + "');";
	if(x == 0)
	{
		style = "color: red; font-weight: bold; border-right-color: inherit; border-right-width: thin; border-right-style: solid;";
	}
	else if(x + 1 == fileTitles.size())
	{
		highlighted = "";
		style = "border-left-color: inherit; border-left-width: thin; border-left-style: solid;";
	}
	else
	{
		highlighted = "";
		style = "border-right-color: inherit; border-right-width: thin; border-right-style: solid; border-left-color: inherit; border-left-width: thin; border-left-style: solid;";
	}
%>
<td onclick="<%=onclick %>" class="selectable naviCell<%=highlighted %>" width="<%=widths %>%" style="<%=style %>">
<div align="center">
<%=fileTitles.get(x) %>
</div>
</td>
<%
}
%>
</tr>
</table>
</div>
<div id="contentDiv" align="center">
<h2 id="contentTitle" class="highlighted"><%=fileTitles.get(0) %></h2>
<div id="theContent" width="90%" style="width: 90%;" align="justify">
<%=fileContents.get(0) %>
</div>
<h6>&nbsp;</h6>
</div>
</div>
</body>

<%
for(int x=0; x<fileContents.size(); x++)
{
%>
<script id="_content_<%=fileTitles.get(x) %>" type="text/plain">
<%=fileContents.get(x) %>
</script>
<%
}
%>

<script>

var darkBackground = true;
var darkHighlighted = "#ef1010";
var lightHighlighted = "#ff2b2b";

function updateLinkColors()
{
	var links = document.getElementsByTagName("a");
	for(var i=0;i<links.length;i++)
	{
		if(links[i].href)
		{
			if(darkBackground)
			{
				links[i].style.color = lightHighlighted; 
			}
			else
			{
				links[i].style.color = darkHighlighted; 
			} 
		}
	}
}

var curBackground = "000000";

function showDocument(element, title)
{
	var text = document.getElementById("_content_" + title).innerHTML;
	document.getElementById("contentDiv").style.transition = "width 3000ms linear, opacity 250ms linear, background-color 3000ms linear, color 3000ms linear;";
	document.getElementById("contentDiv").style.opacity = 0.0;
	setTimeout(function ()
	{
		document.getElementById("contentDiv").style.opacity = 1.0;
		document.getElementById("contentTitle").innerHTML = title;
		document.getElementById("theContent").innerHTML = text;
		updateLinkColors();
	}, 2000);
	
	var oldSelected = document.getElementsByClassName("naviCell highlighted");
	for(var x=0; x < oldSelected.length; x++)
	{
		oldSelected[x].style.borderRightColor = invertColor(curBackground, true);
		oldSelected[x].style.borderLeftColor = invertColor(curBackground, true);
		oldSelected[x].style.borderTopColor = invertColor(curBackground, true);
		oldSelected[x].style.borderBottomColor = invertColor(curBackground, true);
		oldSelected[x].style.color = invertColor(curBackground, true);
		oldSelected[x].style.fontWeight = "normal";
	}
	for(var x=0; x < oldSelected.length; x++)
	{
		oldSelected[x].classList.remove("highlighted");
	}
	
	element.classList.add("highlighted");
	
	var toColor = "red";
	if(darkBackground)
	{
		toColor = lightHighlighted;
	}
	else
	{
		toColor = darkHighlighted;
	}
	var highlightedCells = document.getElementsByClassName("highlighted");
	for(var x=0; x < highlightedCells.length; x++)
	{
		highlightedCells[x].style.borderRightColor = toColor;
		highlightedCells[x].style.borderLeftColor = toColor;
		highlightedCells[x].style.borderTopColor = toColor;
		highlightedCells[x].style.borderBottomColor = toColor;
		highlightedCells[x].style.color = toColor;
		highlightedCells[x].style.fontWeight = "bold";
	}
	updateLinkColors();
}

function mouseOver(element)
{
	/*
	element.style.borderLeftWidth = "medium";
	element.style.borderRightWidth = "medium";
	element.style.borderTopWidth = "thin";
	element.style.borderBottomWidth = "thin";
	element.style.borderLeftStyle = "solid";
	element.style.borderRightStyle = "solid";
	element.style.borderTopStyle = "solid";
	element.style.borderBottomStyle = "solid";
	*/
	element.style.outlineStyle = "solid";
	element.style.outlineWidth = "thin";
}

function mouseOut(element)
{
	element.style.outlineStyle = "none";
	element.style.outlineWidth = "thin";
	/*
	element.style.borderLeftWidth = "thin";
	element.style.borderRightWidth = "thin";
	element.style.borderTopWidth = "thin";
	element.style.borderBottomWidth = "thin";
	element.style.borderTopStyle = "none";
	element.style.borderBottomStyle = "none";
	if(element.cellIndex == 0)
	{
		element.style.borderLeftStyle = "none";
	}
	if(element.cellIndex + 1 == element.parentNode.cells.length)
	{
		element.style.borderRightStyle = "none";
	}
	*/
}

function padZero(str, len)
{
	len = len || 2;
	var zeros = new Array(len).join('0');
	return (zeros + str).slice(-len);
}

function invertColor(hex, bw)
{
	bw = false;
	if (hex.indexOf('#') === 0) {
	    hex = hex.slice(1);
	}
	// convert 3-digit hex to 6-digits.
	if (hex.length === 3) {
	    hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
	}
	if (hex.length !== 6) {
	    throw new Error('Invalid HEX color.');
	}
	var r = parseInt(hex.slice(0, 2), 16),
	    g = parseInt(hex.slice(2, 4), 16),
	    b = parseInt(hex.slice(4, 6), 16);
	
	
	if (bw) {
	    // http://stackoverflow.com/a/3943023/112731
	    return (r * 0.299 + g * 0.587 + b * 0.114) > 186
	        ? '#000000'
	        : '#FFFFFF';
	}
	
	
	// invert color components
	r = (255 - r);
	g = (255 - g);
	b = (255 - b);
	
	var sum = r + g + b;
	if(sum > (255 * 3) / 2)
	{
		var max = r;
		if(g > max)
		{
			max = g;
		}
		if(b > max)
		{
			max = b;
		}
		if(max < 225)
		{
			var diff = 225 - max;
			r += diff;
			g += diff;
			b += diff;
		}
	}
	else
	{
		var min = r;
		if(g < min)
		{
			min = g;
		}
		if(b < min)
		{
			min = b;
		}
		if(min > 50)
		{
			r -= min;
			g -= min;
			b -= min;
		}
	}
	
	r = r.toString(16);
	g = g.toString(16);
	b = b.toString(16);
	
	// pad each with zeros and return
	return "#" + padZero(r) + padZero(g) + padZero(b);
}

function hexToRgbA(hex, alpha)
{
	var c;
	if(/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex))
	{
		c= hex.substring(1).split('');
		if(c.length== 3){
		    c= [c[0], c[0], c[1], c[1], c[2], c[2]];
		}
		c= '0x'+c.join('');
		var r = (c>>16)&255;
		var g = (c>>8)&255
		var b = c&255;
		
		var sum = r + g + b;
		if(sum > (255 * 3) / 2)
		{
			darkBackground = false;
			var max = r;
			if(g > max)
			{
				max = g;
			}
			if(b > max)
			{
				max = b;
			}
			if(max < 225)
			{
				var diff = 225 - max;
				r += diff;
				g += diff;
				b += diff;
			}
		}
		else
		{
			darkBackground = true;
			var min = r;
			if(g < min)
			{
				min = g;
			}
			if(b < min)
			{
				min = b;
			}
			if(min > 50)
			{
				r -= min;
				g -= min;
				b -= min;
			}
		}
		
		return 'rgba('+[r, g, b].join(',')+', ' + alpha + ')';
	}
	throw new Error('Bad Hex');
}

var started = false;

function reqListener()
{
	var responses = this.responseText.split("\n");
	var downloadingImage = new Image();
	downloadingImage.onload = function()
	{
		setBackground(responses[0], responses[1]);
	};
	downloadingImage.src = "backgroundImages/" + responses[0];
}

function setBackground(image, color)
{
	curBackground = color;
	document.body.style.backgroundSize = "100% auto";
	document.body.style.backgroundAttachment = "fixed";
	document.body.style.backgroundRepeat = "no-repeat";
	document.body.style.backgroundPosition = "center center";
	document.body.style.backgroundImage = "url('backgroundImages/" + image + "')";
	document.body.style.backgroundColor = "#" + color;
	//document.getElementById("bodydiv").style.backgroundColor = "#" + color;
	document.getElementById("bodydiv").style.color = invertColor(color, true);
	document.getElementById("bodydiv").style.backgroundColor = hexToRgbA("#" + color, 0.9);
	
	var selectableCells = document.getElementsByClassName("selectable");
	for(var x=0; x < selectableCells.length; x++)
	{
		selectableCells[x].style.cursor = "pointer";
		selectableCells[x].onmouseover = function(){ mouseOver(this); };
		selectableCells[x].onmouseout = function(){ mouseOut(this); };
	}
	
	var toColor = "red";
	if(darkBackground)
	{
		toColor = lightHighlighted;
	}
	else
	{
		toColor = darkHighlighted;
	}
	document.getElementById("titleText").style.borderRightColor = toColor;
	
	if(!started)
	{
		transitionBody(color);
		started = true;
	}
	else
	{
		document.getElementById("naviDiv").style.color = invertColor(color, true);
		document.getElementById("naviDiv").style.backgroundColor = hexToRgbA("#" + color, 0.9);
		document.getElementById("contentDiv").style.color = invertColor(color, true);
		document.getElementById("contentDiv").style.backgroundColor = hexToRgbA("#" + color, 0.9);
		var naviCells = document.getElementsByClassName("naviCell");
		for(var x=0; x < naviCells.length; x++)
		{
			naviCells[x].style.borderRightColor = invertColor(color, true);
			naviCells[x].style.borderLeftColor = invertColor(color, true);
			naviCells[x].style.borderTopColor = invertColor(color, true);
			naviCells[x].style.borderBottomColor = invertColor(color, true);
		}
	}
	var naviCells = document.getElementsByClassName("naviCell");
	for(var x=0; x < naviCells.length; x++)
	{
		naviCells[x].style.borderRightColor = invertColor(color, true);
		naviCells[x].style.borderLeftColor = invertColor(color, true);
		naviCells[x].style.borderTopColor = invertColor(color, true);
		naviCells[x].style.borderBottomColor = invertColor(color, true);
		naviCells[x].style.color = invertColor(color, true);
	}
	var highlightedCells = document.getElementsByClassName("highlighted");
	for(var x=0; x < highlightedCells.length; x++)
	{
		highlightedCells[x].style.borderRightColor = toColor;
		highlightedCells[x].style.borderLeftColor = toColor;
		highlightedCells[x].style.borderTopColor = toColor;
		highlightedCells[x].style.borderBottomColor = toColor;
		highlightedCells[x].style.color = toColor;
	}
	updateLinkColors();
}

function getNewBackground()
{
	var oReq = new XMLHttpRequest();
	oReq.addEventListener("load", reqListener);
	oReq.open("GET", "randomImageURL.jsp");
	oReq.send();
}

function transitionBody(color)
{
	document.getElementById("bodydiv").style.width="60%";
	document.getElementById("bodydiv").style.opacity="1.0";
	setTimeout(function ()
	{
		document.getElementById("titleText").style.animation="typing 3000ms steps(40, end), blink-caret 1000ms step-end infinite";
		document.getElementById("titleText").style.opacity="1";
	}, 3000);
	setTimeout(function ()
	{
		document.getElementById("naviDiv").style.color = invertColor(color, true);
		document.getElementById("naviDiv").style.backgroundColor = hexToRgbA("#" + color, 0.9);
		document.getElementById("naviDiv").style.width="60%";
		document.getElementById("naviDiv").style.opacity="1";
		document.getElementById("contentDiv").style.color = invertColor(color, true);
		document.getElementById("contentDiv").style.backgroundColor = hexToRgbA("#" + color, 0.9);
		document.getElementById("contentDiv").style.width="60%";
		document.getElementById("contentDiv").style.opacity="1";
		var naviCells = document.getElementsByClassName("naviCell");
		for(var x=0; x < naviCells.length; x++)
		{
			naviCells[x].style.borderRightColor = invertColor(color, true);
			naviCells[x].style.borderLeftColor = invertColor(color, true);
			naviCells[x].style.borderTopColor = invertColor(color, true);
			naviCells[x].style.borderBottomColor = invertColor(color, true);
		}
		
		var toColor = "red";
		if(darkBackground)
		{
			toColor = lightHighlighted;
		}
		else
		{
			toColor = darkHighlighted;
		}
		document.getElementById("titleText").style.borderRightColor = toColor;
		var highlightedCells = document.getElementsByClassName("highlighted");
		for(var x=0; x < highlightedCells.length; x++)
		{
			highlightedCells[x].style.borderRightColor = toColor;
			highlightedCells[x].style.borderLeftColor = toColor;
			highlightedCells[x].style.borderTopColor = toColor;
			highlightedCells[x].style.borderBottomColor = toColor;
			highlightedCells[x].style.color = toColor;
		}
		
	}, 6000);
}

getNewBackground();

setInterval(function(){ getNewBackground(); }, 20000);

</script>

</html>