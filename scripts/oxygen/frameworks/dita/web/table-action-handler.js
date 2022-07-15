if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsFilter(function(actionsMap, editingSupport) {
    var originalInsertTableAction = actionsMap.get('insert.table');
    if (originalInsertTableAction) {
      var insertTableAction = new sync.actions.InsertTable(
        originalInsertTableAction,
        "ro.sync.ecss.extensions.dita.topic.table.InsertTableOperation",
        editingSupport,
        [sync.actions.InsertTable.TableTypes.CALS],
        [sync.actions.InsertTable.ColumnWidthTypes.PROPORTIONAL,
          sync.actions.InsertTable.ColumnWidthTypes.DYNAMIC,
          sync.actions.InsertTable.ColumnWidthTypes.FIXED]);

      actionsMap.set('insert.table', insertTableAction);
    }

    var originalInsertTableWizardAction = actionsMap.get('insert.table.wizard');
    if (originalInsertTableWizardAction) {
      var insertTableWizardAction = new sync.actions.InsertTable(
        originalInsertTableWizardAction,
        "ro.sync.ecss.extensions.dita.topic.table.InsertTableOperation",
        editingSupport,
        [sync.actions.InsertTable.TableTypes.CALS],
        [sync.actions.InsertTable.ColumnWidthTypes.PROPORTIONAL,
          sync.actions.InsertTable.ColumnWidthTypes.DYNAMIC,
          sync.actions.InsertTable.ColumnWidthTypes.FIXED]);
      actionsMap.set('insert.table.wizard', insertTableWizardAction);
    }
    
    var originalInsertSimpletableWizardAction = actionsMap.get('insert.simpletable');
    if (originalInsertTableWizardAction) {
      var insertSimpletableWizardAction = new sync.actions.InsertTable(
        originalInsertTableWizardAction,
        "ro.sync.ecss.extensions.dita.topic.table.InsertTableOperation",
        editingSupport,
        [sync.actions.InsertTable.TableTypes.DITA_SIMPLE]);
      insertSimpletableWizardAction.getDisplayName = function() { 
        return "simpletable";
      };
      actionsMap.set('insert.simpletable', insertSimpletableWizardAction);
    }
  });
}