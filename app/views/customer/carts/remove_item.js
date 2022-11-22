$('#result-set').html("<%= escape_javascript(render(partial: 'cart')) %>");
$('.badge-cart').text("<%= @items_count %>");
