$(document ).ready(function() {
    $(".datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "-100:+0",
        dateFormat: 'dd-mm-yy'
    });
});

function fetchInterest(){
    var openingDate = $("#openingDate").val();
    //alert(''+openingDate)
    // Here we can use $.get (http://api.jquery.com/jquery.get/) 
    // OR we can use $.getJSON (http://api.jquery.com/jquery.getjson/)
    $.ajax({
        type: "GET",
        url: "/fixed_deposits/get_interest_on_date.json", // url: "controller_name/action_name.json" expecting json response
        data: { opening_date: openingDate }
    })
        .done(function( data ) {
            //alert( "Response: " + data["interest"] );
            $("#cuculated_interest").val(data["interest"])
        })
        .fail(function() {
            alert( "error" );
        })
}
