if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var insertFileReferenceId = 'insert.file.reference';
    var originalInsertFileReferenceAction = actionsManager.getActionById(insertFileReferenceId);
    if(originalInsertFileReferenceAction) {
      var insertFileReferenceAction = new sync.actions.InsertFileReference(
        originalInsertFileReferenceAction,
        'ro.sync.ecss.extensions.dita.link.InsertXrefOperation',
        editor);
      actionsManager.registerAction(insertFileReferenceId, insertFileReferenceAction);
      var changeFileReferenceAction = new sync.actions.InsertFileReference(
        originalInsertFileReferenceAction,
        'ro.sync.ecss.extensions.dita.link.InsertXrefOperation',
        editor,
        {replace_reference: 'true'}
      );
      actionsManager.registerAction('change.file.reference', changeFileReferenceAction);
    }
  });
}