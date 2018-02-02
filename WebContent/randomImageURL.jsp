<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.awt.Color, java.awt.image.BufferedImage, java.io.*, javax.imageio.*, java.io.FileInputStream, java.util.ArrayList, java.net.URL, java.io.DataInputStream, java.io.InputStream, java.io.InputStreamReader, java.io.File, java.io.BufferedReader, java.net.URLConnection, java.io.BufferedInputStream, java.security.*, java.net.*, java.util.*, java.util.concurrent.ConcurrentHashMap, java.util.Locale, java.text.DateFormat, java.text.NumberFormat"%><%
ServletContext sc=getServletContext();
String reportPath=sc.getRealPath("/backgroundImages/");
File myFile = new File(reportPath);
String[] fileList = myFile.list();
String outputFile = fileList[new Random().nextInt(fileList.length)];
out.print(outputFile);
BufferedImage myImage = ImageIO.read(new File(reportPath + "/" + outputFile));
double averageBorderRed = 0;
double averageBorderGreen = 0;
double averageBorderBlue = 0;
//double total = myImage.getWidth() * myImage.getHeight();
//for(int x=0; x<myImage.getWidth(); x++)
//{
//	for(int y=0; y<myImage.getHeight(); y++)
//	{
//		Color tmpColor = new Color(myImage.getRGB(x, y));
//		averageBorderRed += tmpColor.getRed();
//		averageBorderGreen += tmpColor.getGreen();
//		averageBorderBlue += tmpColor.getBlue();
//	}
//}
//averageBorderRed = averageBorderRed / total;
//averageBorderGreen = averageBorderGreen / total;
//averageBorderBlue = averageBorderBlue / total;
double total = (2 * myImage.getWidth());// + (2 * myImage.getHeight());
for(int x=0; x<myImage.getWidth(); x++)
{
	Color tmpColor = new Color(myImage.getRGB(x, 0));
	averageBorderRed += tmpColor.getRed();
	averageBorderGreen += tmpColor.getGreen();
	averageBorderBlue += tmpColor.getBlue();
	tmpColor = new Color(myImage.getRGB(x, myImage.getHeight() - 1));
	averageBorderRed += tmpColor.getRed();
	averageBorderGreen += tmpColor.getGreen();
	averageBorderBlue += tmpColor.getBlue();
}
//for(int x=0; x<myImage.getHeight(); x++)
//{
//	Color tmpColor = new Color(myImage.getRGB(0, x));
//	averageBorderRed += tmpColor.getRed();
//	averageBorderGreen += tmpColor.getGreen();
//	averageBorderBlue += tmpColor.getBlue();
//	tmpColor = new Color(myImage.getRGB(myImage.getWidth() - 1, x));
//	averageBorderRed += tmpColor.getRed();
//	averageBorderGreen += tmpColor.getGreen();
//	averageBorderBlue += tmpColor.getBlue();
//}
averageBorderRed = averageBorderRed / total;
averageBorderGreen = averageBorderGreen / total;
averageBorderBlue = averageBorderBlue / total;

Color finalColor = new Color((int)Math.round(averageBorderRed), (int)Math.round(averageBorderGreen), (int)Math.round(averageBorderBlue));
String myHex = Integer.toHexString(finalColor.getRGB());
myHex = myHex.substring(2, myHex.length());
//Color myColor = new Color((int)averageBorder);
out.print("\n" + myHex);
%>