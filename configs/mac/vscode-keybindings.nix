[
    {
        key = "ctrl+shift+p";
        command = "workbench.action.showCommands";
    }
    {
        key = "shift+cmd+p";
        command = "-workbench.action.showCommands";
    }
    {
        key = "ctrl+p";
        command = "workbench.action.quickOpen";
    }
    {
        key = "cmd+p";
        command = "-workbench.action.quickOpen";
    }
    {
        key = "ctrl+f";
        command = "actions.find";
        when = "editorFocus || editorIsOpen";
    }
    {
        key = "cmd+f";
        command = "-actions.find";
        when = "editorFocus || editorIsOpen";
    }
    {
        key = "ctrl+h";
        command = "editor.action.startFindReplaceAction";
        when = "editorFocus || editorIsOpen";
    }
    {
        key = "alt+cmd+f";
        command = "-editor.action.startFindReplaceAction";
        when = "editorFocus || editorIsOpen";
    }
    {
        key = "ctrl+a";
        command = "editor.action.selectAll";
    }
    {
        key = "cmd+a";
        command = "-editor.action.selectAll";
    }
    {
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
    }
    {
        key = "cmd+c";
        command = "-editor.action.clipboardCopyAction";
    }
    {
        key = "ctrl+x";
        command = "editor.action.clipboardCutAction";
    }
    {
        key = "cmd+x";
        command = "-editor.action.clipboardCutAction";
    }
    {
        key = "ctrl+.";
        command = "editor.action.quickFix";
        when = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
    }
    {
        key = "cmd+.";
        command = "-editor.action.quickFix";
        when = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
    }
    {
        key = "ctrl+=";
        command = "workbench.action.zoomIn";
    }
    {
        key = "cmd+=";
        command = "-workbench.action.zoomIn";
    }
    {
        key = "ctrl+-";
        command = "workbench.action.zoomOut";
    }
    {
        key = "cmd+-";
        command = "-workbench.action.zoomOut";
    }
    {
        key = "ctrl+w";
        command = "-workbench.action.switchWindow";
    }
    {
        key = "ctrl+j";
        command = "workbench.action.togglePanel";
    }
    {
        key = "cmd+j";
        command = "-workbench.action.togglePanel";
    }
    {
        key = "ctrl+w";
        command = "workbench.action.closeActiveEditor";
    }
    {
        key = "cmd+w";
        command = "-workbench.action.closeActiveEditor";
    }
    {
        key = "ctrl+k ctrl+c";
        command = "editor.action.addCommentLine";
        when = "editorTextFocus && !editorReadonly";
    }
    {
        key = "cmd+k cmd+c";
        command = "-editor.action.addCommentLine";
        when = "editorTextFocus && !editorReadonly";
    }
    {
        key = "ctrl+k ctrl+u";
        command = "editor.action.removeCommentLine";
        when = "editorTextFocus && !editorReadonly";
    }
    {
        key = "cmd+k cmd+u";
        command = "-editor.action.removeCommentLine";
        when = "editorTextFocus && !editorReadonly";
    }
    {
        key = "ctrl+,";
        command = "workbench.action.openSettings";
    }
    {
        key = "cmd+,";
        command = "-workbench.action.openSettings";
    }
    {
        key = "ctrl+s";
        command = "workbench.action.files.save";
    }
    {
        key = "cmd+s";
        command = "-workbench.action.files.save";
    }
    {
        key = "ctrl+v";
        command = "editor.action.clipboardPasteAction";
    }
    {
        key = "cmd+v";
        command = "-editor.action.clipboardPasteAction";
    }
    {
        key = "ctrl+z";
        command = "undo";
    }
    {
        key = "cmd+z";
        command = "-undo";
    }
]