# EZPage

An easy, JSP+Tomcat engine/framework for hosting small sites.

## About

In the Spring of 2018, I was informed that I had to have a personal website for profile purposes.  Although I had been encouraged in the past to build such a site, I never got around to it until I absolutely had to.  This is because I wanted to build a site that is nice and easy to amend, requiring little to no maintenance on the UI, instead allowing easy changing of the content and looking great regardless.  Clearly, this would be more than a few minutes of work, hence putting it off until required.  The resulting webapp that accomplishes these goals in this, EZPage.

You can see my own EZPage profile here: http://revenge.cs.arizona.edu/ClarkTaylor/index.jsp

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

That's it!  If you host your page, it should hopefully look nice!

## Interesting Technical Details

Most of this webapp is pretty simple.  However, one technical problem took a bit of work to figure out.  Specifically, automatically generating a color scheme for the background and text colors is not as easy as it sounds.  Certainly, a black-on-white or vice versa scheme would be easy to implement, but this clashes with the background significantly and looks bad.

Instead, EZPage first decides on the background color by examining the first and last row of pixels in the image, getting an average color from that.  This generates a background color which looks quite nice with the photo.  Opacity is set at .9 so that the photo is still visible, and this looks natural because the background color matches the photo.  However, this often results in background colors neither dark nor bright enough to show text well.  So, the color is brightened or darkened to a threshold (retaining the color balance) depending on whether the color was initially [somewhat] bright or [somewhat] dark.

After this background is selected, the foreground text is selected by inverting the initial (pre darkened/lightened) background color and running a similar darkening/lightening algorithm.  This makes the text color contrast with the background well.

Overall, this tends to work on photographic backgrounds.  It has not yet been tested with other types of backgrounds.

## License Type Stuff

All images and content in the /pages/ are not licensed here in any way, shape, or form.  The other software and files, in particular including the index.jsp and randomImageURL.jsp files, are offered for use in non-commercial applications.  Commercial applications should contact me first, but I will likely grant a free license for them as well on an ad-hoc basis.  No warranty, expressed or implied, is included.  Software is as-is and not guaranteed to work, be secure, or not considerably harm your property if you try to use it.  It is not my fault if you use this software and suddenly a pack of wild, rabid honey badgers attack you.
