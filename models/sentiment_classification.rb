# encoding: utf-8

# Encapsualtion of sentiment classification and helper functions
class SentimentClassification
  attr_accessor :classification

  def initialize(classification)
    @classification = classification
  end

  def to_s
    case @classification
    when 0 then 'very negative'
    when 1 then 'negative'
    when 2 then 'neutral'
    when 3 then 'positive'
    when 4 then 'very positive'
    else 'unknown'
    end
  end
end
