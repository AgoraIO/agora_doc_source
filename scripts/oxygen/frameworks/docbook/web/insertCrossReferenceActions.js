sync.actions.InsertXrefDocbook = function(delegate, editor, linkCrossReferenceOperation, crossReferenceElement) {
  sync.actions.InsertReference.call(this, delegate, editor, {});
  this.editor = editor;
  this.setOperation(linkCrossReferenceOperation);
  this.setDialogTitle(tr(msgs.CHOOSE_CROSS_REFERENCE_));
  this.crossReferenceElement = crossReferenceElement;
  this.setStartWithCurrentFile(true);
};
goog.inherits(sync.actions.InsertXrefDocbook, sync.actions.InsertReference);

/**
 * Set the operation params to be used when calling the operation which inserts the reference.
 * @param target
 * @return {object} The object containing parameters for the operation.
 */
sync.actions.InsertXrefDocbook.prototype.getOperationParams = function (target) {
  return {fragment: '<' + this.crossReferenceElement + ' linkend="' + target.id + '"/>'};
};

/**
 * Call the operation which finds reference targets in the document.
 * @param {string} chosenURL The chosen URL.
 * @return {goog.Promise} The promise.
 */
sync.actions.InsertXrefDocbook.prototype.findReferenceTargets = function (chosenURL) {
  // If same document chosen, no need to reload the document on the server side.
  var editorUrl = new sync.util.Url(this.editor.getUrl());
  var chosenUrlObj = new sync.util.Url(chosenURL);
  var sameDocChosen = editorUrl.equalsIgnoringFragment(chosenUrlObj);
  var relativeLocation = workspace.makeRelative(this.editor.getUrl(), chosenURL);
  var operation = sameDocChosen ?
    "ro.sync.servlet.operation.xreftargets.FindElementsWithIdInCurrentDocument" :
    "ro.sync.servlet.operation.xreftargets.FindElementsWithIdInDocument";

  return this.editor.getActionsManager().invokeOperation(operation, {
    relativeLocation: relativeLocation
  })
  .then(JSON.parse)
};

sync.actions.InsertXInclude = function (delegate, editor, linkCrossReferenceOperation) {
  sync.actions.InsertReference.call(this, delegate, editor, {});
  this.editor = editor;
  this.setOperation(linkCrossReferenceOperation);
  this.setDialogTitle(tr(msgs.XINCLUDE_));
};
goog.inherits(sync.actions.InsertXInclude, sync.actions.InsertReference);

/**
 * Get the operation params for the operation which inserts the xinclude.
 * @param {object} target The selected target descriptor.
 * @return {{fragment: string}} The parameters for the operation
 */
sync.actions.InsertXInclude.prototype.getOperationParams = function (target) {
  var fragment = '';
  if (target) {
    // Make selected url relative to current url.
    var url = workspace.makeRelative(this.editor.getUrl(), target.referenceUrl);
    var targetId = target.id;
    if (targetId) {
      // Remove the id fragment of the url.
      url = url.substring(0, url.indexOf('#' + targetId));
      // Add xpointer attribute.
      fragment += 'xpointer="' + targetId + '" ';
    }
    fragment += 'href="' + url + '"';
  }
  // Wrap the tag and add namespace at the end.
  if (fragment) {
    fragment = '<xi:include ' + fragment;
    fragment += ' xmlns:xi="http://www.w3.org/2001/XInclude"/>';
  }
  return {fragment: fragment};
};

/**
 * Call the operation which finds reference targets in the document.
 * @param {string} chosenURL The chosen URL.
 * @return {goog.Promise} The promise.
 */
sync.actions.InsertXInclude.prototype.findReferenceTargets = function (chosenURL) {
  // Choosing XInclude from the same file may create a circular reference and lead to errors.
  if (this.editor.getUrl().indexOf(chosenURL) !== -1) {
    return [];
  }
  // XInclude elements have relative href.
  var relativeLocation = workspace.makeRelative(this.editor.getUrl(), chosenURL);
  return this.editor.getActionsManager().invokeOperation("ro.sync.servlet.operation.xreftargets.FindElementsWithIdInDocument", {
    relativeLocation: relativeLocation,
    includeRootWithoutID: true
  }).then(JSON.parse);
};

/**
 * Add the Insert cross reference actions.
 */
goog.events.listen(workspace, sync.api.Workspace.EventType.EDITOR_LOADED, function(e) {
  var editor = e.editor;
  goog.events.listen(editor, sync.api.Editor.EventTypes.ACTIONS_LOADED, function(e) {
    var actionsManager = editor.getActionsManager();

    var insertXrefAction;
    var crossRefXrefActionId = 'insert.cross.reference.xref';
    var originalInsertCrossRefXrefAction = actionsManager.getActionById(crossRefXrefActionId);
    if (originalInsertCrossRefXrefAction) {
      insertXrefAction = new sync.actions.InsertXrefDocbook(
        originalInsertCrossRefXrefAction, editor, 'InsertOrReplaceFragmentOperation', 'xref');
      actionsManager.registerAction(crossRefXrefActionId, insertXrefAction)
    }
    var crossRefLinkActionId = 'insert.cross.reference.link';
    var originalInsertCrossRefLinkAction = actionsManager.getActionById(crossRefLinkActionId);
    if (originalInsertCrossRefLinkAction) {
      insertXrefAction = new sync.actions.InsertXrefDocbook(
        originalInsertCrossRefLinkAction, editor, 'SurroundWithFragmentOperation', 'link');
      actionsManager.registerAction(crossRefLinkActionId, insertXrefAction)
    }

    // Add xinclude action too.
    var xIncludeActionId = 'insert.xinclude';
    var originalXIncludeAction = actionsManager.getActionById(xIncludeActionId);
    if (originalXIncludeAction) {
      var insertXIncludeAction = new sync.actions.InsertXInclude(
        originalXIncludeAction, editor, 'InsertFragmentOperation');
      actionsManager.registerAction(xIncludeActionId, insertXIncludeAction)
    }
  })
});