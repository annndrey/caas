# -*- coding: utf-8 -*-

import sys
import re

phpvars = re.compile('\$.+=.+\"')
phpfuncts = re.compile('.+PICTURES\(.+?\).+\?\>')

def convert_file(infile):
    a = open(infile).read()
    vardict = {}
    for v in phpvars.findall(a):
        outlist = [k.strip() for k in v.replace('$','').replace('"', '').replace("<br>", '').split("=")]
        vardict[outlist[0]] = outlist[1]
    #so we got all php variables here
    #print(vardict)
    #теперь надо пройтись по всей странице и найти блоки с картинками, посчитать сколько там строк и как что располагается
    #чтобы заменить строки с последовательными вставками на один блок
    # найти и заменить 
    # <?php PICTURES($folder,array("Lib_05", "Lib_06"),"1", $userwidth);?>
    # <?php PICTURES($folder,array("Lib_07", "Lib_08"), "1", $userwidth);?>   
    #на
    #
    #   <div class="photoset-grid-lightbox" data-layout=22 style="visibility: hidden;">
    #   <img alt="" src="/libya/Lib_05_small.jpg" data-highres="/libya/Lib_05.jpg"/>
    #   <img alt="" src="/libya/Lib_06_small.jpg" data-highres="/libya/Lib_06.jpg"/>
    #   <img alt="" src="/libya/Lib_07_small.jpg" data-highres="/libya/Lib_07.jpg"/>
    #   <img alt="" src="/libya/Lib_08_small.jpg" data-highres="/libya/Lib_08.jpg"/>
    #   </div>
    #разбиваем текст на строчки    
    a = [x for x in a.split('\n') if len(x) > 0]
    #пропускаем все <?php и ждем, что в конце будет ?>
    imgcount = 0
    for i in range(len(a)):
        if a[i].startswith('<?php'):
            if "PICTURES" in a[i]:
                imgcount = imgcount + 1
                #parse image string and form new div with pictures
                print(a[i])
            else:
                pass

        elif a[i].endswith("?>") or "?>" in a[i]:
            if i+1< len(a):
                print(a[i+1])
        else:
            if imgcount > 0:
                print(imgcount)
            imgcount = 0
            print(a[i])

if __name__ == "__main__":
    convert_file(sys.argv[1])
