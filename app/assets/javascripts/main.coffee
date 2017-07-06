# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.snack = (options)->
	document.querySelector('#global-snackbar')
					.MaterialSnackbar.showSnackbar(options)

window.loading = false

$(document).on 'turbolinks:load', ()->
	componentHandler.upgradeDom()
	$('.close-parent').on 'click', (event)->
		$(this).parent().slideUp()

	$('#notification').on 'click', (event)->
		# si las notificaciones estan visibles, preventDefault()
		event.preventDefault() if $('#notifications').hasClass('active')

		# cambiamos el estado
		$('#notifications').toggleClass('active')

		# si tiene la clase active, es porque antes no la tenia
		# si no la tiene, es porque antes si la tenia
		return false unless $('#notifications').hasClass('active')

	$(".best_in_place").best_in_place()

	$('.mdl-layout').scroll ->
		if !window.loading && $('.mdl-layout').scrollTop() > ($(document).height() / 2) - 100
			window.loading = true
			url = $('.next_page').attr('href')
			$.getScript url if url
