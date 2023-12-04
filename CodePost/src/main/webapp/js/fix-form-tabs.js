document.getElementById('postCodeSnippetInput').addEventListener('keydown', function(event) {
    if (event.key === 'Tab') {
        event.preventDefault(); 
        
        var textarea = event.target;
        var cursorPosition = textarea.selectionStart;
        var spaces = '    '; 
        var textBeforeCursor = textarea.value.substring(0, cursorPosition);
        var textAfterCursor = textarea.value.substring(cursorPosition);
        textarea.value = textBeforeCursor + spaces + textAfterCursor;

        textarea.selectionStart = cursorPosition + spaces.length;
        textarea.selectionEnd = cursorPosition + spaces.length;
    }
});
