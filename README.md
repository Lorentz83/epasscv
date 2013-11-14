EPASSCV LATEX CLASS
===================

The epasscv is an unofficial class for European curricula vitae. 
You can download the last version on [github](https://github.com/Lorentz83/epasscv)


From Wikipedia: Europass is a European Union (Directorate General for
Education and Culture) initiative to increase transparency of
qualification and mobility of citizens in Europe.  
It aims to make a person's skills and qualifications clearly
understood throughout Europe (including the European Union, European
Economic Area and EU candidate countries).

You can create the standard europass cv using the 
[official website](http://europass.cedefop.europa.eu/en/home).



Why another latex class for curricula vitae?
----------------------------------------------

* because in Europe is often suggested to have the cv formatted
  according to the standard europass;
* because, even though the interactive website is easy to use, I
  prefer LaTeX
* because the europecv class lacks of some feature I like



DISCLAIMER
----------

This is a beta version. This means that commands can change without
any advice and your cv couldn't compile anymore.
I'm sorry for this, but this experimental phase is necessary to write
a good class. 



How epasscv is different compared to europecv?
----------------------------------------------

Mainly europecv is a bit outdated: although it was good some years
ago, now europass has updated its look in a very nice way but no one
seems to maintain europecv anymore.

The europecv layout is made using tables, thus there are the usual
problems that there are with LaTeX tables: mainly newlines are no
allowed inside a cell.

One of the key point in epasscv is that write and maintain a double
language cv should be as simple as possible.

epasscv is written to be compliant to europass standard. 
This means that there are (or will be) commands to format every
section, thus write new layouts and localize the titles will be
easier.



**Reasons to use epasscv**

* it's europass compliant;
* it's very easy to switch language;
* it looks very similar to the europass cv;


**Rreasons to use europecv**

* it's widely used (it's easier to find answer in the web)
* it has localization for all the official languages of the EU (plus
  Catalan)



Supported languages
-------------------

Unfortunately, right now, only two: English and Italian (the only two
languages i speak). 
Help in translation would be appreciated.



Requirements
------------

Packages:
* url
* etoolbox
* hyperref
* xparse
* calc
* geometry
* titlesec
* lastpage
* fancyhdr
* isodate
* textpos
* tabularx
* marvosym
* graphicx
* babel (optional but suggested)

right now it is supported only pdflatex mainly for this two reasons: 
* the icons used are png files; 
* the \texorpdfstring command is required to put dates in the titles.



Roadmap
-------

Not necessary ordered by priority:

* add more icons (im, websites...)
* add a colorful theme
* support other languages
* improve the localization support
** add a command for each standard title
** add the localization support for "education" and "work"
* freeze the API and write the documentation


Changelog
---------

2013-11-14: first commit, the class is quite usable but not complete


