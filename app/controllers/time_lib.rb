require 'date'

module TimeLib
  
  # generate list of half-hour intervals starting from now
  def TimeLib.generateListFromNow(hours)
  end

  # generate list of half-hour intervals
  #  ceiling startD,endD to half hours
  def TimeLib.generateList(startD, endD)

  end

  def TimeLib.halfHourCeiling(date)
    #DateTime.now.to_time.minute
    return date + ((30-date.minute.modulo(30)).modulo(30)).hours # this probs works
  end

end