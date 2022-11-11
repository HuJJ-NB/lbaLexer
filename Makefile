NAME := labLexer-2
BUILD := build
TMP := tmp

LEXSRC-DIR := grammar
CSRC-DIR := src

APP := $(BUILD)/$(NAME)

all: $(APP)
PHONY += all

run: $(APP)
	@echo run $^
	@$(APP)
PHONY += run

LEX := flex
LEXFLAG := -i -I

$(TMP)/%.yy.c: %.lex
	@echo + LEX $^
	@mkdir -p $(dir $@)
	@$(LEX) $(LEXFLAG) -o $@ $^

CC := gcc
LD := $(CC)
CFLAG := -g
LDFLAG := $(CGLAG)

$(BUILD)/%.o: %.c
	@echo + CC $^
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAG) -c -o $@ $^

LEXSRC := $(LEXSRC-DIR)/$(NAME).lex
LEXOBJ := $(patsubst %.lex,$(TMP)/%.yy.c,$(LEXSRC))

CSRC := $(CSRC-DIR)/$(NAME).c
COBJ := $(patsubst %.c,$(BUILD)/%.o,$(CSRC) $(LEXOBJ))

$(APP): $(COBJ)
	@echo + LD $^
	@mkdir -p $(dir $@)
	@$(LD) $(LDFLAG) -o $@ $^

clean:
	@echo - CLEAN $(BUILD) $(TMP)
	@rm -rf $(BUILD) $(TMP)
PHONY += clean

.PHONY: $(PHONY)
