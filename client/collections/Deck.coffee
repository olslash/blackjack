class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  over: (hand)->
    if hand.isDealer
      hand.set [ @pop().flip(), @pop() ]
    else
      hand.set [ @pop(), @pop() ]
    @trigger 'over'


  dealPlayer: ->
    console.log @
    new Hand [ @pop(), @pop() ], @

  dealDealer: ->
    console.log @
    new Hand [ @pop().flip(), @pop() ], @, true

