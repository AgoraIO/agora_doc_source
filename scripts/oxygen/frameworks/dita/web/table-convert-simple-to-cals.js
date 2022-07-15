if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var convertSimpleTableToCalsTableId = 'convert.simple.table.to.cals.table';
    var convertSimpleTableToCalsTableAction = actionsManager.getActionById(convertSimpleTableToCalsTableId);
    if(convertSimpleTableToCalsTableAction) {
      // The action's enabled status should be context aware
      convertSimpleTableToCalsTableAction.isEnabled = function() {
        if(editor.getReadOnlyState().readOnly) {
          return false;
        }

        var isEnabled = false;
        var nodeAtSelection = editor.getSelectionManager().getSelection().getNodeAtSelection();
        var classValue = ' ' + (nodeAtSelection.getType() === goog.dom.NodeType.ELEMENT && nodeAtSelection.getAttribute('class')  || '') + ' ';
        
        if (classValue.indexOf(' topic/strow ') !== -1 ||
          classValue.indexOf(' topic/sthead ') !== -1 ||
          classValue.indexOf(' topic/stentry ') !== -1 ||
          classValue.indexOf(' topic/simpletable ') !== -1) {

          // We are inside a simple table
          isEnabled = true;
        }
        return isEnabled;
      };
    }
  });
}
