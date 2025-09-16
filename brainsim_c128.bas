10 rem ===== c128 basic 7.0 hopfield net (40col) =====
20 poke 53280,13:poke 53281,6:print chr$(147);
30 rem arrays
40 dim f1%(42),f2%(42),m%(42,42)
50 dim v%,j,i
60 rem header
70 print chr$(147);
80 print "    neuron network associative memory"
90 print
100 for i=1 to 12: print chr$(17);: next i
110 print "f1 - teach pattern     ";
120 print "f2 - dump matrix"
130 print "f3 - randomize pattern ";
140 print "f4 - forget all"
150 print "f5 - recall pattern    ";
160 print "f6 - quit"
170 print "f7 - disc save         ";
180 print "f8 - disc load"
190 print
200 print "a-z, 0-9: load pattern"
210 r1=4:c1=5:gosub 600
220 r1=4:c1=25:gosub 600
230 gosub 750
240 gosub 860
250 gosub 970:print " ready    "
260 get a$:if a$="" then 260
270 gosub 970:print "          "
280 k=asc(a$)
290 if a$>="0" and a$<="9" then k=k+64:goto 320
300 if a$<"a" or a$>"z" then 480
310 rem ------ fetch glyph to f1% ------
320 gosub 970:print "fetch ";a$
330 l%=0
340 k=(k-64)*8+53248
350 rem map char-rom in (clear bit 2 of $01), read 7 bytes
360 poke 1,peek(1) and 251
370 for i=0 to 6:poke 49408+i,peek(k+i):next
380 poke 1,peek(1) or 4
390 for i=0 to 6
400 j%=peek(49408+i)/2
410 for j=1 to 6
420 l%=l%+1
430 f1%(l%)=-1+(2*(j% and 1))
440 j%=j%/2
450 next j
460 next i
470 gosub 750:gosub 860:goto 250
480 rem ------ function keys ------
490 j%=asc(a$)-132
500 if j%=1 then gosub 1000:goto 250
510 if j%=5 then gosub 1080:goto 60
520 if j%=2 then gosub 1210:goto 250
530 if j%=6 then gosub 1680:goto 250
540 if j%=3 then gosub 1290:goto 250
550 if j%=7 then print chr$(147);:end
560 if j%=4 then gosub 1800:goto 60
570 if j%=8 then gosub 1990:goto 60
580 goto 250
590 rem ------ draw boxed fields ------
600 for i=0 to 1
610 v=1024+40*(r1+(i*8))+c1
620 poke v,112+(-3*i)
630 for j=1 to 8:poke v+j,67:next j
640 poke v+9,110+(15*i)
650 next i
660 for i=1 to 7
670 v=1024+40*(r1+i)+c1
680 poke v,93:poke v+9,93
690 next i
700 return
710 rem ------ render f1 -> left (actually f2 in orig label) ------
750 l%=0
760 for i=0 to 6
770 v%=1024+40*(i+5)+6
780 for j=2 to 7
790 l%=l%+1
800 if f1%(l%)=1 then poke v%+(8-j),81 else poke v%+(8-j),32
810 next j
820 next i
830 return
840 rem ------ render f2 -> right (as in original) ------
860 l%=0
870 for i=0 to 6
880 v%=1024+40*(i+5)+26
890 for j=2 to 7
900 l%=l%+1
910 if f2%(l%)=1 then poke v%+(8-j),81 else poke v%+(8-j),32
920 next j
930 next i
940 return
950 rem ------ status line pos ------
970 print chr$(19);:for i=1 to 21:print chr$(17);:next i:return
990 rem ------ train (hebb) ------
1000 gosub 970:print "training"
1010 for i=1 to 42
1020 for j=1 to 42
1030 if i=j then m%(i,j)=m%(i,j) else m%(i,j)=m%(i,j)+f1%(i)*f1%(j)
1040 next j
1050 next i
1060 return
1070 rem ------ dump matrix (compact) ------
1080 print chr$(147);
1090 for i=1 to 24
1100 for j=1 to 39
1110 if m%(i,j)<0 then print chr$(150); else print chr$(154);
1120 print chr$(asc("0")+abs(m%(i,j)));
1130 next j:print
1140 next i
1150 print chr$(154);"press any key to continue:";
1160 get a$:if a$="" then 1160
1170 return
1180 rem ------ randomize ~10% bits ------
1210 gosub 970:print "random"
1220 for i=1 to 42
1230 if rnd(0)>0.1 then 1250
1240 f1%(i)=-f1%(i)
1250 next i
1260 gosub 750:return
1270 rem ------ recall until stable ------
1290 gosub 970:print "recall"
1300 p%=1024+40*9+19
1310 rem copy f1->f2
1320 poke p%+1,asc("=")
1330 for i=1 to 42:f2%(i)=f1%(i):next i
1340 gosub 860
1350 rem passes until no change
1360 poke p%,asc("="):poke p%+2,asc(">")
1370 for j=1 to 42
1380 v%=0:for i=1 to 42:v%=v%+f1%(i)*m%(i,j):next i
1390 v%=sgn(v%):if v%<>0 then f2%(j)=v%
1400 next j
1410 gosub 860
1420 c%=0:poke p%,asc("<"):poke p%+2,asc("=")
1430 for i=1 to 42
1440 v%=0:for j=1 to 42:v%=v%+f2%(j)*m%(i,j):next j
1450 v%=sgn(v%):if v%<>0 and v%<>f1%(i) then f1%(i)=v%:c%=1
1460 next i
1470 gosub 750:if c%<>0 then 1360
1480 poke p%,32:poke p%+1,32:poke p%+2,32
1490 return
1500 rem ------ forget all ------
1680 gosub 970:print "forget"
1690 for i=1 to 42
1700 f1%(i)=0:f2%(i)=0
1710 for j=1 to 42:m%(i,j)=0:next j
1720 next i
1730 gosub 750:gosub 860:return
1740 rem ------ save to disk ------
1800 gosub 970:print "save"
1810 input "file name: ";a$
1820 a$="@0:"+a$+",s,w"
1830 open 15,8,15:open 5,8,5,a$
1840 for i=1 to 42:print#5,f1%(i):next
1850 gosub 2240
1860 for i=1 to 42:print#5,f2%(i):next
1870 gosub 2240
1880 for i=1 to 42:for j=1 to 42:print#5,m%(i,j):next j:gosub 2240:next i
1890 close 5:close 15:print "":return
1900 rem ------ load from disk ------
1990 gosub 970:print "restore"
2000 input "file name: ";a$
2010 a$="@0:"+a$+",s,r"
2020 open 15,8,15:open 5,8,5,a$
2030 for i=1 to 42:input#5,f1%(i):next
2040 gosub 2240
2050 for i=1 to 42:input#5,f2%(i):next
2060 gosub 2240
2070 for i=1 to 42:for j=1 to 42:input#5,m%(i,j):next j:gosub 2240:next i
2080 close 5:close 15:return
2090 rem ------ disk error check ------
2240 input#15,en,em$,et,es:if en>0 then print en,em$,et,es:stop
2250 return
