$(document).on "page:change", ->
  $('.js-submit').on 'click', (e) ->
    e.preventDefault();
    data = $('#js-form').serialize();
    $.post( "/visitors.json", data, (( response ) ->
      console.log( response );
      $('.js-refer-token').attr('value', 'http://thearmchair.in/'+response.visitor.refer_token).select().focus();
      return
    ), "json");
    $('.js-form-container').addClass('hide');
    $('.js-confirm-container').removeClass('hide');
    return

  $('.js-refer-token').on 'click', (e) ->
    $(this).select();
    $('.js-help-text').removeClass('hide');
    return

  $('.js-refer-token').on 'blur', (e) ->
    $('.js-help-text').addClass('hide');
    return
  return