/*
 * Copyright (c) 2018 Syncro Soft SRL - All Rights Reserved.
 *
 * This file contains proprietary and confidential source code.
 * Unauthorized copying of this file, via any medium, is strictly prohibited.
 */
package com.oxygenxml.jats;

import javax.swing.text.BadLocationException;

import ro.sync.annotations.api.API;
import ro.sync.annotations.api.APIType;
import ro.sync.annotations.api.SourceType;
import ro.sync.ecss.extensions.api.ArgumentDescriptor;
import ro.sync.ecss.extensions.api.ArgumentsMap;
import ro.sync.ecss.extensions.api.AuthorAccess;
import ro.sync.ecss.extensions.api.AuthorOperation;
import ro.sync.ecss.extensions.api.AuthorOperationException;
import ro.sync.ecss.extensions.api.AuthorSchemaManager;
import ro.sync.ecss.extensions.api.node.AttrValue;
import ro.sync.ecss.extensions.api.node.AuthorDocumentFragment;
import ro.sync.ecss.extensions.api.node.AuthorElement;
import ro.sync.ecss.extensions.api.node.AuthorNode;
import ro.sync.ecss.extensions.api.schemaaware.SchemaAwareHandlerResult;
import ro.sync.ecss.extensions.commons.ImageFileChooser;

/**
 * Operation used to insert an image in JATS documents.
 */
@API(type=APIType.INTERNAL, src=SourceType.PUBLIC)
public class InsertGraphicOperation implements AuthorOperation {
  
  /**
   * The reference value argument sent by the WebAuthor.
   */
  private static final String ARGUMENT_REFERENCE_VALUE = "imageUrl";
  
  /**
   * @see ro.sync.ecss.extensions.api.AuthorOperation#doOperation(ro.sync.ecss.extensions.api.AuthorAccess, ro.sync.ecss.extensions.api.ArgumentsMap)
   */
  public void doOperation(AuthorAccess authorAccess, ArgumentsMap args)
  throws IllegalArgumentException, AuthorOperationException {
    // the Web Author passes the ref as an argument.
    String ref = (String)args.getArgumentValue(ARGUMENT_REFERENCE_VALUE);
    if (ref == null) {
      ref = ImageFileChooser.chooseImageFile(authorAccess);
    }
    if(ref != null) {
      insertImageRef(authorAccess, ref);
    }
  }

  /**
   * Insert an image reference.
   * 
   * @param authorAccess Author access
   * @param ref The image reference
   * @return The insertion result
   * @throws AuthorOperationException
   */
  public static SchemaAwareHandlerResult insertImageRef(AuthorAccess authorAccess, String ref) throws AuthorOperationException {
    SchemaAwareHandlerResult result = null;
    int caretOffset = authorAccess.getEditorAccess().getCaretOffset();
    boolean insertImageRef = true;
      try {
        AuthorNode nodeAtOffset = authorAccess.getDocumentController().getNodeAtOffset(caretOffset);
        if(nodeAtOffset.getType() == AuthorNode.NODE_TYPE_ELEMENT){
          AuthorElement elementAtOffset = (AuthorElement) nodeAtOffset;
          if("graphic".equals(elementAtOffset.getLocalName())
        		  || "inline-graphic".equals(elementAtOffset.getLocalName())){
            //Replace the fileref
            authorAccess.getDocumentController().setAttribute("xlink:href", new AttrValue(ref), elementAtOffset);
            //We have changed the reference to the image.
            insertImageRef = false;
          }
        }
      } catch (BadLocationException e) {
    	  e.printStackTrace();
      }
      if(insertImageRef) {
    	  //First try to insert an inline-graphic
    	  String inlineGraphFrag = createFragmentToInsert(ref, "inline-graphic");
    	  AuthorDocumentFragment frag = authorAccess.getDocumentController().createNewDocumentFragmentInContext(inlineGraphFrag,  caretOffset);
    	  if(frag != null && authorAccess.getDocumentController().getAuthorSchemaManager().canInsertDocumentFragment(frag, caretOffset, AuthorSchemaManager.VALIDATION_MODE_LAX)){
    		 //Insert inline-graphic 
        	  result = authorAccess.getDocumentController().insertFragmentSchemaAware(
        			  caretOffset, frag);
    	  } else {
    		  String graphicFrag = createFragmentToInsert(ref, "graphic");
    		  // Insert the graphic
    		  result = authorAccess.getDocumentController().insertXMLFragmentSchemaAware(
    				  graphicFrag,
    				  caretOffset);
    	  }
      }
    return result;
  }

  /**
   * Create a fragment to insert.
   * 
   * @param ref The href value.
   * @param elemName The element name.
   */
  private static String createFragmentToInsert(String ref, String elemName) {
	  StringBuffer fragment = new StringBuffer();
	  fragment.append("<" + elemName + " ");
	  fragment.append("xmlns:xlink=\"http://www.w3.org/1999/xlink\" ");
	  fragment.append("xlink:href=\"");
	  fragment.append(ref);
	  fragment.append("\">");
	  fragment.append("</" + elemName + ">");
	  return fragment.toString();
  }

  /**
   * No arguments. The operation will display a dialog for choosing the image fileref.
   * 
   * @see ro.sync.ecss.extensions.api.AuthorOperation#getArguments()
   */
  public ArgumentDescriptor[] getArguments() {
    return null;
  }

  /**
   * @see ro.sync.ecss.extensions.api.Extension#getDescription()
   */
  public String getDescription() {
    return "Insert a JATS image";
  }
}