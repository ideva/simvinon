class Date
  def formated_date!

    unless self.nil?
      self.to_date.strftime("%d-%m-%Y")
    end
  end

  def formated_date
    self.dup.formated_date!
  end
end