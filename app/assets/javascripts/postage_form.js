$(document).on('turbolinks:load', function(){
    $('#postage_company').change(function(){
        var company = $(this).val();
        if ( company == "Yamato") {
            $('#touhoku').css("display","none");
            $('#tokyo').css("display","none");
            $('#kitakyusyu').css("display","none");
            $('#minamikyusyu').css("display","none");
        }else if ( company == "Sagawa") {
            $('#touhoku').css("display","none");
            $('#tokyo').css("display","none");
            $('#kitakyusyu').css("display","block");
            $('#minamikyusyu').css("display","block");
        }else if  ( company == "Jp") {
            $('#touhoku').css("display","block");
            $('#tokyo').css("display","block");
            $('#kitakyusyu').css("display","none");
            $('#minamikyusyu').css("display","none");
        }else {
            $('#touhoku').css("display","block");
            $('#tokyo').css("display","block");
            $('#kitakyusyu').css("display","block");
            $('#minamikyusyu').css("display","block");
        }
    });
    $("[id^=postage]").change(function(){
        var company = $('#postage_company').val();
        var hokkaido = $('#postage_hokkaido').val();
        var touhoku = $('#postage_touhoku').val();
        var kitatouhoku = $('#postage_kitatouhoku').val();
        var minamitouhoku = $('#postage_minamitouhoku').val();
        var hokuriku = $('#postage_hokuriku').val();
        var shinetsu = $('#postage_shinetsu').val();
        var tokyo = $('#postage_tokyo').val();
        var kantou = $('#postage_kantou').val();
        var chubu = $('#postage_chubu').val();
        var kansai = $('#postage_kansai').val();
        var chugoku = $('#postage_chugoku').val();
        var shikoku = $('#postage_shikoku').val();
        var kyushu = $('#postage_kyushu').val();
        var kitakyushu = $('#postage_kitakyushu').val();
        var minamikyushu = $('#postage_minamikyushu').val();
        var okinawa = $('#postage_okinawa').val();
        if (company == "Yamato") {
            if ( hokkaido && kitatouhoku && minamitouhoku && hokuriku && shinetsu && kantou && chubu && kansai && chugoku && shikoku && kyushu && okinawa) {
                $('#postage_submit').prop("disabled", false);
            } else {
                $('#postage_submit').prop("disabled", true);
            }
        }else if ( company == "Sagawa") {
            if ( hokkaido && kitatouhoku && minamitouhoku && hokuriku && shinetsu && kantou && chubu && kansai && chugoku && shikoku && kitakyushu && minamikyushu && okinawa) {
                $('#postage_submit').prop("disabled", false);
            } else {
                $('#postage_submit').prop("disabled", true);
            }
        }else if  ( company == "Jp") {
            if ( hokkaido && touhoku && hokuriku && shinetsu && kantou && tokyo && chubu && kansai && chugoku && shikoku && kyushu && okinawa) {
                $('#postage_submit').prop("disabled", false);
            } else {
                $('#postage_submit').prop("disabled", true);
            }
        }else {
            $('#postage_submit').prop("disabled", true);
        }
    });
});
