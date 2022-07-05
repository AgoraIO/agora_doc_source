
/**
 * Presenter that enhance a tree with titles.
 * @constructor
 */
sync.dita.DitaMapTitlesPresenter = function() {
  goog.Disposable.call(this);

  /**
   * @type {Array<sync.dita.DitaMapTreeNode[]>} Stack for batches of nodes to be updated.
   */
  this.stackResolveTitles = [];

  /**
   * The max number of titles asked per request.
   * @type {number}
   */
  this.BATCH_SIZE = 35;
};
goog.inherits(sync.dita.DitaMapTitlesPresenter, goog.Disposable);

/**
 * Attach the presenter to a given tree.
 * @param {sync.dita.DitaMapTreeStructure} tree The tree to be enhanced with titles.
 */
sync.dita.DitaMapTitlesPresenter.prototype.attach = function(tree) {
  goog.events.listen(tree, goog.ui.tree.BaseNode.EventType.EXPAND, goog.bind(this.onExpand_, this));

  if (!tree.isSelected()) {
    // Initial loading strategy split expanded nodes into primary (most important) and secondary (least important) nodes.
    // Primary is considered the selected node, it's siblings and all parent nodes.
    var primaryNodes = [];
    // Secondary are considered all other nodes that are placed in DOM that are visible or can be visible after scrolling.
    // (note that children of collapsed nodes aren't put in DOM).
    var secondaryNodes = [];

    var selectedItem = tree.getSelectedItem();
    primaryNodes = primaryNodes.concat(selectedItem.getParent().getChildren());

    var parent = selectedItem;
    while (parent.getParent()) {
      parent = parent.getParent();
      if (parent instanceof sync.dita.DitaMapTreeNode) {
        primaryNodes.push(parent);
        secondaryNodes = secondaryNodes.concat(parent.getChildren());
      }
    }

    this.enqueueResolveTitles_(primaryNodes.concat(secondaryNodes));
  }
};

/**
 * Callback called when a node is expanded.
 * @param {goog.events.Event} e The expand event.
 */
sync.dita.DitaMapTitlesPresenter.prototype.onExpand_ = function(e) {
  this.enqueueResolveTitles_(e.target.getChildren());
};

/**
 * Push a given list of nodes to be resolved to the stack.
 * If the stack is empty it will start right away.
 *
 * @param {sync.dita.DitaMapTreeNode[]} nodes The nodes to be updated.
 * @private
 */
sync.dita.DitaMapTitlesPresenter.prototype.enqueueResolveTitles_ = function(nodes) {
  var batches = [];
  while(nodes.length !== 0) {
    var batch = nodes.slice(0, this.BATCH_SIZE);
    batches.push(batch);
    nodes = nodes.slice(this.BATCH_SIZE);
  }
  batches.reverse();
  this.stackResolveTitles = this.stackResolveTitles.concat(batches);

  if (!this.pendingResolveTitles_) {
    this.resolveTitles_(this.stackResolveTitles.pop());
  }
};

/**
 * Resolve title for a list of given nodes.
 * Consider using #enqueueResolveTitles_() in order to limit the number of concurrent requests.
 *
 * @param {sync.dita.DitaMapTreeNode[]} nodes The nodes to be updated.
 * @private
 */
sync.dita.DitaMapTitlesPresenter.prototype.resolveTitles_ = function(nodes) {
  if (!nodes || this.isDisposed()) {
    // Do nothing if nodes is empty or null.
    return;
  }

  var nodesToUpdate = [];
  for (var i = 0; i < nodes.length; i++) {
    var node = nodes[i];
    if (node.getUrl() && !node.getModel().titleComputed) {
      nodesToUpdate.push(
        {
          url: node.getModel().href,
          path: node.getPathForLocalization()
        });
    }
  }

  if (nodesToUpdate.length !== 0) {
    this.pendingResolveTitles_ = true;

    var mapUrl = nodes[0].getTree().getRootMap();
    var requestUrl = '../rest/ditamap/titles?map=' + encodeURIComponent(mapUrl);
    var callback = goog.bind(this.onGetTitles_, this, nodes[0].tree);
    var headers = {};
    headers[sync.rest.CSRF_HEADER] = "WA";
    headers["Content-Type"] = "application/json";

    goog.net.XhrIo.send(requestUrl, callback, "POST", JSON.stringify(nodesToUpdate), headers);
  } else {
    this.resolveTitles_(this.stackResolveTitles.pop());
  }
};

/**
 * Consume get titles request.
 * @param {sync.dita.DitaMapTreeStructure} tree The tree.
 * @param {object} e The event that contain the request.
 * @private
 */
sync.dita.DitaMapTitlesPresenter.prototype.onGetTitles_ = function(tree, e) {
  if(this.isDisposed()) {
    return;
  }
  this.pendingResolveTitles_ = false;

  var request = e.target;
  if (request.getStatus() === 200) {
    var response = request.getResponseJson();

    var paths = Object.keys(response);
    for (var i = 0; i < paths.length; i++) {
      var path = paths[i];
      var title = response[path];
      if (title !== null) {
        var node = tree.getNodeByPath(JSON.parse(path));
        this.updateTitle(node, title);
      } else {
        // When topic is not well formed.
      }
    }
  }

  this.resolveTitles_(this.stackResolveTitles.pop());
};

/**
 * Update title for a given node.
 * @param {sync.dita.DitaMapTreeNode} node To be updated.
 * @param {!string} title                  The new title.
 */
sync.dita.DitaMapTitlesPresenter.prototype.updateTitle = function(node, title) {
  node.getModel().titleComputed = true;
  if (title !== undefined) {
    node.setText(title);
    node.getModel().name = title;
  }
};
