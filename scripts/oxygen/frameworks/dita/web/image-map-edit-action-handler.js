if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var originalEditImageMap = actionsManager.getActionById('edit.image.map');
    if (originalEditImageMap) {
      actionsManager.registerAction('edit.image.map',
        new sync.actions.InsertImageMap(
          originalEditImageMap,
          editor.getActionsManager(),
          editor.getReadOnlyStatus(),
          'ro.sync.ecss.extensions.dita.DITAUpdateImageMapOperation'));
    }
  });
}