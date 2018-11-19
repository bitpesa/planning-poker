class PokerSession::Timebox < PokerSession
  TIMEBOX_TIMES = [
    '0.5 Days',
    '1 Day',
    '1.5 Days',
    '2 Days',
    '2.5 Days',
    '3 Days',
    '3.5 Days',
    '4 Days',
    '4.5 Days',
    '5 Days'
  ]

  def scores
    TIMEBOX_TIMES
  end
end
