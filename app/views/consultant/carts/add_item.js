var modal = $('#modal-window'); modal.find('.modal-content').html('<%= render("add_item") %>');
$('#modal-window').appendTo("body").modal('show');
