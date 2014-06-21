class window.AppView extends Backbone.View

  template: _.template '
    <button class="newGame" hidden>New Hand</button>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .newGame": -> @model.redeal()


  initialize: ->
    @render()

    @.model.on 'winner', (a)=>
      # $('.hit-button').prop('disabled', true);
      # $('.stand-button').prop('disabled', true);
      # @$el.first-child().detach()
      # console.log @$el.children().find('button')
      @$el.find('.newgame').show()
      @$el.find('.hit-button').hide()
      @$el.find('.stand-button').hide()
      $('body').append a
      #@render()




  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
