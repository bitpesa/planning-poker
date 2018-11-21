class PokerSession::Effort < PokerSession
  STORY_POINTS = [0, 1, 2, 3, 5, 8, 13, 20, 40, 100]

  def scores
    STORY_POINTS
  end
end
