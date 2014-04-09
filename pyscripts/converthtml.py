
# -*- coding: utf-8 -*-

import sys
import re
from bs4 import BeautifulSoup

div_start = """<div class="photoset-grid-lightbox" data-layout={0} style="visibility: hidden;">"""
div_image = """<img alt="" src="{0}" data-highres="{1}"/>"""
div_end = "</div>"


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
    soup = BeautifulSoup(sourcehtml)
    prettyhtml = soup.prettify()
    prettysoup = BeautifulSoup(prettyhtml)

    keywords = soup.find("meta", {"name":"keywords"})['content']
    descr = soup.find("meta", {"name":"description"})['content']
    title = soup.title

    contents = prettysoup.findAll("a", {"class":"link_3"})

    tabledivs = prettysoup.findAll("div", {'id':"picttable"})
    elements = prettysoup.body.findAll(['p', 'i', 'h3', 'div'])
    
    print(title.text.replace('\n', '').strip())
    print(descr)
    print(keywords)

    resulthtml = []
    skip = False
    for e in elements:

        if 'picttable' in e.attrs.get('id', '') or 'justify' in e.attrs.get('align', '') or e.name == 'i' or e.name != 'script':
            if 'bottom' not in e.attrs.get('id', ''):
                if 'center' not in e.attrs.get('align', ''):
                    #now processing imagedivs. 
                    if e.name == 'div' and e['id'] == 'picttable' and skip == False:
                        alldivs = finddivs(e)
                        print(len(alldivs))
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
                            #atxt = str(a).replace('\n', '')
                            #a.replace_with(atxt)
                        
                        #for elem in e.findAll(True):
                        
                        resulthtml.append(e)

    print('\n'.join([str(i) for i in resulthtml]))

if __name__ == "__main__":
    convert_file(sys.argv[1])
