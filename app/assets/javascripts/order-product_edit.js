$(document).on('turbolinks:load', function () {
  $("#order_product_farmer_id").change(function () {
    var farmer_id = $(this).val();
    var product_id = $("#ec_data_order_product_product_id").val();
    $.ajax({
      url: "/admin/order_products/update_shipment_week/" + farmer_id + "?product_id=" + product_id,
      type: "GET",
      dataType: "html",
      success: function (data) {
        $(".shipment_week").html(data);
      },
      error: function (data) {
        alert("error")
      }
    });
  });
});
