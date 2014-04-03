# -*- coding: utf-8 -*-

import sys
import re

#bosniya - и др - там еще появляется insert_paragraph из другого файла, который лежит в папке с фоточками.
#может лучше брать html-версии и их преобразовывать? 

#!!!! Надо что-то делать с многострочными переменными типа descr
# там еще где-то descr, где-то descript... проверить и исправить
phpvars = re.compile('\$.*=.*\".*\"')
block = re.compile('require.+?\?>', re.DOTALL)
phppicts = re.compile('array\(.+\),')
pictures = re.compile('"([A-Za-z0-9_\./\\-]*)"')
phpfuncts = re.compile('\w+\(.*\);')

div_start = """<div class="photoset-grid-lightbox" data-layout={0} style="visibility: hidden;">"""
div_image = """<img alt="" src="/{0}/{1}_small.jpg" data-highres="/{0}/{1}.jpg"/>"""
div_end = "</div>"

def convert_file(infile):
    a = open(infile).read()
    vardict = {}

    phpblock = block.search(a)
    vars = a[phpblock.start():phpblock.end()]

    vars = """"\n""".join([x.replace("\n", '') for x in vars.split("""";""")])
    
    for v in phpvars.findall(vars):
        outlist = [k.strip() for k in v.replace('$','').replace('"', '').replace("<br>", '').split("=")]
        vardict[outlist[0]] = outlist[1]
    print(vars)
    print(vardict)
    a = a[phpblock.end():]
    a = [x for x in a.split('\n') if len(x) > 0]
    imgcount = 0
    imglayout = ""
    imgdivs = []


    #here we remove php statements

    for i in range(len(a)):
        if "PICTURES" in a[i]:
            pictarray = phppicts.findall(a[i])[-1]
            pict_row = pictures.findall(pictarray)
            for p in pict_row:
                imgdivs.append(div_image.format(vardict['folder'], p.replace('"', '')))
            imglayout = imglayout + str(len(pictures.findall(pictarray)))
            imgcount = imgcount + 1
        else:
            if imgcount > 0:
                print(div_start.format(imglayout))
                print("\n".join(imgdivs))
                print(div_end)
            if not "?php" in a[i]:
                if not phpvars.search(a[i]):
                    if not phpfuncts.search(a[i]):
                        print(a[i])
            imgcount = 0
            imglayout = ""
            imgdivs = []

if __name__ == "__main__":
    convert_file(sys.argv[1])
