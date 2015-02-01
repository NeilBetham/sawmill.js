class Sawmill
  CLEAR_ANSI: ///
(?:\033) # leader
(?:
    \[0?c                 # query device code
  | \[[0356]n             # device-related
  | \[7[lh]               # disable/enable line wrapping
  | \[\?25[lh]            # not sure what this is, but we've seen it happen
  | \(B                   # set default font to 'B'
  | H                     # set tab at current position
  | \[(?:\d+(;\d+){,2})?G # tab control
  | \[(?:[12])?[JK]       # erase line, screen, etc.
  | [DM]                  # scroll up/down
  | \[0K                  # clear line, handled by \r in our case
)
///gm

  constructor: (@options)->
    @parts = []
    @lines = []
    @spans = []

  pushPart: (part, index)->
    return console.log 'dup part added, skipping...' if @parts[index]
    @parts[index] =
      index: index
      part: part
    @processPart index
    @

  processPart: (index)->
    console.log "processing part #{index}"
    @parts[index].partNoANSI = @parts[index].part
      .replace(/\033\[1000D/gm, '\r')
      .replace(/\r+\n/gm, '\n')
      .replace(@CLEAR_ANSI, '')

    @parts[index].lines = @parts[index].partNoANSI.split(/^/gm) || []
