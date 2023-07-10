function addTab(e, url) {
    var tabCounter = $(e).text();
    if(tabCounter==undefined||tabCounter.length<=0){//如果传入的是  tab标题，就直接用e的值做tab标题----为了子页面调用方便
        tabCounter=e;
    }

    var $tab = $('#doc-tab-demo-1');
    var $nav = $tab.find('.am-tabs-nav');
    var $bd = $tab.find('.am-tabs-bd');

    var nav = '<li></span>' +
        '<a href="javascript: void(0) ">' + tabCounter + '<span class="am-icon-close" onclick="closeSelf(this)"></a></li>';
    var content = '<div class="am-tab-panel"><iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:90%;"></iframe></div>';

    $nav.append(nav);
    $bd.append(content);
    //tabCounter++;
    $tab.tabs('refresh');
}
function closeSelf(e) {
    var $tab = $('#doc-tab-demo-1');
    var $nav = $tab.find('.am-tabs-nav');
    var $bd = $tab.find('.am-tabs-bd');

    var $item = $(e).closest('li');
    var index = $nav.children('li').index($item);

    $item.remove();
    $bd.find('.am-tab-panel').eq(index).remove();

    $tab.tabs('open', index > 0 ? index - 1 : index + 1);
    $tab.tabs('refresh');
}
function checkTab(e, url) {
    try {
        var index;
        var tabCounter = $(e).text();
        if(tabCounter==undefined||tabCounter.length<=0){//如果传入的是  tab标题，就直接用e的值做tab标题----为了子页面调用方便
            tabCounter=e;
        }
        var arr = $('.am-tabs-nav a');
        for (var i = 0; i < arr.length; i++) {
            if (arr[i].textContent.toString() == tabCounter.toString()) {
                index = arr[i];
                break;

            }
        }
        if (typeof (index) != "undefined") {
            $('#doc-tab-demo-1').tabs('open', index);
        }
        else {
            addTab(e, url);
            var arr = $('.am-tabs-nav a');
            for (var i = 0; i < arr.length; i++) {
                if (arr[i].textContent.toString() == tabCounter.toString()) {
                    index = arr[i];
                    break;
                }
            }
            if (typeof (index) != "undefined") {
                $('#doc-tab-demo-1').tabs('open', index);
            }
        }
    }
    catch (e) {
        alert(e);
    }

}