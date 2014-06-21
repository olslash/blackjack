#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    # console.log('init')
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'


    playerHand.on 'over', =>
      dealerHand.at(0).flip()
      dealerHand.stand()
    #   Dealer Stand

    playerHand.on 'stand', =>
      dealerHand.at(0).flip()
      @playDealer()


    dealerHand.on 'stand', =>
      dealerScore = dealerHand.scores()[0]
      playerScore = playerHand.scores()[0]


      if playerScore > 21
        @trigger('winner', 'Dealer Wins!')

      else if dealerScore > 21
        @trigger('winner', 'Player Wins First!')
      else
        if playerScore > dealerScore
          @trigger('winner', 'Player Wins!')
        else if dealerScore > playerScore
          @trigger('winner', 'Dealer Wins!')
        else
          @trigger('winner', 'Draw... You Lose and Suck!!')


  playDealer: ->
    dealerHand = @get 'dealerHand'
    dealerScores = dealerHand.scores()
    if dealerScores[0] < 17
      dealerHand.hit()
      @playDealer()
    else
      dealerHand.stand()

  redeal: ->
    dealerHand = @get 'dealerHand'
    playerHand = @get 'playerHand'
    console.log 'newdeal'
    @get 'deck'.over(playerHand)
    @get 'deck'.over(dealerHand)
    # deck.over(playerHand)
    # deck.over(dealerHand)



