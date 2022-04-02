if(sync.ext.Registry.extension.type === 'dita' || sync.ext.Registry.extension.type === 'ditamap' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var ACTION_ID = 'DITA/SetDitaMap';
    var editingSupport = editor.getEditingSupport();
    var askForDitamapAction =
      new sync.actions.AskForDitamap(editor, editor.widgets, editingSupport.scheduler,
        editingSupport.getController(), editingSupport.problemReporter);

    var actionsManager = editor.getActionsManager();
    actionsManager.registerAction(ACTION_ID, askForDitamapAction);
  });
}