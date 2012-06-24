(function () {
  commands.addUserCommand(
    ['rcopy'], 'Copy for Regexp match string',
    function(args, bang, count) {
      var text = (function (e, re) {
        var m = e.textContent.match(re);
        if (m) return m[0];
        
        for (var i = 0; i < e.children.length; i++) {
          var result = arguments.callee(e.children[i], re);
          if (result) return result;
        }
        return null;
      })(content.document.body, new RegExp(args.string));
      
      if (text) {
        liberator.echo('CopiedString: `' + text + "'");
        util.copyToClipboard(text);
      }
    });
})();
