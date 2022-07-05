if(sync.ext.Registry.extension.type === 'ditamap') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();
    var originalInsertTableAction = actionsManager.getActionById('insert.table');
    if (originalInsertTableAction) {
      var insertTableAction = new sync.actions.InsertTable(
        originalInsertTableAction,
        "ro.sync.ecss.extensions.dita.map.table.InsertTableOperation",
        editor, [], []);
      actionsManager.registerAction('insert.table', insertTableAction);
    }
  });
}