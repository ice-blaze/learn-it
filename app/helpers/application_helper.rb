module ApplicationHelper
  # def button_to(name, options = {}, html_options = {})
  #   super(name, options, html_options.merge(:class => 'button small'))
  # end

  # def select(object, method, choices, options = {}, html_options = {})
  #   super(object, method, choices, options, {:class => 'asd'})
  # end

  # def link_to(body, url, html_options = {})
  #   super(body, url, html_options = {:class => 'button small'})
  # end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def nb_pos_vote(votes)
    count = 0
    votes.each do |vote|
      count += 1 if vote.positive
    end
    count
  end

  def nb_neg_vote(votes)
    count = 0
    votes.each do |vote|
      count += 1 unless vote.positive
    end
    count
  end
end
