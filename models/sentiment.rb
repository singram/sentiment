# encoding: utf-8

import java.util.Properties

import Java.edu.stanford.nlp.ling.CoreAnnotations
import Java.edu.stanford.nlp.pipeline.Annotation
import Java.edu.stanford.nlp.pipeline.StanfordCoreNLP
import Java.edu.stanford.nlp.neural.rnn.RNNCoreAnnotations
import Java.edu.stanford.nlp.sentiment.SentimentCoreAnnotations
import Java.edu.stanford.nlp.trees.Tree
import Java.edu.stanford.nlp.util.CoreMap

# Primary class used to extract sentiment value from text
class Sentiment
  def self.extract(text)
    return nil if text.nil? || text.strip == ''
    main_sentiment = nil
    longest = 0
    annotation = nlp_pipeline.process(text)
    annotation.get(CoreAnnotations::SentencesAnnotation).each do |sentence|
      tree = sentence.get(SentimentCoreAnnotations::AnnotatedTree)
      sentiment = RNNCoreAnnotations.get_predicted_class(tree)
      parsed_text = sentence.to_s
      if parsed_text.length > longest
        main_sentiment = sentiment
        longest = parsed_text.length
      end
    end
    SentimentClassification.new(main_sentiment)
  end

  def self.nlp_pipeline
    return @nlp_pipeline if @nlp_pipeline
    props = Properties.new
    props.set_property('annotators', 'tokenize, ssplit, parse, sentiment')
    @nlp_pipeline = StanfordCoreNLP.new(props)
  end
end
