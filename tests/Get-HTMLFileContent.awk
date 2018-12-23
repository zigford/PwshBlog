#!/bin/bash

cut_line='<hr ?\/?>'
cut_tags="yes"
template_tags_line_header="Tags:"

awk "/<!-- $1 begin -->/, /<!-- $2 end -->/{
   if (!/<!-- $1 begin -->/ && !/<!-- $2 end -->/) print
   if (\"$3\" == \"cut\" && /$cut_line/){
           if (\"$2\" == \"text\") exit
           while (getline > 0 && !/<!-- text end -->/) {
           if (\"$cut_tags\" == \"no\" && /^<p>$template_tags_line_header/ ) print
       }
   }
}" 
