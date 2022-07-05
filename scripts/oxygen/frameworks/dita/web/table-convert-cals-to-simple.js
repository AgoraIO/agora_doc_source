if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var convertCalsTableToSimpleTableId = 'convert.cals.table.to.simple.table';
    var convertCalsTableToSimpleTableAction = actionsManager.getActionById(convertCalsTableToSimpleTableId);
    if(convertCalsTableToSimpleTableAction) {
      // The action's enabled status should be context aware
      convertCalsTableToSimpleTableAction.isEnabled = function() {
        if(editor.getReadOnlyState().readOnly) {
          return false;
        }

        var isEnabled = false;
        var nodeAtSelection = editor.getSelectionManager().getSelection().getNodeAtSelection();
        var classValue = ' ' + ( nodeAtSelection.getType() === goog.dom.NodeType.ELEMENT && nodeAtSelection.getAttribute('class')  || '') + ' ';

        if (classValue.indexOf(' topic/row ') !== -1 ||
          classValue.indexOf(' topic/head ') !== -1 ||
          classValue.indexOf(' topic/entry ') !== -1 ||
          classValue.indexOf(' topic/table ') !== -1) {

          // We are inside a cals table
          isEnabled = true;
        }

        return isEnabled;
      };
    }
  });
}
