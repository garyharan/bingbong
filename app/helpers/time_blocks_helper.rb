module TimeBlocksHelper

  WEEKDAYS = %w(Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi)

  def human_weekday(weekday)
    WEEKDAYS[weekday - 1]
  end
end
