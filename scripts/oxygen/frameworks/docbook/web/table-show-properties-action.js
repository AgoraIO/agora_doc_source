(function() {
  if (sync.ext.Registry.extension instanceof sync.docbook.DocbookExtension) {
    sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
      var path= "/images/table-properties/";
      var frameIcons = {
        "all": path + "FrameAll.png",
        "topbot": path + "FrameTopbot.png",
        "top": path + "FrameTop.png",
        "bottom": path + "FrameBottom.png",
        "sides": path + "FrameSides.png",
        "none": path + "EmptyIcon.png",
        "<not set>": path + "EmptyIcon.png"
      };

      var separatorsIcons = {
        "0": path + 'EmptyIcon.png',
        "1": path + 'RowSep.png',
        "<not set>": path + 'EmptyIcon.png',
        "00": path + 'EmptyIcon.png',
        "0<not set>": path + 'EmptyIcon.png',
        "01": path + 'RowSep.png',
        "10": path + 'ColSep.png',
        "1<not set>": path + 'ColSep.png',
        "11": path + 'ColRowSep.png',
        "<not set>0": path + 'EmptyIcon.png',
        "<not set>1": path + 'RowSep.png',
        "<not set><not set>": path + 'EmptyIcon.png'
      };
      var alignIcons = {
        "left": path + "HalignLeft.png",
        "justify": path + "HalignJustify.png",
        "center": path + "HalignCenter.png",
        "char": path + "EmptyIcon.png",
        "right": path + "HalignRight.png",
        "<not set>": path + "EmptyIcon.png"
      };

      var ROW = [
        {
          "groupName": "Row_type",
          "attributes": [
            {
              "values": [
                "Header",
                "Body"
              ],
              "guiType": "RADIO_BUTTONS",
              "attributeName": "rowType",
              "attributeRenderString": "Row_type",
              "attribute": false
            }],
          "icons": {
            "Header": path + "RowTypeHeader.png",
            "Body": path + "RowTypeBody.png"
          }
        },
        {
          "groupName": "Vertical_alignment",
          "attributes": [{
            "values": [
              "top",
              "middle",
              "bottom",
              "<preserve>",
              "<not set>"
            ],
            "guiType": "RADIO_BUTTONS",
            "attributeName": "valign",
            "attributeRenderString": "Vertical_alignment",
            "attribute": true
          }],
          "icons": {
            "middle": path + "ValignMiddle.png",
            "top": path + "ValignTop.png",
            "bottom": path + "ValignBottom.png",
            "<not set>": path + "EmptyIcon.png"
          }
        },
        {
          "groupName": "Separators",
          "attributes": [
            {
              "values": [
                "0",
                "1",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "COMBOBOX",
              "attributeName": "rowsep",
              "attributeRenderString": "Row_separator",
              "attribute": true
            }],
          "icons": separatorsIcons
        }];

      var COLUMN = [
        {
          "groupName": "Horizontal_alignment",
          "attributes": [{
            "values": [
              "left",
              "right",
              "center",
              "justify",
              "char",
              "<preserve>",
              "<not set>"
            ],
            "guiType": "RADIO_BUTTONS",
            "attributeName": "align",
            "attributeRenderString": "Horizontal_alignment",
            "attribute": true
          }],
          "icons": alignIcons
        },
        {
          "groupName": "Separators",
          "attributes": [
            {
              "values": [
                "0",
                "1",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "COMBOBOX",
              "attributeName": "colsep",
              "attributeRenderString": "Column_separator",
              "attribute": true
            },
            {
              "values": [
                "0",
                "1",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "COMBOBOX",
              "attributeName": "rowsep",
              "attributeRenderString": "Row_separator",
              "attribute": true
            }],
          "icons": separatorsIcons
        }
      ];

      var CELL = [
        {
          "groupName": "Horizontal_alignment",
          "attributes": [
            {
              "values": [
                "left",
                "right",
                "center",
                "justify",
                "char",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "RADIO_BUTTONS",
              "attributeName": "align",
              "attribute": true,
              "attributeRenderString": "Horizontal_alignment"
            }],
          "icons": alignIcons
        },
        {
          "groupName": "Vertical_alignment",
          "attributes": [
            {
              "values": [
                "top",
                "middle",
                "bottom",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "RADIO_BUTTONS",
              "attributeName": "valign",
              "attribute": true,
              "attributeRenderString": "Vertical_alignment"
            }],
          "icons": {
            "middle": path + "ValignMiddle.png",
            "top": path + "ValignTop.png",
            "bottom": path + "ValignBottom.png",
            "<not set>": path + "EmptyIcon.png"
          }
        },
        {
          "groupName": "Separators",
          "attributes": [{
            "values": [
              "0",
              "1",
              "<preserve>",
              "<not set>"
            ],
            "guiType": "COMBOBOX",
            "attributeName": "colsep",
            "attribute": true,
            "attributeRenderString": "Column_separator"
          },
            {
              "values": [
                "0",
                "1",
                "<preserve>",
                "<not set>"
              ],
              "guiType": "COMBOBOX",
              "attributeName": "rowsep",
              "attribute": true,
              "attributeRenderString": "Row_separator"
            }],
          "icons": separatorsIcons
        }];

      var CALS = {
        "Table": [{
          "groupName": "Horizontal_alignment",
          "attributes": [{
            "values": [
              "left",
              "right",
              "center",
              "justify",
              "char",
              "<preserve>",
              "<not set>"
            ],
            "guiType": "RADIO_BUTTONS",
            "attributeName": "align",
            "attributeRenderString": "Horizontal_alignment",
            "attribute": true
          }],
          "icons": alignIcons
        },
          {
            "groupName": "Separators",
            "attributes": [
              {
                "values": [
                  "0",
                  "1",
                  "<preserve>",
                  "<not set>"
                ],
                "guiType": "COMBOBOX",
                "attributeName": "colsep",
                "attributeRenderString": "Column_separator",
                "attribute": true
              },
              {
                "values": [
                  "0",
                  "1",
                  "<preserve>",
                  "<not set>"
                ],
                "guiType": "COMBOBOX",
                "attributeName": "rowsep",
                "attributeRenderString": "Row_separator",
                "attribute": true
              }],
            "icons": separatorsIcons
          },
          {
            "groupName": "Frame",
            "attributes": [
              {
                "values": [
                  "none",
                  "all",
                  "top",
                  "topbot",
                  "bottom",
                  "sides",
                  "<preserve>",
                  "<not set>"
                ],
                "guiType": "COMBOBOX",
                "attributeName": "frame",
                "attributeRenderString": "Frame",
                "attribute": true
              }],
            "icons": frameIcons
          }],

        "Row": ROW,
        "Rows": ROW,

        "Column": COLUMN,
        "Columns": COLUMN,

        "Cell": CELL,
        "Cells": CELL
      };

      /** Wrap the original action. */
      var actionsManager = editor.getActionsManager();
      var actionId = 'show.table.properties';
      var serverAction = actionsManager.getActionById(actionId);

      if (serverAction) {
        var wrapperAction = new sync.table.ShowTablePropertiesAction(serverAction, editor);

        /** @override */
        wrapperAction.isEnabled = function() {
          var isInsideTable = false;
          // find the table ancestor.
          if(sync.select.evalSelectionFunction(sync.actions.TableAction.isInsideTableElement)) {
            // Only active for CALS tables for now.
            // informaltable is a CALS table without a title.
            var nodeAtSelection = this.editor.getSelectionManager().getSelection().getNodeAtSelection();
            var tableAncestor = this.getTableElement(nodeAtSelection);
            if (tableAncestor.getTagName() === 'table') {
              var trDescendants = tableAncestor.getElementsByTagName('tr');
              if (trDescendants.length === 0) {
                isInsideTable = true;
              }
            } else if (tableAncestor) {
              // informal table case
              isInsideTable = true;
            } else {
              // There was no table ancestor.
            }
          }
          return isInsideTable && !this.editor.getReadOnlyState().readOnly;
        };

        /** @override */
        wrapperAction.getTableInfo = function (selectedTableCells) {
          var selection = this.editor.getSelectionManager().getSelection();

          var nodeAtSelection = selection.getNodeAtSelection();
          var tableNode = this.getTableElement(nodeAtSelection);

          return this.getCalsConfig(tableNode, selectedTableCells);
        };

        /**
         *
         * @param {sync.api.Selection} selection The current selection.
         * @return {boolean} <code>true</code> if the given selection spans multiple rows in the same table.
         */
        wrapperAction.selectionSpansMultipleRows = function (selection) {
          var selectionSpansMultipleRows = false;

          var nodeAtSelectionAnchor = selection.getNodeAtSelection(true);
          var nodeAtSelection = selection.getNodeAtSelection();

          var tableNode = this.getTableElement(nodeAtSelection);

          if (nodeAtSelection.id !== nodeAtSelectionAnchor.id) {
            var selectionAncestor = this.getFirstAncestor(nodeAtSelection, 'row');
            var anchorAncestor = this.getFirstAncestor(nodeAtSelectionAnchor, 'row');

            if (selectionAncestor && anchorAncestor && selectionAncestor.id !== anchorAncestor.id) {
              var tableElement = this.getTableElement(nodeAtSelectionAnchor);
              if (tableElement) {
                selectionSpansMultipleRows = tableNode.id === tableElement.id;
              }
            }
          }

          return selectionSpansMultipleRows;
        };

        /**
         * Check if one node is a descendant of the current head element.
         * It is not considered descendant if the node is inside another table that inside the head.
         *
         * @param {sync.api.dom.Element} headNode the table head element.
         * @param {sync.api.dom.Node} node the node to test.
         *
         * @return {boolean} whether the node is a descendant of the current head element.
         */
        wrapperAction.isHeadDescendant = function(headNode, node) {
          if (! headNode) {
            return false;
          }

          var headId = headNode.id;

          var possibleHead = sync.api.dom.getAncestorElement(node, function(parentNode) {
            if (parentNode.getTagName() === 'table' || parentNode.id === headId ) {
              return parentNode;
            }
          });

          var isDescendant = false;
          if (possibleHead.id === headId) {
            isDescendant = true;
          }
          return isDescendant;
        };

        /**
         * Get the current selection node table ancestor.
         *
         * @param {sync.api.dom.Node} node the XML node.
         *
         * @return {sync.api.dom.Element} the table XML node.
         */
        wrapperAction.getTableElement = function(node) {
          return sync.api.dom.getAncestorElement(node, function(element) {
            return element.getTagName() === 'table' || element.getTagName() === 'informaltable';
          });
        };

        /**
         * Get the first ancestor which has the given tag name.
         *
         * @param {sync.api.dom.Node} nodeAtSelection the XML node.
         * @param {string} ancestorTagName The tag-name to search for.
         *
         * @return {sync.api.dom.Element} the table XML node.
         */
        wrapperAction.getFirstAncestor = function(nodeAtSelection, ancestorTagName) {
          return sync.api.dom.getAncestorElement(nodeAtSelection, function(element) {
            return element.getTagName() === ancestorTagName;
          });
        };

        /**
         * Get the first descendant of the element with the specified tag name.
         *
         * @param {sync.api.dom.Element} tableElement the XML table node.
         * @param {string} tagName The tag name of the descendant to find.
         *
         * @return {sync.api.dom.Element} the first descendant XML node.
         */
        wrapperAction.getFirstDescendantOfType = function(tableElement, tagName) {
          var descendant = null;
          var childNodes = tableElement.getChildNodes();
          var i;
          for (i = 0; i < childNodes.length; i ++) {
            var child = childNodes[i];
            var childTag = child.getTagName();
            if (childTag === tagName) {
              descendant = child;
              break;
            }
          }
          return descendant;
        };

        /**
         * Retrieves the table components which can be influenced by the current selection.
         * @param {sync.api.dom.Node} apiTableNode The selected table node.
         * @param {[sync.api.dom.Element]} selectedTableCells The selected table cells.
         * @return {{tableCells:[sync.api.dom.Element],tableRows:[sync.api.dom.Element],tableColumns:[sync.api.dom.Element]}} Lists of the selected table elements.
         */
        wrapperAction.getSelectedTableComponents = function (apiTableNode, selectedTableCells) {

          var tableRowsSet = new Set();
          var tableColumnsSet = new Set();

          goog.array.forEach(selectedTableCells, function (/** @type {sync.api.dom.Element} */ tableCell) {
            tableRowsSet.add(tableCell.getParent().id);

            var tableColumnColspecs = this.getColumnColspecs(apiTableNode, tableCell);
            goog.array.forEach(tableColumnColspecs, function (colspec) {
              tableColumnsSet.add(colspec);
            });
          }, this);

          var tableRows = [];
          var tableColumns = [];
          tableRowsSet.forEach(function (tableRow) {
            tableRows.push(sync.api.dom.createApiNode(tableRow));
          });

          tableColumnsSet.forEach(function (tableColumn) {
            tableColumns.push(sync.api.dom.createApiNode(tableColumn))
          });

          return {
            tableCells: selectedTableCells,
            tableRows: tableRows,
            tableColumns: tableColumns
          };
        };

        /**
         * Computes the current cals table configuration.
         * @param {sync.api.dom.Element} tableElement the cals table.
         * @param {[sync.api.dom.Element]} selectedTableCells The selected table cells.
         */
        wrapperAction.getCalsConfig = function (tableElement, selectedTableCells) {
          var selectedTableComponents = this.getSelectedTableComponents(tableElement, selectedTableCells);

          var config = goog.object.clone(CALS);
          var state = {
            "Table":  [],
            "Row":    [], "Rows":    [],
            "Column": [], "Columns": [],
            "Cell":   [], "Cells":   []
          };

          this.setTableState(tableElement, config, state);
          this.setRowState(selectedTableComponents.tableRows, config, state);
          this.setColumnState(selectedTableComponents.tableColumns, config, state);
          this.setCellState(selectedTableComponents.tableCells, config, state);

          return {
            state: state,
            config: config
          };
        };

        /**
         *
         * @param {sync.api.dom.Element} tableElement
         * @param {object} config
         * @param {object} state
         */
        wrapperAction.setTableState = function (tableElement, config, state) {
          var tableGroups = config['Table'];
          var tableState = state['Table'];

          var tableAlign = tableGroups[0].attributes[0];
          var tgroupElement = tableElement.getElementsByTagName('tgroup')[0];
          this.pushAttribute(tableState, tableAlign.attributeName,
            tgroupElement.getAttribute('align'), tableAlign.attribute);

          for (var i = 1; i < tableGroups.length; i ++) {
            var attributes = tableGroups[i].attributes;
            for (var j = 0; j < attributes.length; j++) {
              var attribute = attributes[j];
              this.pushAttribute(tableState, attribute.attributeName,
                tableElement.getAttribute(attribute.attributeName), attribute.attribute);
            }
          }
        };

        /**
         * Sets the initial state for the row(s) tab of the table properties dialog.
         * @param {[sync.api.dom.Element]} tableRows The selected table rows.
         * @param {object} config The table properties configuration.
         * @param {object} state The table properties state.
         */
        wrapperAction.setRowState = function (tableRows, config, state) {
          var selectionSpansMultipleRows = tableRows.length > 1;

          var rowGroups = selectionSpansMultipleRows ? config['Rows'] : config['Row'];
          var rowState = selectionSpansMultipleRows ? state['Rows'] : state['Row'];

          if (selectionSpansMultipleRows) {
            delete config['Row'];
            delete state['Row'];
          } else {
            delete config['Rows'];
            delete state['Rows'];
          }

          var rowTypes = new Set();
          var verticalAlignments = new Set();
          var rowSeps = new Set();

          goog.array.forEach(tableRows, function (rowApiElement) {
            var isInsideHead = !!sync.api.dom.getAncestorElement(rowApiElement, function(element) { return element.getTagName() === 'thead';});

            rowTypes.add(isInsideHead ? 'Header' : 'Body');
            verticalAlignments.add(rowApiElement.getAttribute('valign'));
            rowSeps.add(rowApiElement.getAttribute('rowsep'));
          }, this);

          var rowType = rowGroups[0].attributes[0];
          this.pushAttribute(rowState, rowType.attributeName,
            this.determineAttribute(rowTypes),
            rowType.attribute);

          var rowValign = rowGroups[1].attributes[0];
          this.pushAttribute(rowState, rowValign.attributeName,
            this.determineAttribute(verticalAlignments), rowValign.attribute);

          var rowRowsep = rowGroups[2].attributes[0];
          this.pushAttribute(rowState, rowRowsep.attributeName,
            this.determineAttribute(rowSeps), rowRowsep.attribute);
        };

        /**
         * Sets the initial state for the column(s) tab of the table properties dialog.
         * @param {[sync.api.dom.Element]} tableColumns The selected table columns.
         * @param {object} config The table properties configuration.
         * @param {object} state The table properties state.
         */
        wrapperAction.setColumnState = function (tableColumns, config, state) {
          if (tableColumns.length === 0) {
            // remove the Column & Columns tabs if we cannot detect the a colspec element.
            delete config['Column'];
            delete state['Column'];
            delete config['Columns'];
            delete state['Columns'];
            return;
          }

          var selectionSpansMultipleColumns = tableColumns.length > 1;

          var columnGroups = selectionSpansMultipleColumns ? config['Columns'] : config['Column'];
          var columnState = selectionSpansMultipleColumns ? state['Columns'] : state['Column'];

          if (selectionSpansMultipleColumns) {
            delete config['Column'];
            delete state['Column'];
          } else {
            delete config['Columns'];
            delete state['Columns'];
          }

          var attrs = {};
          for (var i = 0; i < columnGroups.length; ++i) {
            var groupAttributes = columnGroups[i].attributes;
            for (var j = 0; j < groupAttributes.length; j++) {
              var attribute = groupAttributes[j];
              attrs[attribute.attributeName] = new Set();
              attrs[attribute.attributeName].isAttribute = attribute.attribute;
            }
          }

          goog.array.forEach(tableColumns, function (apiTableColspec) {
            Object.keys(attrs).forEach(function (attr) {
              attrs[attr].add(apiTableColspec.getAttribute(attr));
            }, this);
          }, this);

          Object.keys(attrs).forEach(function (attr) {
            this.pushAttribute(columnState, attr, this.determineAttribute(attrs[attr]), attrs[attr].isAttribute);
          }, this);
        };

        /**
         * Sets the initial state for the cell(s) tab of the table properties dialog.
         * @param {[sync.api.dom.Element]} tableCells The selected table cells.
         * @param {object} config The table properties configuration.
         * @param {object} state The table properties state.
         */
        wrapperAction.setCellState = function (tableCells, config, state) {
          var selectionSpansMultipleCells = tableCells.length > 1;

          if (selectionSpansMultipleCells) {
            delete config['Cell'];
            delete state['Cell'];
          } else {
            delete config['Cells'];
            delete state['Cells'];
          }

          var cellGroups = selectionSpansMultipleCells ? config['Cells'] : config['Cell'];
          var cellState = selectionSpansMultipleCells ? state['Cells'] : state['Cell'];

          var attrs = {};
          for (var i = 0; i < cellGroups.length; ++i) {
            var groupAttributes = cellGroups[i].attributes;
            for (var j = 0; j < groupAttributes.length; j++) {
              var attribute = groupAttributes[j];
              attrs[attribute.attributeName] = new Set();
              attrs[attribute.attributeName].isAttribute = attribute.attribute;
            }
          }

          goog.array.forEach(tableCells, function (apiTableCell) {
            Object.keys(attrs).forEach(function (attr) {
              attrs[attr].add(apiTableCell.getAttribute(attr));
            }, this);
          }, this);

          Object.keys(attrs).forEach(function (attr) {
            this.pushAttribute(cellState, attr, this.determineAttribute(attrs[attr]), attrs[attr].isAttribute);
          }, this);
        };

        /**
         * Determines the `current value` for an attribute value.
         * @param {Set} attrValues Possible attribute values.
         */
        wrapperAction.determineAttribute = function (attrValues) {
          if (attrValues.size === 1) {
            var firstValue = null;
            attrValues.forEach(function (value) { // This is the only method of retrieving the first element from the
              firstValue = value;                 // Set which works on all browsers.
            });
            return firstValue;
          } else {
            return '<preserve>';
          }
        };

        /**
         * @param {sync.api.dom.Node} table The table.
         * @param {sync.api.dom.Element} element The element
         * @return {boolean} If the given element belongs to the given table element.
         */
        wrapperAction.elementBelongsToTable = function (table, element) {
          try {
            return !!sync.api.dom.getAncestorElement(element, function (ancestor) {
              if (ancestor.getTagName() === 'table' && ancestor.id !== table.id) {
                throw new Error(); // Found a table parent element which is not the given table.
              }

              return ancestor.id === table.id;
            });
          } catch (e) {
            return false;
          }
        };

        /**
         * Getter for the current cell's colspec element.
         *
         * @param {sync.api.dom.Node} tableElement the table element.
         * @param {sync.api.dom.Element} cellElement the current cell.
         *
         * @return {[Node]} A list of colspecs which influence the given cellElement.
         */
        wrapperAction.getColumnColspecs = function(tableElement, cellElement) {
          var colspec = null;
          var colspecEnd = null;

          var colspecs = tableElement.getElementsByTagName('colspec');
          colspecs = goog.array.filter(colspecs, goog.bind(this.elementBelongsToTable, this, tableElement));

          var colspecName = cellElement.getAttribute('colname') || cellElement.getAttribute('namest');
          var colspecNameEnd = cellElement.getAttribute('nameend');

          if (colspecName) {
            colspec = goog.array.find(colspecs, function (/** @type {sync.api.dom.Node} */ colspec) {
              return colspec.getAttribute('colname') === colspecName;
            });
          }

          if (colspecNameEnd) {
            colspecEnd = goog.array.find(colspecs, function (/** @type {sync.api.dom.Node} */ colspec) {
              return colspec.getAttribute('colname') === colspecNameEnd;
            });
          }

          if (!colspec) {
            var row = this.getFirstAncestor(cellElement, 'row');
            if (!row) {
              row = this.getFirstAncestor(cellElement, 'tr');
            }
            var entries = row.getElementsByTagName('entry');
            if (!entries.length) {
              entries = row.getElementsByTagName('td') || row.getElementsByTagName('th');
            }
            // determine the index.
            entries = goog.array.filter(entries, goog.bind(this.elementBelongsToTable, this, tableElement));

            var cellColspecIndex = 0;

            for (var i = 0; i < entries.length; ++i) {
              var entry = entries[i];

              if (String(entry.id) !== String(cellElement.id)) {
                var colspan = sync.model.XmlModel.getInstance().getXmlNodeById(entry.id).getAttribute('colspan');
                colspan = parseInt(colspan);

                if (colspan) {
                  cellColspecIndex += colspan;
                } else {
                  cellColspecIndex += 1;
                }
              } else {
                break;
              }
            }

            var stringCellColspecIndex = String(cellColspecIndex + 1); // The `colnum` attribute is indexed starting from 1
            colspec = goog.array.find(colspecs, function (/** @type {sync.api.dom.Node} */ colspec) {
              return colspec.getAttribute('colnum') === stringCellColspecIndex;
            });

            if (!colspec) {
              colspec = colspecs[cellColspecIndex];
            }
          }

          var colspecList = [];

          if (colspec) {
            colspec = sync.model.XmlModel.getInstance().getXmlNodeById(colspec.id, colspec.frameDoc);
            colspecList.push(colspec);
          }

          if (colspecEnd) {
            colspecEnd = sync.model.XmlModel.getInstance().getXmlNodeById(colspecEnd.id, colspecEnd.frameDoc);
            colspecList.push(colspecEnd);
          }

          return colspecList;
        };

        /** @override */
        wrapperAction.getOperationClass = function() {
          var nodeAtSelection = this.editor.getSelectionManager().getSelection().getNodeAtSelection();
          var tableNode = this.getTableElement(nodeAtSelection);

          var operation;
          if(tableNode) {
            operation = 'ro.sync.ecss.extensions.docbook.table.properties.' +
              'Docbook' + sync.docbook.DocbookExtension.prototype.version + 'CALSShowTablePropertiesOperation';
          }
          return operation;
        };

        /**
         * Push an attribute descriptor to the attributes array.
         *
         * @param attributesArray the array of attributes.
         * @param attributeName the attribute name.
         * @param attributeValue the attribute value.
         * @param isAttribute whether the element represents an attribute or not.
         */
        wrapperAction.pushAttribute  = function(attributesArray, attributeName, attributeValue, isAttribute) {
          attributesArray.push({
            attributeName: attributeName,
            currentValue: attributeValue || '<not set>',
            attribute: isAttribute
          });
        };

        /**
         * Register the wrapped action.
         */
        actionsManager.registerAction(actionId, wrapperAction);
      }
    });
  }
})();