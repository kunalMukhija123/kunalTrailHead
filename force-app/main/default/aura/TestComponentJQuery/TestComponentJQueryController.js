({
	 afterScriptsLoaded: function(component, event, helper)
    {
        $("#test").draggable({
            zIndex: 999,
            revert: false,      // will cause the event to go back to its
            revertDuration: 0  //  original position after the drag
        });
    }
})