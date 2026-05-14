10 rem c128: 40 spalten, f-tasten, bank fuer charset, recall integer wie c64
20 rem 
30 rem
50 open15,8,15
51 rem f-tasten wie c64 (je ein byte)
52 key 1,chr$(133)
53 key 2,chr$(137)
54 key 3,chr$(134)
55 key 4,chr$(138)
56 key 5,chr$(135)
57 key 6,chr$(139)
58 key 7,chr$(136)
59 key 8,chr$(140)
60 rem variablen
70 dim f1%(42),f2%(42),m%(42,42)
80 dim v%,j,i
85 dim cb%(6):rem puffer fuer 7 zeichensatz-bytes
87 if (peek(215)and128) then sys49194:rem 80->40
88 bank 15
90 rem bildschirm
100 scnclr:color 5,6:print chr$(146);
110 print "    neuron network associative memory"
120 print
130 for i=1 to 12:print chr$(17);:next i
140 print "f1 - teach pattern     ";
150 print "f2 - dump matrix"
160 print "f3 - randomize pattern ";
170 print "f4 - forget all"
180 print "f5 - recall pattern    ";
190 print "f6 - quit"
200 print "f7 - disc save         ";
210 print "f8 - disc load"
220 print
230 print "a-z, 0-9: load pattern"
240 r1=4:c1=5:gosub600
250 r1=4:c1=25:gosub600
260 gosub750
270 gosub860
280 gosub970:print " ready    "
290 get a$:if a$="" goto 290
300 gosub970:print "          "
310 ac=asc(a$)
320 if a$>="0" and a$<="9" then ac=ac+64:goto 340
330 if a$<"a" or a$>"z" then 500
340 gosub970:print "fetch ";a$
350 l%=0
360 ad=(ac-64)*8+53248
370 bank 14
380 for i=0 to 6:cb%(i)=peek(ad+i):next i
390 bank 15
400 for i=0 to 6
410 j%=cb%(i)/2
420 for k=1 to 6
430 l%=l%+1
440 f1%(l%)=-1+(2*(j% and 1))
450 j%=j%/2
460 next k
470 next i
480 gosub750:gosub860:goto 280
490 rem f-tasten
500 j%=asc(a$)-132
510 if j%=1 then gosub1000:goto 280
520 if j%=5 then gosub1080:goto 90
530 if j%=2 then gosub1210:goto 280
540 if j%=6 then gosub1680:goto 280
550 if j%=3 then gosub1290:goto 280
560 if j%=7 then scnclr:close15:end
570 if j%=4 then gosub1800:goto 90
580 if j%=8 then gosub1990:goto 90
590 goto 280
600 rem rahmen felder
610 for i=0 to 1
620 v=1024+40*(r1+(i*8))+c1
630 poke v,112+(-3*i)
640 for j=1 to 8
650 poke v+j,67
660 next j
670 poke v+9,110+(15*i)
680 next i
690 for i=1 to 7
700 v=1024+40*(r1+i)+c1
710 poke v,93
720 poke v+9,93
730 next i
740 return
750 rem f2% anzeigen
760 l%=0
770 for i=0 to 6
780 v%=1024+40*(i+5)+6
790 for j=2 to 7
800 l%=l%+1
810 if f1%(l%)=1 then poke v%+(8-j),81:goto 830
820 poke v%+(8-j),32
830 next j
840 next i
850 return
860 rem f1% anzeigen
870 l%=0
880 for i=0 to 6
890 v%=1024+40*(i+5)+26
900 for j=2 to 7
910 l%=l%+1
920 if f2%(l%)=1 then poke v%+(8-j),81:goto 940
930 poke v%+(8-j),32
940 next j
950 next i
960 return
970 rem statuszeile
980 print chr$(19);
982 for i=1 to 21:print chr$(17);:next i
990 return
1000 rem trainieren
1010 gosub970:print "training"
1020 for i=1 to 42
1030 for j=1 to 42
1040 m%(i,j)=m%(i,j)+f1%(i)*f1%(j)
1050 next j
1060 next i
1070 return
1080 rem matrix
1090 scnclr
1100 for i=1 to 24
1110 for j=1 to 39
1120 if m%(i,j)<0 then print chr$(150);:goto 1140
1130 print chr$(154);
1140 print chr$(asc("0")+abs(m%(i,j)));
1150 next j
1160 print
1170 next i
1180 print chr$(146);chr$(153);"press any key to continue:";
1190 get a$:if a$="" goto 1190
1200 return
1210 rem zufaellig 10%
1220 gosub970:print "random"
1230 for i=1 to 42
1240 if rnd(0)>.1 then 1260
1250 f1%(i)=-f1%(i)
1260 next i
1270 gosub750
1280 return
1290 rem recall (integer v% wie c64)
1300 gosub970:print "recall"
1310 p%=1024+40*9+19
1320 poke p%+1,asc("=")
1330 for i=1 to 42
1340 f2%(i)=f1%(i)
1350 next i
1360 gosub860
1380 poke p%,asc("=")
1390 poke p%+2,asc(">")
1400 for j=1 to 42
1410 v%=0
1420 for i=1 to 42
1430 v%=v%+f1%(i)*m%(i,j)
1440 next i
1450 v%=sgn(v%)
1460 if v%<>0 then f2%(j)=v%
1470 next j
1480 gosub860
1500 c%=0
1510 poke p%,asc("<")
1520 poke p%+2,asc("=")
1530 for i=1 to 42
1540 v%=0
1550 for j=1 to 42
1560 v%=v%+f2%(j)*m%(i,j)
1570 next j
1580 v%=sgn(v%)
1590 if v%<>0 and v%<>f1%(i) then f1%(i)=v%:c%=1
1600 next i
1610 gosub750
1620 if c%<>0 goto 1380
1630 poke p%,32
1640 poke p%+1,32
1650 poke p%+2,32
1670 return
1680 rem vergessen
1690 gosub970:print "forget"
1700 for i=1 to 42
1710 f1%(i)=0
1720 f2%(i)=0
1730 for j=1 to 42
1740 m%(i,j)=0
1750 next j
1760 next i
1770 gosub750
1780 gosub860
1790 return
1800 rem speichern
1810 gosub970:print "save"
1820 print "";
1830 input "file name: ";a$
1840 a$="@0:"+a$+",s,w"
1850 open5,8,5,a$
1860 for i=1 to 42:print#5,f1%(i):next
1870 gosub2240
1880 for i=1 to 42:print#5,f2%(i):next
1890 gosub2240
1900 for i=1 to 42
1910 for j=1 to 42
1920 print#5,m%(i,j)
1930 next j
1940 gosub2240
1950 next i
1960 close5
1970 print "";
1980 return
1990 rem laden
2000 gosub970:print "restore"
2010 print "";
2020 input "file name: ";a$
2030 a$="@0:"+a$+",s,r"
2040 p%=asc("m")
2050 gosub2240
2060 open5,8,5,a$
2070 for i=1 to 42
2080 input#5,f1%(i)
2090 next i
2100 gosub2240
2110 for i=1 to 42
2120 input#5,f2%(i)
2130 next i
2140 gosub2240
2150 for i=1 to 42
2160 for j=1 to 42
2170 input#5,m%(i,j)
2180 next j
2190 gosub2240
2200 next i
2210 close5
2220 return
2230 rem disk-fehler
2240 input#15,en,em$,et,es
2250 if en>0 then print en,em$,et,es:stop
2260 return
