class window.AppView extends Backbone.View

  template: _.template '
    <button class="newGame" hidden>New Hand</button>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .newGame": -> @model.redeal()


  initialize: ->
    @render()
    @.model.on 'winner', (a)=>
      @$el.find('.newgame').show()
      @$el.find('.hit-button').hide()
      @$el.find('.stand-button').hide()
      $('.winner').text(a)

    @model.on 'redeal', =>
      @$el.find('.newgame').hide()
      @$el.find('.hit-button').show()
      @$el.find('.stand-button').show()
      $('.winner').text('')



  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
