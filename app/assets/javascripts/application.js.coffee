#= require_tree .

$(document).ready ->
  console.log "application.js"
  $(".fancybox").fancybox
    prevEffect: 'none'
    nextEffect: 'none'
    openEffect: 'none'
    closeEffect: 'none'
    closeBtn: false
    helpers:
      title: { type : 'inside' }
      buttons: {}
