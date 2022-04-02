if(sync.ext.Registry.extension.type === 'ditamap') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var originalWebappSetNewTopic = actionsManager.getActionById('webapp.set.new.topic');
    if (originalWebappSetNewTopic) {
      actionsManager.registerAction(
        'webapp.set.new.topic',
        new sync.actions.CreateAndReferenceResourceAction(originalWebappSetNewTopic, editor));
    }
  });
}