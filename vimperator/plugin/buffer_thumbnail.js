commands.addUserCommand(
    ["thumbnail"],
    "View Thumbnails",
    function(args){
        if(args != "") {
            liberator.open(args.string);
        }
    },
    {
        count: false,
        completer: function(context, args) {
            let filter = context.filter;
            context.keys = {title: 'title', thumbnail: 'thumbnail', url: 'url', text:'text'};
            context.process = [templateThumbnail,function(obj){return obj.url}];
            context.title = ['Buffer','URL'];
            context.completions = generateCandidates();
        }
    },
    true
);

function templateThumbnail(obj) {
    return <>
      <img src={obj.thumbnail}/>{obj.title}
    </>;
}

function generateCandidates() {
    let allTabInfo = [];
    let index = 0;
    for each ( [,tab] in tabs.browsers ) {
        let url = tab.currentURI.spec;
        let title = tab.contentTitle;
        let getTab = tabs.getTab(index++);
        let thumbnail = ('__thumbnail' in getTab) ? getTab.__thumbnail.toDataURL() : "";
        let tabInfo = {
            "text": index + ":",
            "url" : url,
            "thumbnail" : thumbnail,
            "title" : title,
        }
        allTabInfo = allTabInfo.concat(tabInfo);
    }
    return allTabInfo;
}
