$(document).on('turbolinks:load', function(){
    $('.data-open').click(function(){
        if ($(this).hasClass("open")) {
            $(this).text("表示");
            $(this).removeClass("open");
        } else {
            $(this).text("非表示");
            $(this).addClass("open");
        }
        $(this).parent().parent().children('.postage-data').slideToggle();
    });
    $('.order-open').click(function(){
        if ($(this).hasClass("open")) {
            $(this).text("表示");
            $(this).removeClass("open");
        } else {
            $(this).text("非表示");
            $(this).addClass("open");
        }
        $(this).parent().parent().children('.order-data').slideToggle();
    });
    $('input[name="trailing_id"]').focusout(function(){
        var count = $(this).val().length;
        var id = $(this).attr('id');
        var buttonId = '#' + id + '-complete'
        if (count == 12) {
            $(buttonId).prop("disabled", false);
        } else {
            $(buttonId).prop("disabled", true);
        }
    });
    $('input[name="trailing_id"]').focusout(function(){
        var count = $(this).val().length;
        var id = $(this).attr('id');
        var buttonId = '#' + id + '-complete'
        if (count == 12) {
            $(buttonId).prop("disabled", false);
        } else {
            $(buttonId).prop("disabled", true);
        }
    });
    $('#stock_type').change(function(){
        var type = $(this).val();
        if (type == "MiddleBox" || type == "FewItemBox") {
            $('#stock_box_flag').val(true);
        }
    })
});
