LANG1=mk
LANG2=bg
BASENAME=apertium-$(LANG1)-$(LANG2)
PREFIX1=$(LANG1)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)

all:
	# Macedonian -> Bulgarian

	lt-comp lr $(BASENAME).$(LANG1).dix $(PREFIX1).automorf.bin $(BASENAME).$(LANG1).acx
	lt-comp lr $(BASENAME).$(PREFIX1).dix $(PREFIX1).autobil.bin
	lt-comp rl $(BASENAME).$(LANG2).dix $(PREFIX1).autogen.bin
	lt-comp lr $(BASENAME).post-$(LANG2).dix $(PREFIX1).autopgen.bin
	cg-comp  $(BASENAME).$(PREFIX1).rlx $(PREFIX1).rlx.bin
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $(PREFIX1).t1x.bin

	# Bulgarian -> Macedonian

	lt-comp lr $(BASENAME).$(LANG2).dix $(PREFIX2).automorf.bin $(BASENAME).$(LANG2).acx
	lt-comp rl $(BASENAME).$(PREFIX1).dix $(PREFIX2).autobil.bin
	lt-comp rl $(BASENAME).$(LANG1).dix $(PREFIX2).autogen.bin
	lt-comp lr $(BASENAME).post-$(LANG1).dix $(PREFIX2).autopgen.bin
	apertium-validate-transfer $(BASENAME).$(PREFIX2).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX2).t1x $(PREFIX2).t1x.bin

	apertium-gen-modes modes.xml
	cp *.mode modes/
 
clean:
	rm -f *.bin 
	rm -r modes/

