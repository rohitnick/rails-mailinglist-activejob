$(document).on "page:change", ->
  $('.js-submit').on 'click', (e) ->
    e.preventDefault();
    data = $('#js-form').serialize();
    $.post( "/visitors.json", data, (( response ) ->
      $('.js-refer-token').attr('value', 'http://www.thearmchair.in/'+response.visitor.refer_token).select().focus();
      $('.fb-share-button').attr('data-href', 'http://www.thearmchair.in/'+response.visitor.refer_token);
      $('.twitter-share-button').attr('data-url', 'http://www.thearmchair.in/'+response.visitor.refer_token);
      $.getScript("http://platform.twitter.com/widgets.js");
      FB.XFBML.parse();
      setTimeout (->
        $('.js-social-share').removeClass 'hidden'
        return
      ), 900
      return
    ), "json");
    $('.js-form-container').addClass('hidden');
    $('.js-confirm-container').removeClass('hidden');
    return

  $('.js-refer-token').on 'click', (e) ->
    $(this).select();
    $('.js-help-text').removeClass('invisible');
    return

  $('.js-refer-token').on 'blur', (e) ->
    $('.js-help-text').addClass('invisible');
    return

  return