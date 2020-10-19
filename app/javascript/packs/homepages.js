console.log("initialise")

$(document).on('turbolinks:load', function() { 
  $('.new_link_form').on('ajax:success', addLinkRow)

  $('.delete_link').on('ajax:success', removeLinkRow)

  // $('.form_errors').text('')

  function addLinkRow(event) {
    // In jquery-ujs the code would work with: attributes event, data, status; 
    // in rails-ujs return only one attribute - event and additional things are accessed through array on event.details
    
    const linkDatas = event.detail[0]

    if ($('.js_list_errors')) {
      $('.js_list_errors').remove()
    }
    

    if (linkDatas.success) {
      $('.js_table_link_list').prepend(linkDatas.link_row_partial)
    } else {
      $('.js_form_errors').append(linkDatas.form_errors_partial)
    }

    $('.delete_link').on('ajax:success', removeLinkRow)
  }

  // function addLinkFormError(event) {
  //   $('.form_errors').text(event.detail[0].errors)
  // }

  

  function removeLinkRow(event) {
    const linkRowEl = $(`#${event.detail[0].link_id}.link_row`)
    if (linkRowEl) {
      linkRowEl.remove()
    }
  }
})

