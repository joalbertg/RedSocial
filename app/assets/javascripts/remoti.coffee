$(document).on 'click', '.file-activate', (event)->
	selector = $(this).attr('for')
	$(selector).click()

$(document).on 'change', '.remotipart', (event)->
	$(this).parent().parent().submit()
