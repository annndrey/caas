#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import re
from bs4 import BeautifulSoup

div_start = """<div class="photoset-grid-lightbox" data-layout={0} style="visibility: hidden;">"""
div_image = """<img alt="" src="{0}" data-highres="{1}"/>"""
div_end = "</div>"
reimg = re.compile("[a-zA-Z]+\/.+\.[jpegJPEGpngPNG]+")
separator = re.compile("src.+Разделитель")

def finddivs(div):
    sibl = [a for a in div.next_siblings if a !="\n"]
    imgblock = [[a['src'] for a in div.findAll('img')], ]
    for i in range(len(sibl)):
        if sibl[i].name == 'div':
            imgblock.append([a['src'] for a in sibl[i].findAll('img')])
        else:
            break
    return imgblock 

def convert_file(infile):
    sourcehtml = open(infile).read().replace("<br>", '')
    seps = separator.findall(sourcehtml)

    soup = BeautifulSoup(sourcehtml)
    prettyhtml = soup.prettify()
    prettysoup = BeautifulSoup(prettyhtml)

    keywords = soup.find("meta", {"name":"keywords"})['content']
    descr = soup.find("meta", {"name":"description"})['content']
    title = soup.title
    leftbracket = soup.find('td', {'id':'bgimageleft'})
    #print(leftbracket)

    leftbracket = reimg.findall(leftbracket['style'])[-1]
    rightbracket = prettysoup.find('td', {'id':'bgimageright'})

    rightbracket = reimg.findall(rightbracket['style'])[-1]

    articlesep = seps[0].split(" ")[0].split("=")[-1].replace('"','')
    contents = prettysoup.findAll("a", {"class":"link_3"})
    tabledivs = prettysoup.findAll("div", {'id':"picttable"})

    elements = prettysoup.body.findAll(['p', 'i', 'h3', 'div'])
    ## We should create a new isntance of Article here
    ## with the given parameters
    ## and save it to database
    # mainname
    print(title.text.replace('\n', '').strip())
    ## descr
    print(descr)
    ## keywords 
    print(keywords)
    ## sep_url
    print(articlesep)
    ## left_bracket_url, left_bracket_url
    print(leftbracket, rightbracket)

    #TODO
    #don't forget to create top link in the mako template!!!1

    resulthtml = []
    skip = False
    for e in elements:
        #if e.name == 'img':
        #    if e.attrs.get('alt', '') == 'Разделитель':
        #        print(e)

        if 'picttable' in e.attrs.get('id', '') or 'justify' in e.attrs.get('align', '') or e.name == 'i' or e.name != 'script':
            if 'bottom' not in e.attrs.get('id', ''):
                if 'center' not in e.attrs.get('align', ''):
                    #now processing imagedivs. 
                    if e.name == 'div' and e['id'] == 'picttable' and skip == False:
                        alldivs = finddivs(e)
                        if len(alldivs) > 1:
                            skip = True
                        layout = "".join([str(len(a)) for a in alldivs])
                        resulthtml.append(div_start.format(layout))
                        for d in alldivs:
                            for img in d:
                                resulthtml.append(div_image.format(img, img.replace('_small', '')))
                        resulthtml.append(div_end)
                    

                    elif e.name != 'div':
                        skip = False
                        #skipping comments
                        if e.name and e.name == 'p' and e.attrs.get('id', '') == 'comment':
                            continue

                        #cleaning links
                        for a in e.findAll('a'):
                            del a['class']

                            for c in a.children:
                                if c.name == 'font':
                                    a.string = c.text.replace("\n", '').strip()
                        resulthtml.append(e)
    print("______________________")

    finalhtml = '\n'.join([str(i) for i in resulthtml])
    
    finalhtml = finalhtml.replace("""<a href="#top">top</a>""", """<img id="separator" src="{0}"><a href="#top">top</a>""".format(articlesep))
    ## maintext
    ## >>>>> Create new article here
    print(finalhtml)


    
if __name__ == "__main__":
    convert_file(sys.argv[1])
