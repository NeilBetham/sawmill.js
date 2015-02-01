var Sawmill;

Sawmill = (function() {
  Sawmill.prototype.CLEAR_ANSI = /(?:\033)(?:\[0?c|\[[0356]n|\[7[lh]|\[\?25[lh]|\(B|H|\[(?:\d+(;\d+){,2})?G|\[(?:[12])?[JK]|[DM]|\[0K)/gm;

  function Sawmill(_at_options) {
    this.options = _at_options;
    this.parts = [];
    this.lines = [];
    this.spans = [];
  }

  Sawmill.prototype.pushPart = function(part, index) {
    if (this.parts[index]) {
      return console.log('dup part added, skipping...');
    }
    this.parts[index] = {
      index: index,
      part: part
    };
    this.processPart(index);
    return this;
  };

  Sawmill.prototype.processPart = function(index) {
    console.log("processing part " + index);
    this.parts[index].partNoANSI = this.parts[index].part.replace(/\033\[1000D/gm, '\r').replace(/\r+\n/gm, '\n').replace(this.CLEAR_ANSI, '');
    return this.parts[index].lines = this.parts[index].partNoANSI.split(/^/gm) || [];
  };

  return Sawmill;

})();
