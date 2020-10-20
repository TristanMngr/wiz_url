$(document).on('turbolinks:load', function() { 
  $('.new_link_form').on('ajax:success', addLinkRow)
  $('.js_delete_link').on('ajax:success', removeLinkRow)

  function addLinkRow(event) {
    const linkDatas = event.detail[0]

    if ($('.js_list_errors')) {
      $('.js_list_errors').remove()
    }

    if (linkDatas.success) {
      $('.js_table_link_list').prepend(linkDatas.partial)
      display_message(linkDatas.message, linkDatas.success)
    } else {
      display_message(linkDatas.partial, linkDatas.success)
    }

    $('.js_delete_link').on('ajax:success', removeLinkRow)
  }
})

function removeLinkRow(event) {
  const linkDatas = event.detail[0]
  const linkRowEl = $(`#${linkDatas.link_id}.link_row`)

  if (linkDatas.success && linkRowEl) {
    display_message(linkDatas.message, linkDatas.success)
    linkRowEl.remove()
  } else {
    display_message(linkDatas.message, linkDatas.success)
  }
}

function display_message(message, isSuccess) {
  messageEl = $("#message")
  innerMessageEl = $("#inner-message")

  newAlertClass = isSuccess ? 'alert-success' : 'alert-danger'
  innerMessageEl.removeClass('alert-success alert-danger').addClass(newAlertClass)

  innerMessageEl.empty()
  innerMessageEl.append(message)
  messageEl.css("display", "block")
  setTimeout(function () {
    messageEl.css("display", "none")
  }, 3000);
}


