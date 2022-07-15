if(sync.ext.Registry.extension.type === 'ditamap' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var originalInsertTopicRef = actionsManager.getActionById('insert.topicref');
    if (originalInsertTopicRef) {
      var insertTopicRef = new sync.actions.InsertTopicRef(originalInsertTopicRef, editor);
      actionsManager.registerAction('insert.topicref', insertTopicRef);
    }
  });
}