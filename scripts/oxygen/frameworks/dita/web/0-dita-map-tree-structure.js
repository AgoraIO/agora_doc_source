/**
 * @param {HTMLElement} container Where to render the structure.
 * @param {[{name: string, type: string, children: []}]} data The tree data structure
 * @param {string} ditamapUrl The URL of the DITA Map.
 *
 * @constructor
 */
sync.dita.DitaMapTreeStructure = function(container, data, ditamapUrl) {
  var options = {
    treeRootName: 'DITA Map',
    showRoot: false,
    draggableChildren: true
  };
  this.ditamapUrl_ = ditamapUrl;
  sync.ui.TreeStructure.call(this, container, options, data);

  this.titlesPresenter_ = new sync.dita.DitaMapTitlesPresenter();
  this.titlesPresenter_.attach(this);

  this.registerDisposable(this.titlesPresenter_);

};
goog.inherits(sync.dita.DitaMapTreeStructure, sync.ui.TreeStructure);

/**
 * @override
 */
sync.dita.DitaMapTreeStructure.prototype.createNodeFromData = function(data) {
  return new sync.dita.DitaMapTreeNode(data);
};

/**
 * Find a node by a given path.
 * @param {Integer[]} path Path in tree. For second child of root is "[0,1]".
 * @return {sync.dita.DitaMapTreeStructure}
 */
sync.dita.DitaMapTreeStructure.prototype.getNodeByPath = function(path) {
  var node = this;
  for (var i = 0; i < path.length; i++) {
    var index = path[i];
    if (!node) {
      node = null;
      break;
    }
    node = node.getChildAt(index);
  }
  return node;
};

/**
 * Select current editor in DM tree.
 *
 * @param editorUrl the current editor URL.
 *
 * @private
 */
sync.dita.DitaMapTreeStructure.prototype.selectItemByUrl = function(editorUrl) {
  var editorEntry = this.getEditorTreeEntry_(this, editorUrl);
  if(editorEntry) {
    editorEntry.reveal();
    editorEntry.select();
  }
};

/**
 * Select the current editor in the tree.
 *
 * @param tree the current tree.
 * @param {String} editorUrl the current editor.
 *
 * @return {sync.ui.TreeNode} the editor entry.
 *
 * @private
 */
sync.dita.DitaMapTreeStructure.prototype.getEditorTreeEntry_ = function(tree, editorUrl) {
  var children = tree.getChildren();
  var i;
  for(i = 0; i < children.length; i++) {
    var child = children[i];
    var childUrl = child.getUrl();
    if(childUrl === editorUrl) {
      return child;
    } else {
      var found = this.getEditorTreeEntry_(child, editorUrl);
      if(found) {
        return found;
      }
    }
  }
};

/**
 * @return {String} The URL of the root map.
 */
sync.dita.DitaMapTreeStructure.prototype.getRootMap = function() {
  return this.ditamapUrl_;
};

/**
 * A node from the tree.
 * @param {Object} template The template that the node maps.
 * @constructor
 */
sync.dita.DitaMapTreeNode = function(template) {
  sync.ui.TreeNode.call(this, template);
};
goog.inherits(sync.dita.DitaMapTreeNode, sync.ui.TreeNode);

/**
 * @return {!String} Absolute url of reference.
 */
sync.dita.DitaMapTreeNode.prototype.getUrl = function() {
  var model = this.getModel();
  if(model.relativePath !== 'map' && !model.href) {
    return null;
  } else {
    return model.href;
  }
};
