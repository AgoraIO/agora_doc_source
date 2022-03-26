if(sync.ext.Registry.extension.type === 'ditamap' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var originalInsertNewTopicRef = actionsManager.getActionById('insert.new.dita.resource');
    if (originalInsertNewTopicRef) {
      actionsManager.registerAction('insert.new.dita.resource', new sync.actions.InsertNewTopicRef(
        originalInsertNewTopicRef, editor
      ));
    }
  });
}