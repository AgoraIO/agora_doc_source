if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var originalReuseContentAction = actionsManager.getActionById('reuse.content');
    if (originalReuseContentAction) {
      var reuseContentAction = new sync.actions.dita.ReuseContentAction(
        originalReuseContentAction,
        editor);
      actionsManager.registerAction('reuse.content', reuseContentAction);
    }
  });
}