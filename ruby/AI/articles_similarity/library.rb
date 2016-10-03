class Library
  def articles
    (
      [
      'lionel_messi__forgiveness_and_the_retirement_that_divided_argentina___f',
      'champions_league_final__lionel_messi_admits_barcelona_cheering_for_atle',
      'lionel_messi_biography___childhood__life_achievements___timeline',
      'lionel_messi___wikipedia__the_free_encyclopedia',
      'being_a_developer_is_not_about_writing_code___bill_patrianakos',
      'computer_programming___wikipedia__the_free_encyclopedia',
      'python__programming_language____wikipedia__the_free_encyclopedia'
      ]
        .concat Dir.entries('articles/').reject { |file| file =~ /\.|\.\./ }
    ).uniq
  end

  def article_text(article)
    File.open("articles/#{article}", 'r') { |f| f.read }
  end

  def length
    articles.size
  end
end
