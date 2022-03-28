if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsFilter(function(actionsMap, editingSupport) {
    var originalInsertImageAction = actionsMap.get('insert.image');
    if (originalInsertImageAction) {
      var insertImageAction = new sync.actions.InsertImage(
        originalInsertImageAction,
        "ro.sync.ecss.extensions.dita.topic.InsertImageOperation",
        editingSupport);
      actionsMap.set('insert.image', insertImageAction);
    }
  });
}