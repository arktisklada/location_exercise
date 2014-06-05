class Event < ActiveRecord::Base

  belongs_to :user
  belongs_to :state


  def self.events_for_user(user, start_date, end_date)
    # query = self.sanitize_sql_array [
    #   "SELECT b.abbreviation as title, date(a.start_date) as start FROM events AS a " + 
    #     "LEFT JOIN states AS b ON a.state_id = b.id WHERE a.user_id = ? " + 
    #     "AND (a.start_date > ? AND a.end_date < ?) " + 
    #     "GROUP BY date(a.start_date), abbreviation, a.end_date " +
    #     "ORDER BY (date(a.start_date) - date(a.end_date)) DESC",
    #   user.id,
    #   start_date,
    #   end_date
    # ]

    query = self.sanitize_sql_array [
      "SELECT title, start, rownum FROM (" +
          "SELECT b.abbreviation as title, date(a.start_date) as start, " +
            "row_number() OVER (PARTITION BY date(a.start_date) ORDER BY (date(a.end_date) - date(a.start_date)) DESC) as rownum FROM events AS a " + 
          "LEFT JOIN states AS b ON a.state_id = b.id WHERE a.user_id = ? " + 
          "AND (a.start_date > ? AND a.end_date < ?) " + 
          "GROUP BY date(a.start_date), abbreviation, a.start_date, a.end_date " +
        ") subquery WHERE rownum = 1",
      user.id,
      start_date,
      end_date
    ]

    self.connection.execute(query)
  end

  def start_date_time
    start_date ||= Time.now
    start_date.to_formatted_s(:time)
  end
  def end_date_time
    end_date ||= Time.now
    end_date.to_formatted_s(:time)
  end

end
