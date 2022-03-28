if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var insertCrossRefId = 'insert.cross.reference';
    var originalInsertXref = actionsManager.getActionById(insertCrossRefId);
    if (originalInsertXref) {
      var insertXref = new sync.actions.InsertXref(originalInsertXref, editor);
      actionsManager.registerAction(insertCrossRefId, insertXref);
      var changeXref = new sync.actions.InsertXref(originalInsertXref, editor, {replace_reference: 'true'});
      actionsManager.registerAction('change.cross.reference', changeXref);

      // WA-3813: Remove the raw xref element.
      actionsConfig.filterCCItems.push('xref');

      // WA-3817: Use action name for insert cross reference action
      var ccItems = actionsConfig.ccItems;
      if (ccItems) {
        var insertXref = goog.array.find(ccItems, function (item) {
          return item.id === insertCrossRefId;
        });
        if (insertXref) {
          insertXref.ccItemAlias = originalInsertXref.getDisplayName();
        }
      }
    }
  });
}