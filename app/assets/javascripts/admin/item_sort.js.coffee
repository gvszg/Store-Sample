jQuery -> 
  $("#items-sort-list").sortable
    axis: "y"
    update: ->
      $.post($(this).data("sort-url"), $(this).sortable("serialize"))