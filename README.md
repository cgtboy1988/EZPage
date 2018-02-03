# EZPage

An easy, JSP+Tomcat engine/framework for hosting small sites.

## About

In the Spring of 2018, I was informed that I had to have a personal website for profile purposes.  Although I had been encouraged in the past to build such a site, I never got around to it until I absolutely had to.  This is because I wanted to build a site that is nice and easy to amend, requiring little to no maintenance on the UI, instead allowing easy changing of the content and looking great regardless.  Clearly, this would be more than a few minutes of work, hence putting it off until required.  The resulting webapp that accomplishes these goals in this, EZPage.

## Requirements and Installation

EZPage itself is fairly lightweight, but it runs on Apache Tomcat, which itself is a mid-weight web server and requires Java.  In order to run this webapp, just copy it (or compile it to a WAR and copy it) to the webapps directory of your Tomcat installation.  No external libraries are required, but you might want to ensure your Tomcat server is running on port 80 or forwarded to that port via another server such as Apache or nginx.  Please change the code from my default content before publishing, unless you want to host a copy of my profile!

## How to Build Your Own

Leave index.jsp and randomImageURL.jsp alone, unless you want to adapt the infrastructure, which might be appropriate if you want to change the color scheme, for instance---I know not everyone likes my red titles!  These files are responsible for displaying your content.

To build your own profile, first please remove and replace the files in WebContent/backgroundImages/ to your own.  The files in there are ones which I took/were taken of me. and it would be weird for you to use them.  The files in this directory are the images that cycle in the background of your profile, so make sure they are good quality but not too large in size because they will take up the whole screen.

Second, remove and replace the files in WebContent/pages with your own.  These pages are your EZPage's content.  Each page contains an order, a title, and content.  The order tells EZPage which order to put your pages in on the navigation bar.  The title is an entry on the navigation bar.  If that entry gets clicked, then the title and content are displayed on your EZPage (and any previously displayed content is hidden).  The content can be plaintext or HTML; your text/HTML sits within a div on the main EZPage when active.  The format of the EZPage.page files is as follows:

First line: 1 integer which denotes the order of the page on the navigation
Second line: The title of the page
Third line through end: The text/HTML content of the page

You can put images you want to host in the /contentImages/ directory (please remove my images from there, also).

That's it!  If you host your page, it should 

## Interesting Technical Details
