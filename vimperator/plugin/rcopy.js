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


(function () {
  liberator.globalVariables.copy_templates = [
    { label: 'titleAndURL',    value: '%TITLE%\n%URL%' },
    { label: 'title',          value: '%TITLE%', map: ',y' },
    { label: 'anchor',         value: '<a href="%URL%">%TITLE%</a>' },
    { label: 'selanchor',      value: '<a href="%URL%" title="%TITLE%">%SEL%</a>' },
    { label: 'htmlblockquote', value: '<blockquote cite="%URL%" title="%TITLE%">%HTMLSEL%</blockquote>' },
    { label: 'ASIN',   value: 'copy ASIN code from Amazon',
      custom: function(){
        return content.document.getElementById('ASIN').value;}
    },
    { label: 'PA', value: 'copy account_id from CMSP',
      custom: function() {
        return (function (e, re) {
          var m = e.textContent.match(re);
          if (m) return m[0];
          
          for (var i = 0; i < e.children.length; i++) {
            var result = arguments.callee(e.children[i], re);
            if (result) return result;
          }
          return null;
        })(content.document.body, /PA\d{8}/);
      }}
  ];
})();
