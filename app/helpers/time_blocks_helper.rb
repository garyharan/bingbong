module TimeBlocksHelper

  WEEKDAYS = %w(Lundi Mardi Mercredi Jeudi Vendredi Samedi Dimanche)

  def human_weekday(weekday)
    WEEKDAYS[weekday - 1]
  end
end
