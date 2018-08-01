$(document).on('turbolinks:load', function(){
    $('#postage_company').change(function(){
        var company = $(this).val();
        if ( company == "Yamato") {
            $('#tohoku').css("display","none");
            $('#tokyo').css("display","none");
            $('#kitakyusyu').css("display","none");
            $('#minamikyusyu').css("display","none");
        }else if ( company == "Sagawa") {
            $('#tohoku').css("display","none");
            $('#tokyo').css("display","none");
            $('#kitakyusyu').css("display","block");
            $('#minamikyusyu').css("display","block");
        }else if  ( company == "Jp") {
            $('#tohoku').css("display","block");
            $('#tokyo').css("display","block");
            $('#kitakyusyu').css("display","none");
            $('#minamikyusyu').css("display","none");
        }else {
            $('#tohoku').css("display","block");
            $('#tokyo').css("display","block");
            $('#kitakyusyu').css("display","block");
            $('#minamikyusyu').css("display","block");
        }
    });
});
