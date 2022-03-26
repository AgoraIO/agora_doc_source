if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var originalApplyImageMap= actionsManager.getActionById('apply.image.map');

    if (originalApplyImageMap) {
      originalApplyImageMap.getFollowUp = function () {
        return  {
          action: actionsManager.getActionById('edit.image.map'),
          type: sync.ctrl.Scheduler.ActionType.HANDLES_BLOCKING
        }
      }
      originalApplyImageMap.isEnabled = function() {
        var isEnabled = false;
        var sel = editor.getSelectionManager().getSelection();
        var xmlNode = sel.getNodeAtSelection();
        var htmlElem = xmlNode.getHtmlNode();

        // Enable the action only when inside an image
        // whose parent is not already an imagemap.
        if(!sel.isEmpty() &&
          sync.caret.ContentIterator.getImageStaticContent(htmlElem) &&
          xmlNode.getTagName() === 'image' &&
          xmlNode.getParent().getTagName() !== 'imagemap') {

          isEnabled = true;
        }
        return isEnabled;
      };
    }
  });
}