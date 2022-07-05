if(sync.ext.Registry.extension.type === 'ditamap') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var insertVariable = new sync.actions.InsertVariable(actionsManager, editor);
    var actionId = 'insert.key.with.keyword'

    var originalAction = actionsManager.getActionById(actionId);
    if (originalAction) {
        actionsManager.registerAction(actionId, insertVariable);
    }
  });
}