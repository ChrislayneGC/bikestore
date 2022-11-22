//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require masked-input
//= require masked-money
//= require charts.min
//= require bootstrap-filestyle.min
//= require bootstrap-datepicker
//= require cocoon
//= require summernote
//= require_self
//= require codemirror
//= require codemirror/modes/ruby
//= require codemirror/modes/sass
//= require codemirror/modes/shell
//= require codemirror/modes/sql
//= require codemirror/modes/slim
//= require codemirror/modes/nginx
//= require codemirror/modes/markdown
//= require codemirror/modes/javascript
//= require codemirror/modes/http
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/haml
//= require codemirror/modes/xml
//= require codemirror/modes/css
//= require codemirror/modes/yaml
//= require codemirror/modes/slim
//= require codemirror/modes/php
//= require summernote


$('.full-height').css('height', $(window).outerHeight());

$(window).on('resize', function(){
  $('.full-height').css('height', $(window).outerHeight());
});

$(document).on('ready', function(){

  $('body').on('shown.bs.modal', function() { applyInputMasks() });

  $('.alert-dismissible').delay(3500).fadeOut(); applyInputMasks();

  $('[data-provider="summernote"]').each(function(){
  $(this).summernote({ });

  var summer_note = $('#item_text');

  summer_note.summernote;
})

});

function fileFieldStyle() {
  $('input[type=file]').filestyle({size: 'sm', input: false, buttonText: ''});
}

function applyInputMasks() {
	$('input.cpf').mask('999.999.999-99');
	$('input.cnpj').mask('99.999.999/9999-99');
	$('input.zipcode').mask('99999-999');
	$('input.date').mask('99/99/9999');
  $('input.time').mask('99:99');
  $('input.datetime').mask('99/99/9999 99:99:99');
  $('input.phone').mask('(99) 9999-9999?9');
  $('input.weight').mask('99.999');
  $('input.size').mask('999.99');
  $('input.percent').mask('999,99');
  $('input.currency').maskMoney({ thousands:'.', decimal:',' });
  $('input.phone').blur(function(event) { var target, phone, element; target = (event.currentTarget) ? event.currentTarget : event.srcElement; phone = target.value.replace(/\D/g, ''); element = $(target); element.unmask(); if(phone.length > 10) { element.mask('(99) 99999-999?9');} else { element.mask('(99) 9999-9999?9'); }});
  $('.dpicker input').datepicker({ format: 'dd/mm/yyyy' });

  return true;
};

function getZipCode(prefix) {
  var zipcode = $('.zipcode:first').val().replace('-', '');
  if(zipcode.length >= 8) {
    $.ajax({
      url: 'http://viacep.com.br/ws/'+zipcode+'/json', dataType: 'json', cache: true,
      beforeSend: function() {
        $('.zipcode:first').css({background: 'white url("/assets/hmk-loader.gif") no-repeat center right 6px', backgroundSize: '16px'});
      },
      success: function(data) {
        $('.zipcode:first').css({background: 'white url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEIAAABCCAYAAADjVADoAAADiUlEQVR4Xu2ai3ETMRCG4wpCCU4FgQowFSSpAFMBUAFOBYEKSCpIUgGmAqACTAfQAfuDxFyEpH2cTtY5uhlNnLNe+2n170rJ4qg/fwgsOoe/BDoI5wkdRAfxUBS6R3SPeBwecUxmbqg8jUTFr/Tubfj+ELfGczLymsoyAWFF738dOoh3zhNi6RE8IQrhkPIIbIU7Z2gMAr5bxzzBVz6ErXFKxmypPIkRcIAuEt/9ez13EC+dHqTszG6HYaM5g/jo3H00hLlqBPTgmsp5xt3FnjBXjQAE6EEsP/A2/XTf/+B0Ya5bA6II9V9mDASEFZVvGghz2hpcZPB2Y7vcayHMBYQUwpoMurFAmAOIMyeMqRzB2w3xfGWF0DoILkfwdiNCPBsDoWUQUggQR4jnf4coLZgWEyopBNiKMKqOEDFIrYHAEXorXM1R4hiO0RIIaXSADaPFsVUQGgjq9FniYS14hAaCOXPkYOwbBM4OWGEov+QpqgvDASUgMFkkNKpDjMAqyQFq2A3OGewFi2DcaBUOhJ8sVuwNFXMKGxn9E71bCSe+o3oIlaPzhdR4ORCxFWPv/oSGcZcqYTfF8gUtiJzbYnWwVz8LjQ6rvaYX7xVtN1T3UlHfVDXlEV+cK+Y6tUwQhyh4lfQpco6QDJYCcUuNc1dhvm9MFPUkQqoJk+jfdNMkMTpWJwVCE9YwYU5INf35eaLPD1bDtO1yYokVxIpLn5yQaiIExttSeSEduEQ9LnxqhW1Hk1pTGQpp7s9wMRuKHa01gDgQ6Eu7mmizoQKl14oj2prvHTWGh3UlILC/sdLcdVnYt0+dNe0mzR5zoCQg0F5zT2BdmL1sCT9ZKQjUv6ICJZ/qgbaUTOFV89SAQMeSREs1AVd5Sz+rRgmLRgzbaJMiCZSqiVNqQlqPQD/akMrBqJo4lQSBvqQpOAeh2lmCm4jFI9CnNaSG85n8eM0B8N9bQaC9JVkazmtDv0x+vK4BAmNYQ+qO2k564yQFUMIj/BbRXL76cVf0wXqxo7VRVH/M1vADaLPOvaXROSIlQKB/6QmziZwhBqQUCPQtyTqbEsghkJIguIscCOSJaMPuoVJJENwWaU4gp/II3+93+rAMFrVJgZwaRBhFmhXIqUGg/2Gi1axA1gDhzyLwhmYFsgYIjIGzCB7TP4DWDhylo0bt+Rcbr4NwKDuIDuLhruoe0T2ie0Q00vwGi+6UQ4PGkUEAAAAASUVORK5CYII=") no-repeat center right 6px', backgroundSize: '22px'});
        $('#'+prefix+'_street').val(data.logradouro); $('#'+prefix+'_neighborhood').val(data.bairro); $('#'+prefix+'_city').val(data.localidade); $('#'+prefix+'_state').val(data.uf); $('#'+prefix+'_number').focus();
      },
      error: function(data) {
        $('.zipcode:first').css({background: 'white url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEIAAABCCAYAAADjVADoAAACT0lEQVR4Xu3agU3DMBAFULoBbAATsEI3gA3oCIzCCLABbNAVmAA2gBE4g09KoyT23f+XFOkqRU2lxLGf72wnze4iP78Cu3T4E0iIGgkJkRCng0JGREZERsTkRJmpkamRqbFKatzKVY6yPcr2ErRqfZByn2Tby/bOugZzjFCEy1q5QwBGQXiu5X8zMVgQYwTtKCbGEEHLp2EwIOYQmBhTCFQMFKKFwMBYQqBhIBC9CAhGDwIFwwthRfBgWBBgDA+EF8GC4UGAMKwQKEIPBoLgxrBCfMiVrkmLmKmplYGg1fuUnZveulohWBExFRlMBPP6wgpRGhCBUcrVFWNvJ84dZ0YoBXkgIjDQxrvHBj3RC3GOGK5IYECcEwaEgKTGMJTZY4Y1TWAEFsSWkUFBYEJsgUFDYEOsiUFFiIBYA4OOEAURiRGCEAkRgRGGEA3BvHfQKfUgOyFPx5GV5dJ8H4EQihEBEYkQhsGGWAMhBIMJsSYCHYMFsQUCFYMBsSWCYtzLzpv1bm14PApxDgilPfAaA4G4kwq8Ir1APhfC8EIwn0GUBpSP/ouO+LgxPBBshH1t+XFLDCtEBIK+7BFZdjPKrBBfwb3GxrhqCtQDrBCMWaKVxywM0w2aFaL4IRgtBO1AFMOEUC7qgfBi9CKgGGYEBMKKYUXwYrgQUIheDC+CFcONwIBoYaAIvRgQAgtiDoOF0MKAEZgQYww2whwGBYENoRj014NVoX6HvObsnT5Hdfv/PxOi9mFCJMRpOmdEZERkRExOcZkamRqZGpkaS+vfH9T+q0NoDTTRAAAAAElFTkSuQmCC") no-repeat center right 6px', backgroundSize: '22px'});
        $('#'+prefix+'_street').val(''); $('#'+prefix+'_number').val(''); $('#'+prefix+'_neighborhood').val(''); $('#'+prefix+'_city').val(''); $('#'+prefix+'_state').val(''); $('#'+prefix+'_zipcode').focus();
      }
    });
  }
}

function CPFCNPJMask(o, f) { v_obj = o; v_fun = f; setTimeout('inputMask()', 1);}
function inputMask() { v_obj.value = v_fun(v_obj.value) }