/*
 * Copyright (c) 2019 Syncro Soft SRL - All Rights Reserved.
 *
 * This file contains proprietary and confidential source code.
 * Unauthorized copying of this  file, via any medium, is strictly prohibited.
 */

if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var ACTION_ID = 'DITA/ReuseKeys';

    var reuseKeysAction = new sync.actions.ReuseDitaKeysAction('', editor, editor.getActionsManager(), 'DITA/SetDitaMap');
    editor.getActionsManager().registerAction(ACTION_ID, reuseKeysAction);

    for (var i = 0; i < actionsConfig.toolbars.length; i++) {
      var toolbar = actionsConfig.toolbars[i];
      if (toolbar.name === 'DITA') {

        var reuseContentActionIndex = goog.array.findIndex(toolbar.children, function (child) {
          return child.id === 'reuse.content';
        });

        toolbar.children.splice(reuseContentActionIndex, 0, { // insert the action after the first item (the first action is the setditamap action)
          id: ACTION_ID,
          type: 'action'
        });
        break;
      }
    }
  });
}