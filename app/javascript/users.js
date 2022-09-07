
import Cropper from 'cropperjs';

var uploadModal = document.getElementById('upload-modal')
if(uploadModal){
  var myModal = new bootstrap.Modal(uploadModal, {
    keyboard: false,
    backdrop: 'static'
  })



  var $avatar = false
  var $company_logo = false
  var $project_logo = false
  var $preview;

  $("#avatar").change(function () {
    $avatar = true
    myModal.show()
    $preview = $('#avatar_preview')[0];
    readURL(this);
  });


  $("#company_logo").change(function () {
    $company_logo = true
    myModal.show()
    $preview = $('#company_logo_preview')[0];
    readURL(this);
  });


  $("#project_logo").change(function () {
    $project_logo = true
    $("#upload-modal").modal({
      backdrop: 'static',
      keyboard: false
    });
    myModal.show()
    $preview = $('#project_logo_preview')[0];
    readURL(this);
  });

  function crop_image_load(data) {
    data = data.detail;
    if($avatar){
      var $crop_x = $("input#avatar_crop_x")[0],
      $crop_y = $("input#avatar_crop_y")[0],
      $crop_w = $("input#avatar_crop_w")[0],
      $crop_h = $("input#avatar_crop_h")[0];
      $crop_x.value = data.x;
      $crop_y.value = data.y;
      $crop_h.value = data.height;
      $crop_w.value = data.width;
    }else if($company_logo){
      var $crop_x = $("input#company_logo_crop_x")[0],
      $crop_y = $("input#company_logo_crop_y")[0],
      $crop_w = $("input#company_logo_crop_w")[0],
      $crop_h = $("input#company_logo_crop_h")[0];
      $crop_x.value = data.x;
      $crop_y.value = data.y;
      $crop_h.value = data.height;
      $crop_w.value = data.width;
    }else if($project_logo){
      var $crop_x = $("input#project_logo_crop_x")[0],
      $crop_y = $("input#project_logo_crop_y")[0],
      $crop_w = $("input#project_logo_crop_w")[0],
      $crop_h = $("input#project_logo_crop_h")[0];
      $crop_x.value = data.x;
      $crop_y.value = data.y;
      $crop_h.value = data.height;
      $crop_w.value = data.width;
    }

  }

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#image').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  var $image = "";
  var $image = $('#image');
  var $button = $('#CropButton');
  var croppable = false;
  let cropper;


  const image = document.getElementById('image');

  $('#upload-modal').on('shown.bs.modal', function () {


    cropper = new Cropper(image, {
      aspectRatio: 1,
      viewMode: 0,
      dragMode: 'move',
      ready: function () {
        croppable = true;
      },
      crop: function (event) {
        crop_image_load(event)
      }
    });

  }).on('hidden.bs.modal', function () {
    cropper.destroy();
  });




  $button.on('click', function () {
    var croppedCanvas;
    croppedCanvas = cropper.getCroppedCanvas();
    $preview.src = croppedCanvas.toDataURL();
    $preview.setAttribute("height", "100");
    $preview.setAttribute("width", "100");

    $avatar = false
    $company_logo = false
    $project_logo = false
  });


  var show_company = $("#show_company").val()
  if(show_company == "true" || show_company == true){
    $("#company_name").attr("required", true);
    $("#company_vat_number").attr("required", true);
    $("#company_website").attr("required", true);
    $("#company_logo").attr("required", true);
    $("#company_percentage").attr("required", true);
  }

  var show_project = $("#show_project").val()
  if(show_project == "true" || show_project == true){
    $("#project_name ").attr("required", true);
    $("#project_description").attr("required", true);
    $("#project_website").attr("required", true);
    $("#project_logo").attr("required", true);
    $("#project_climate_advantage").attr("required", true);
  }

  $("#company-header").on('click', function () {
    $("#company-body").toggle();
    $("#company-body").removeClass("d-none");
    $("#company-chevron-down").toggle();
    $("#company-chevron-right").toggle();
    $("#company-chevron-down").removeClass("d-none");
    $("#company-chevron-right").removeClass("d-none");
    show_company = $("#show_company").val()
    if(show_company == "true" || show_company == true){
      show_company = false
      $("#show_company").val(show_company)
      $("#company_name").attr("required", false);
      $("#company_vat_number").attr("required", false);
      $("#company_website").attr("required", false);
      $("#company_logo").attr("required", false);
      $("#company_percentage").attr("required", false);
    }else{
      show_company = true
      $("#show_company").val(show_company)
      $("#company_name").attr("required", true);
      $("#company_vat_number").attr("required", true);
      $("#company_website").attr("required", true);
      $("#company_logo").attr("required", true);
      $("#company_percentage").attr("required", true);
    }
  });

  $("#project-header").on('click', function () {
    $("#project-body").toggle();
    $("#project-body").removeClass("d-none");
    $("#project-chevron-down").toggle();
    $("#project-chevron-right").toggle();
    $("#project-chevron-down").removeClass("d-none");
    $("#project-chevron-right").removeClass("d-none");
    show_project = $("#show_project").val()
    if(show_project == "true" || show_project == true){
      show_project = false
      $("#show_project").val(show_project)
      $("#project_name ").attr("required", false);
      $("#project_description").attr("required", false);
      $("#project_website").attr("required", false);
      $("#project_logo").attr("required", false);
      $("#project_climate_advantage").attr("required", false);
    }else{
      show_project = true
      $("#show_project").val(show_project)
      $("#project_name ").attr("required", true);
      $("#project_description").attr("required", true);
      $("#project_website").attr("required", true);
      $("#project_logo").attr("required", true);
      $("#project_climate_advantage").attr("required", true);
    }
  });

}

$(".close-flash-alert").on('click', function () {
  $("#flash-alert").hide();
});


